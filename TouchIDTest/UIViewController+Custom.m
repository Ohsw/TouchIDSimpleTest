//
//  UIViewController+Custom.m
//  TouchIDTest
//
//  Created by OHSEUNGWOOK on 2016. 4. 5..
//  Copyright © 2016년 . All rights reserved.
//

#import "UIViewController+Custom.h"

@implementation UIViewController (Custom)

- (void)setNavigationTitle:(NSString *)naviTitle
{
	[self.navigationItem setTitle:naviTitle];
}

- (void)setNavigationBackButton
{
	UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
	[backButton setBackgroundImage:[UIImage imageNamed:@"main_gnb_back.png"] forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	[self.navigationItem setLeftBarButtonItem:backBarButtonItem];
}

- (void)popViewController
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
