//
//  CDViewController.m
//  Plan-it Med
//
//  Created by Ngoc Nguyen Vuong on 5/24/13.
//  Copyright (c) 2013 Ngoc Nguyen Vuong. All rights reserved.
//

#import "LoginViewController.h"
#import "Reachability.h"
#import "User.h"
#import "CDAppDelegate.h"
#import "Schedule.h"
#import "SIAlertView.h"
#import "AlertView.h"
#import <KiipSDK/KiipSDK.h>

@interface LoginViewController ()  <UIAlertViewDelegate, UITextFieldDelegate>

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    
    Reachability *reach = [Reachability reachabilityWithHostname:BASE_HOSTNAME];
    [reach startNotifier];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction
- (IBAction)loginButtonPressed:(id)sender {
    //[[Kiip sharedInstance] saveMoment:@"login Moment" withCompletionHandler:nil];
    
    NSLog(@"begin login");
    NSString *userName = self.userNameTextfield.text;
    NSString *password = self.passwordTextfield.text;
    if ([userName isEqualToString:@""] || [password isEqualToString:@""]) {
        AlertView *alert = [[AlertView alloc] initWithTitle:@"Plan-it Med" message:@"Please fill out userName or password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [User loginWithUserName:userName password:password withBlock:^(User *user, NSString *message, NSError *error) {
            if (user) {
                
                NSLog(@"user: %@",user);
                NSLog(@"get user");
                [self performSegueWithIdentifier:@"login" sender:self];
                
            } else {
                AlertView *alert = [[AlertView alloc] initWithTitle:@"Plan-it Med" message:[NSString stringWithFormat:@"Login fail, error:%@",message] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alert show];
            }
            
            NSLog(@"out");
        }];
    }
}

- (IBAction)createAccountButtonPressed:(id)sender {
    
}


#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

- (IBAction)submit:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"Submit"]) {
        NSLog(@"Submit");
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"dismiss");
        }];
    }
}



#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextfield || textField == self.passwordTextfield) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex: %d",buttonIndex);
}



#pragma mark others
- (void)showAlert
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"SIAlertView" andMessage:@"Sumi Interactive"];
    
    [alertView addButtonWithTitle:@"Button1"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Button1 Clicked");
                          }];
    [alertView addButtonWithTitle:@"Button2"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Button2 Clicked");
                          }];
    [alertView addButtonWithTitle:@"Button3"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Button3 Clicked");
                          }];
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}

@end
