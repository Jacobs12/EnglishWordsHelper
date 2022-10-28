//
//  MYTrstViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/17.
//

#import "MYTrstViewController.h"
#import "MyWordsModel.h"
#import "GXNetworking.h"
#import <AVFoundation/AVFoundation.h>

@interface MYTrstViewController (){
    NSInteger _total;
    NSMutableArray * _listArray;
}

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelButtonHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonBottom;


@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) IBOutlet UILabel * titleLabel;
@property (nonatomic,strong) IBOutlet UILabel * subtitleLabel;
@property (nonatomic,strong) IBOutlet UIButton * corfirmButton;
@property (nonatomic,strong) IBOutlet UIButton * cancelButton;
@property (nonatomic,strong) IBOutlet UILabel * countLabel;
@property (nonatomic,strong) IBOutlet UIButton * errorButton;
@property (nonatomic,strong) IBOutlet UIProgressView * progressView;
@property (nonatomic,strong) IBOutlet UIButton * downloadButton;

@property (nonatomic,strong) AVAudioPlayer * player;

@property (nonatomic,strong) MyWordsModel * model;

@end

@implementation MYTrstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _listArray = [[NSMutableArray alloc]init];
    [self loadData];
    [self createView];
}

#pragma mark  - getters

- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (AVAudioPlayer *)player{
    if(_player == nil){
        _player = [[AVAudioPlayer alloc] init];//使用NSData创建
    }
    return _player;
}

#pragma mark - createView

- (void)createView{
    self.corfirmButton.layer.cornerRadius = self.corfirmButton.bounds.size.height / 2.0;
    self.corfirmButton.layer.masksToBounds = YES;
    
    self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.height / 2.0;
    self.cancelButton.layer.masksToBounds = YES;
    
    self.progressView.progress = 0.0;
    
    self.titleLabel.text = @"";
    self.subtitleLabel.text = @"";
}

#pragma mark - load data

- (void)loadData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@words",self.id1] ofType:@"plist"];
        NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSArray * array = dict[@"list"];
        for (NSDictionary * item in array) {
            MyWordsModel * model = [[MyWordsModel alloc]init];
            [model setValuesForKeysWithDictionary:item];
            if(model.en == nil || [model.en isEqualToString:@""]){
                continue;
            }
            [self.dataArray addObject:model];
        }
        self->_total = self.dataArray.count;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    });
}

- (void)reloadData{
    if(self.dataArray.count == 0){
        self.subtitleLabel.hidden = YES;
        self.titleLabel.text = @"本次测试已完成";
        self.countLabel.text = [NSString stringWithFormat:@"共：%ld      剩：%ld",_total,self.dataArray.count];
        
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy-MM-dd";
        NSString * date = [df stringFromDate:[NSDate date]];
        NSString * key = [NSString stringWithFormat:@"%@",self.id1];
        
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:key];
        return;
    }
    NSInteger index = random() % self.dataArray.count;
    if(index > self.dataArray.count - 1){
        return;
    }
    MyWordsModel * model = self.dataArray[index];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.en];
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@",model.chn];
    self.model = model;
    self.subtitleLabel.hidden = YES;
    self.countLabel.text = [NSString stringWithFormat:@"共：%ld      剩：%ld",_total,self.dataArray.count];
    
//    发音 http://dict.youdao.com/dictvoice?type=0&audio=
    [self getAudioWithString:model.en];
    
    [self.corfirmButton setTitle:@"我认识" forState:UIControlStateNormal];
    self.confirmButtonBottom.constant = 20.0;
    self.cancelButtonHeight.constant = 50.0;
    
    self.errorButton.hidden = YES;
    self.corfirmButton.hidden = NO;
    [self.cancelButton setTitle:@"不认识" forState:UIControlStateNormal];
    
    self.progressView.progress = (float)(1.0 - (float)self.dataArray.count / (float)_total);
}

- (void)getAudioWithString:(NSString *)string{
    NSString * cachePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Library/Caches/audio/%@",self.id1]];
    if([[NSFileManager defaultManager] fileExistsAtPath:cachePath] == NO){
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:@{} error:nil];
    }
    NSString * filePath = [NSString stringWithFormat:@"%@/%@.mp3",cachePath,string];
    NSLog(@"%@",filePath);
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(isExist == YES){
        NSData * data = [[NSData alloc]initWithContentsOfFile:filePath];
        if(data && data.length > 10){
            [self playWithData:data];
            return;
        }
    }
    
