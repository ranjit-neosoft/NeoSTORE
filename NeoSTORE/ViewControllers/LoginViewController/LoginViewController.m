//
//  LoginViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [self initLoginScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:YES];
}

#pragma mark - Other Method Implementations
-(void)initLoginScreen
{
    [self makeCornerForButton: self.buttonLogin];
    self.editUsername.delegate=self;
    self.editPassword.delegate=self;
    self.editUsername.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editPassword.inputAccessoryView = [self getCancelAndDoneToolbar];
    [self initTextField:self.editUsername withImageName:IMAGE_USER withPlaceholder:EMAIL];
    [self initTextField:self.editPassword withImageName:IMAGE_PASSWORD withPlaceholder:PASSWORD];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
    [self.editUsername endEditing:YES];
    [self.editPassword endEditing:YES];
}

#pragma mark - Button Methods Implementation
- (IBAction)buttonLogin:(id)sender
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
            [self callLoginWebService];
        }
    }
}

#pragma mark - Validation
- (NSString *)validateFields
{
    NSString *errorMessage ;
    NSString *strEmail = [self.editUsername.text removeWhiteSpaces];
    NSString *strPassword = [self.editPassword.text removeWhiteSpaces];
    if ([strEmail length] == 0)
    {
        errorMessage =ENTER_USERNAME;
        return errorMessage;
    }
    BOOL isEmailvalid = [strEmail validateEmail];
    if (!isEmailvalid)
    {
        errorMessage =@"Invalid Email";
        return errorMessage;
    }
    if ([strPassword length] == 0)
    {
        errorMessage = @"Enter Password";
        return errorMessage;
    }
    return 0;
}

-(void)callLoginWebService
{
    parameters = @{@"email":self.editUsername.text, @"password":self.editPassword.text,};
    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"users" Screen:@"login" AcessToken:NULL completionBlock:^(id  response,NSString *error)
     {
         dispatch_async(dispatch_get_main_queue(),^
                        {
                            if([[response valueForKey:@"status"] integerValue] == 200)
                            {
                                [self setUserDefaults:[response valueForKey:@"data"] withVC:LOGIN_VIEW_CONTROLLER_ID];
                                AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                [appDelegate showHomeNavigation];
                            }
                            else
                                [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                        });
     }];
}

- (IBAction)buttonForgotPassword:(id)sender
{
    ForgotPasswordViewController *vc = (ForgotPasswordViewController *)  [Utils instantiateViewControllerWithId:FORGOT_PASSWORD_VIEW_CONTROLLER_ID];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)buttonRegisterUser:(id)sender
{
    RegisterViewController *vc = (RegisterViewController *) [Utils instantiateViewControllerWithId:REGISTER_VIEW_CONTROLLER_ID];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
