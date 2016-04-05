//
//  SuccessViewController.m
//  TouchIDTest
//
//  Created by OHSEUNGWOOK on 2016. 4. 5..
//  Copyright © 2016년 . All rights reserved.
//

#import "SuccessViewController.h"
#import "UIViewController+Custom.h"

@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self setNavigationTitle:@"TouchID Success View"];
	[self setNavigationBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)handleTapGesture:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