//    发音 http://dict.youdao.com/dictvoice?type=0&audio=
    NSString * url = [NSString stringWithFormat:@"http://dict.youdao.com/dictvoice?type=0&audio=%@",string];
    [GXNetworking GETWithHost:url headers:@{} finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self playWithData:responseData];
            if(responseData && responseData.length > 10){
                [responseData writeToFile:filePath atomically:NO];
            }
        });
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        
    }];
}

- (void)playWithData:(NSData *)data{
    if(self.player){
        self.player = nil;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:data error:nil];//使用NSData创建
    self.player = player;
    [self.player prepareToPlay];
    [self.player play];
}

#pragma mark - actions

- (IBAction)cancelButtonClick:(id)sender{
    if(self.dataArray.count == 0){
        return;
    }
    if(self.subtitleLabel.hidden == YES){
        self.subtitleLabel.hidden = NO;
        self.corfirmButton.hidden = YES;
        [self.cancelButton setTitle:@"下一个" forState:UIControlStateNormal];
        [self getAudioWithString:self.model.en];
        return;
    }
    [self reloadData];
}

- (IBAction)confirmButtonClick:(id)sender{
    if(self.dataArray.count == 0){
        return;
    }
    if(self.model == nil){
        return;
    }
    if(self.subtitleLabel.hidden == YES){
        self.subtitleLabel.hidden = NO;
        [self.corfirmButton setTitle:@"下一个" forState:UIControlStateNormal];
        self.confirmButtonBottom.constant = 0.0;
        self.cancelButtonHeight.constant = 0.0;
        self.errorButton.hidden = NO;
        [self getAudioWithString:self.model.en];
        return;
    }
    MyWordsModel * model = self.model;
    [self.dataArray removeObject:model];
    [self reloadData];
}

- (IBAction)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)downloadButtonClick:(id)sender{
    if(_listArray.count != 0){
        [self.downloadButton setTitle:@"下载中" forState:UIControlStateNormal];
        return;
    }
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    NSMutableArray * wordsArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary * item in self.categories) {
        NSString * categoryID = item[@"id"];
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@words",categoryID] ofType:@"plist"];
        NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSArray * array = dict[@"list"];
        for (NSDictionary * item in array) {
            MyWordsModel * model = [[MyWordsModel alloc]init];
            [model setValuesForKeysWithDictionary:item];
            model.status = categoryID;
            if(model.en == nil || [model.en isEqualToString:@""]){
                continue;
            }
            [wordsArray addObject:model];
        }
    }
    [_listArray addObjectsFromArray:wordsArray];
    [self startDownload];
}

- (void)startDownload{
    if(_listArray.count == 0){
        return;
    }
    MyWordsModel * model = _listArray[0];
    [self downloadAudioWithID:model.status string:model.en];
}

- (void)downloadAudioWithID:(NSString *)categoryID string:(NSString *)string{
    NSString * cachePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Library/Caches/audio/%@",categoryID]];
    if([[NSFileManager defaultManager] fileExistsAtPath:cachePath] == NO){
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:@{} error:nil];
    }
    NSString * filePath = [NSString stringWithFormat:@"%@/%@.mp3",cachePath,string];
    NSLog(@"%@",filePath);
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(isExist == YES || [string containsString:@" "]){
        [self removeObjectWithString:string];
        return;
    }
    NSString * url = [NSString stringWithFormat:@"http://dict.youdao.com/dictvoice?type=0&audio=%@",string];
    [GXNetworking GETWithHost:url headers:@{} finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        if(responseData && responseData.length > 10){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [responseData writeToFile:filePath atomically:NO];
                [self removeObjectWithString:string];
            });
        }
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
            [self removeObjectWithString:string];
            [self.downloadButton setTitle:@"下载出现错误" forState:UIControlStateNormal];
    }];
}

- (void)removeObjectWithString:(NSString *)string{
    MyWordsModel * model = nil;
    for (MyWordsModel * item in _listArray) {
        if([string isEqualToString:item.en]){
            model = item;
            break;
        }
    }
    if(model){
        [_listArray removeObject:model];
    }
    NSString * title = [NSString stringWithFormat:@"%@下载已完成，剩余%ld",string,_listArray.count];
    [self.downloadButton setTitle:title forState:UIControlStateNormal];
    [self startDownload];
}
    

@end
