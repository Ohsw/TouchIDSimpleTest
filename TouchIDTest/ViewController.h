//
//  ViewController.h
//  TouchIDTest
//
//  Created by OHSEUNGWOOK on 2016. 4. 5..
//  Copyright © 2016년 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *touchIDAvailableCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *touchIDAuthenticationButton;
@property (weak, nonatomic) IBOutlet UIButton *touchIDAuthenticationCustomButton;


- (IBAction)checkEnableTouchID:(id)sender;
- (IBAction)authentication:(id)sender;
- (IBAction)authenticationWithCustomFallbackTitle:(id)sender;

@end

