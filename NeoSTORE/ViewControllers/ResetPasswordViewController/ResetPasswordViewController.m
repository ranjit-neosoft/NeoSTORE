//
//  ResetPasswordViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self initResetPasswordView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showStatusBarOnViewController];
}

-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:RESET_PASSWORD_VIEW_CONTROLLER_ID];
    self.navigationItem.title = RESET_PASSWORD;
    [self addBackButtonOnNavigationBar];
}

-(void)initResetPasswordView
{
    [self makeCornerForButton: self.buttonResetPassword];
    self.editCurrentPassword.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editNewPassword.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editConfirmPassword.inputAccessoryView = [self getCancelAndDoneToolbar];

    [self initTextField:self.editCurrentPassword withImageName:IMAGE_PASSWORD withPlaceholder:CURRENT_PASSWORD];
    [self initTextField:self.editNewPassword withImageName:IMAGE_PASSWORD_UNLOCK withPlaceholder:NEW_PASSWORD];
    [self initTextField:self.editConfirmPassword withImageName:IMAGE_PASSWORD withPlaceholder:CONFIRM_PASSWORD];
}

-(void)doneButtonToolbar
{
    [self callTextFieldEndEditing];
}

-(void)cancelButtonToolbar
{
    [self callTextFieldEndEditing];
}

-(void)callTextFieldEndEditing
{
    [self.editCurrentPassword endEditing:YES];
    [self.editNewPassword endEditing:YES];
    [self.editConfirmPassword endEditing:YES];
}

- (IBAction)buttonResetPassword:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        NSString *errorMessage = [self validateFields];
        if (errorMessage)
        {
            [CustomAlertView showAlertWithOk:NeoSTORE withMessage:errorMessage];
        }
        else
        {
            [self callResetPasswordWebService];
        }
    }
}
#pragma mark - Validation
- (NSString *)validateFields
{
    NSString *errorMessage ;
    
    NSString *strCurrentPassword = [self.editCurrentPassword.text removeWhiteSpaces];
    NSString *strNewPassword = [self.editNewPassword.text removeWhiteSpaces];
    NSString *strConfirmPassword = [self.editConfirmPassword.text removeWhiteSpaces];
    
    if ([strCurrentPassword length] == 0)
    {
        errorMessage =@"Enter Current Password";
        return errorMessage;
    }
    
    if ([strNewPassword length] == 0)
    {
        errorMessage =@"Enter New Password";
        return errorMessage;
    }
    BOOL isPasswordlvalid = [self isPasswordValid:strNewPassword];
    if (!isPasswordlvalid)
    {
        errorMessage =@"Password contains 6 to 16 characters. one uppercase letter and one lowercase letter.";
        return errorMessage;
    }
    
    if ([strConfirmPassword length] == 0)
    {
        errorMessage =@"Enter Confirm Password";
        return errorMessage;
    }
    BOOL isPasswordMatch = [self isPasswordMatch:strNewPassword withConfirmPwd:strConfirmPassword];
    if (!isPasswordMatch)
    {
        errorMessage =@"Password not match";
        return errorMessage;
    }
    return 0;
}

-(void)callResetPasswordWebService
{
        parameters = @{@"old_password":self.editCurrentPassword.text, @"password":self.editNewPassword.text, @"confirm_password":self.editConfirmPassword.text,};
    
        [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"users" Screen:@"change" AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
         {
             //NSLog(@"RESET PASSWORD  :   %@",response);
             dispatch_async(dispatch_get_main_queue(),^
                            {
                                if([[response valueForKey:@"status"]integerValue] == 200)
                                {
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                                   {
                                                       [self resetUserDefaults];
                                                       AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                                       [appDelegate showLoginViewController];
                                                   });
                                }
                                else
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                            });
         }];
}

@end
