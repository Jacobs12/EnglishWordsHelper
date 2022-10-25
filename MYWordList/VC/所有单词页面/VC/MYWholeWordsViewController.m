//
//  MYWholeWordsViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import "MYWholeWordsViewController.h"
#import "MYWordListTableViewCell.h"

@interface MYWholeWordsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation MYWholeWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createView];
    [self loadDataCompletion:^(BOOL isSuccess) {
        
    }];
}

#pragma mark - createView

- (void)createView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - getters

- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MYWordListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MYWordListTableViewCell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MYWordListTableViewCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyWordsModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWordsModel * model = self.dataArray[indexPath.row];
    CGFloat height = [model viewHeight];
    return height;
}

#pragma mark - data

- (void)loadDataCompletion:(void (^) (BOOL isSuccess))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@words",self.id1] ofType:@"plist"];
        NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        NSArray * array = dict[@"list"];
        for (NSDictionary * item in array) {
            MyWordsModel * model = [[MyWordsModel alloc]init];
            [model setValuesForKeysWithDictionary:item];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (IBAction)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
