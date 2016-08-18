//
//  RegisterViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate>
#pragma mark - Instance Variables
{
    NSString *userGender;
    NSDictionary *parameters;
}

#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editPassword;
@property (weak, nonatomic) IBOutlet UITextField *editConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *editPhoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *buttonRegisterClick;
@property (weak, nonatomic) IBOutlet UIButton *buttonMaleClick;
@property (weak, nonatomic) IBOutlet UIButton *buttonFemaleClick;
@property (weak, nonatomic) IBOutlet UIButton *buttonAgreeClick;

#pragma mark - IBAction Methods
- (IBAction)buttonBackToLoginVC:(id)sender;
- (IBAction)buttonRegisterClick:(id)sender;
- (IBAction)buttonMaleClick:(id)sender;
- (IBAction)buttonFemaleClick:(id)sender;
- (IBAction)buttonAgreeClick:(id)sender;

@end
