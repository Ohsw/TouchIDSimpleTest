//
//  ViewController.m
//  TouchIDTest
//
//  Created by OHSEUNGWOOK on 2016. 4. 5..
//  Copyright © 2016년 . All rights reserved.
//

#import "ViewController.h"
#import "SuccessViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self isEnableTouchID:NO];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)showAlertMessage:(NSString *)message
{
	if (message == nil || [message length] == 0) {
		return;
	}
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Touch ID Test"
																   message:message
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:okAction];
	[self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)checkEnableTouchID:(id)sender
{
	LAContext *context = [[LAContext alloc] init];
	NSError *error = nil;
	
	if ([context respondsToSelector:@selector(canEvaluatePolicy:error:)]) {
		
		BOOL isEnableTouchID = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
													error:&error];
		
		
		[self isEnableTouchID:isEnableTouchID];
		
		NSMutableString *message = [[NSMutableString alloc] initWithString:@"Touch ID is available"];
		
		if (error != nil || !isEnableTouchID) {
			
			message = [[NSMutableString alloc] initWithString:@"Touch ID not available"];
			
			if (error != nil) {
				[message appendFormat:@"\n%@", error.localizedDescription];
			}
		}
		
		[self showAlertMessage:message];
		
	}
}

- (IBAction)authentication:(id)sender
{
	LAContext *context = [[LAContext alloc] init];
	[context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
			localizedReason:@"Unlock access to locked feature"
					  reply:^(BOOL success, NSError * _Nullable error) {
							 
						  dispatch_async(dispatch_get_main_queue(), ^{
							  
							  if (success) {
								  
								  [self touchIDLoginSuccess];
								  
							  } else {
								  
								  NSString *message = [self userAuthenticationFailed:error];
								  [self showAlertMessage:message];
							  }
							  
						  });
						  
					  }];
}

- (IBAction)authenticationWithCustomFallbackTitle:(id)sender
{
	LAContext *context = [[LAContext alloc] init];
	context.localizedFallbackTitle = @"Enter PIN";
	[context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
			localizedReason:@"Unlock access to locked feature"
					  reply:^(BOOL success, NSError * _Nullable error) {
							 
							  dispatch_async(dispatch_get_main_queue(), ^{
								  
								 if (success) {
									 
									 [self touchIDLoginSuccess];
									 
								 } else {
									 
									 NSString *message = [self userAuthenticationFailed:error];
									 [self showAlertMessage:message];
								 }
								  
							  });
						 }];
}

- (NSString *)userAuthenticationFailed:(NSError *)error
{
	[self isEnableTouchID:NO];
	
	NSString *authErrorMessage = @"";
	
	switch (error.code) {
		case LAErrorAuthenticationFailed:
			authErrorMessage = @"failed";
			break;
			
		case LAErrorUserCancel:
			authErrorMessage = @"canceled by user";
			break;
			
		case LAErrorUserFallback:
			authErrorMessage = @"user wants to enter password";
			break;
			
		case LAErrorSystemCancel:
			authErrorMessage = @"canceled by system";
			break;
			
		case LAErrorPasscodeNotSet:
			authErrorMessage = @"TouchID is not available";
			break;
			
		default:
			authErrorMessage = @"TouchID is not available";
			break;
	}
	
	return authErrorMessage;
}

- (void)isEnableTouchID:(BOOL)isEnableTouchID
{
	[self.touchIDAuthenticationButton setEnabled:isEnableTouchID];
	[self.touchIDAuthenticationCustomButton setEnabled:isEnableTouchID];
	
	[self.touchIDAuthenticationButton setAlpha:isEnableTouchID ? 1.0f : 0.3f];
	[self.touchIDAuthenticationCustomButton setAlpha:isEnableTouchID ? 1.0f : 0.3f];
}

- (void)touchIDLoginSuccess
{
	SuccessViewController *successViewController = (SuccessViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SuccessView"];
	[self.navigationController pushViewController:successViewController animated:YES];
}

@end
