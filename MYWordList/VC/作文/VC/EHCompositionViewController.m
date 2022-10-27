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
    [self createView];
    [self loadData];
}

#pragma mark - create view

- (void)createView{
    self.textView.editable = NO;
}

#pragma mark - load data

- (void)loadData{
    
}

#pragma mark - actions

- (IBAction)backButtonClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
