//
//  MYTrstViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/17.
//

#import "MYTrstViewController.h"
#import "MyWordsModel.h"

@interface MYTrstViewController (){
    NSInteger _total;
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

@property (nonatomic,strong) MyWordsModel * model;

@end

@implementation MYTrstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - createView

- (void)createView{
    self.corfirmButton.layer.cornerRadius = self.corfirmButton.bounds.size.height / 2.0;
    self.corfirmButton.layer.masksToBounds = YES;
    
    self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.height / 2.0;
    self.cancelButton.layer.masksToBounds = YES;
    
    self.progressView.progress = 0.0;
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
    
    [self.corfirmButton setTitle:@"我认识" forState:UIControlStateNormal];
    self.confirmButtonBottom.constant = 20.0;
    self.cancelButtonHeight.constant = 50.0;
    
    self.errorButton.hidden = YES;
    self.corfirmButton.hidden = NO;
    [self.cancelButton setTitle:@"不认识" forState:UIControlStateNormal];
    
    self.progressView.progress = (float)(1.0 - (float)self.dataArray.count / (float)_total);
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
        return;
    }
    MyWordsModel * model = self.model;
    [self.dataArray removeObject:model];
    [self reloadData];
}

- (IBAction)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
