//
//  EHCompositionViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/27.
//

#import "EHCompositionViewController.h"

@interface EHCompositionViewController ()

@property (nonatomic,strong) IBOutlet UITextView * textView;

@end

@implementation EHCompositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self createView];
    [self loadData];
}

#pragma mark - create view

- (void)createView{
    self.textView.editable = NO;
    self.textView.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
}

#pragma mark - load data

- (void)loadData{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"composition" ofType:@"txt"];
    NSString * composition = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing = 8.0;
    NSDictionary * options = @{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:17.0 weight:UIFontWeightRegular]};
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:composition];
    [attributedString addAttributes:options range:NSMakeRange(0, composition.length)];
    self.textView.attributedText = attributedString;
}

#pragma mark - actions

- (IBAction)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
