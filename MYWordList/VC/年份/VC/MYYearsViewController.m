//
//  MYYearsViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import "MYYearsViewController.h"
#import "MYTrstViewController.h"

@interface MYYearsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation MYYearsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createView];
}

#pragma mark - createView

- (void)createView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

#pragma mark - getters

- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [[NSMutableArray alloc]init];
        NSArray * array = @[
            @{@"id":@"2011",@"title":@"2011年生僻单词"},
            @{@"id":@"2012",@"title":@"2012年生僻单词"},
            @{@"id":@"2013",@"title":@"2013年生僻单词"},
            @{@"id":@"2014",@"title":@"2014年生僻单词"},
            @{@"id":@"2015",@"title":@"2015年生僻单词"},
            @{@"id":@"2016",@"title":@"2016年生僻单词"},
            @{@"id":@"2017",@"title":@"2017年生僻单词"},
            @{@"id":@"2018",@"title":@"2018年生僻单词"},
            @{@"id":@"2019",@"title":@"2019年生僻单词"},
            @{@"id":@"2020",@"title":@"2020年生僻单词"},
            @{@"id":@"2021",@"title":@"2021年生僻单词"},
            @{@"id":@"2022",@"title":@"2022年生僻单词"},
        ];
        [_dataArray addObjectsFromArray:array];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary * dict = self.dataArray[indexPath.row];
    NSString * string = dict[@"title"];
    cell.textLabel.text = string;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * item = self.dataArray[indexPath.row];
    NSString * id1 = item[@"id"];
    if(self.type == MyListTypeWhole){
        MYWholeWordsViewController * vc = [[MYWholeWordsViewController alloc]init];
        vc.id1 = id1;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MYTrstViewController * vc = [[MYTrstViewController alloc]init];
        vc.id1 = id1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
