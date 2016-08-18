//
//  LoginViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController<UITextFieldDelegate>
#pragma mark - Instance Variables
{
    NSDictionary *parameters;
}
#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *editUsername;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

#pragma mark - IBAction Methods
- (IBAction)buttonLogin:(id)sender;
- (IBAction)buttonForgotPassword:(id)sender;
- (IBAction)buttonRegisterUser:(id)sender;

@end
