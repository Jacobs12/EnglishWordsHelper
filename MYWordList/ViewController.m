//
//  ViewController.m
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import "ViewController.h"
#import "MYYearsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark - actions

- (IBAction)allButtonClick:(id)sender{
    MYYearsViewController * vc = [[MYYearsViewController alloc]init];
    vc.type = MyListTypeWhole;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)testButtonClick:(id)sender{
    MYYearsViewController * vc = [[MYYearsViewController alloc]init];
    vc.type = MyListTypeTest;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
