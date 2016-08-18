//
//  ForgotPasswordViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self initForgotPasswordScreen];
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

#pragma mark - Other Method Implementations
-(void)initForgotPasswordScreen
{
    [self makeCornerForButton: self.buttonReset];
    
    self.editEmail.inputAccessoryView = [self getCancelAndDoneToolbar];
    [self initTextField:self.editEmail withImageName:IMAGE_EMAIL withPlaceholder:EMAIL];
    self.editEmail.delegate=self;

}

-(void)doneButtonToolbar
{
    [self.editEmail endEditing:YES];
}
-(void)cancelButtonToolbar
{
    [self.editEmail endEditing:YES];
}

#pragma mark - Button Methods Implementation
- (IBAction)buttonBackToLoginVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonReset:(id)sender
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
            [self callForgotPasswordWebService];
        }
    }
}

#pragma mark - Validation
- (NSString *)validateFields
{
    NSString *errorMessage ;
    NSString *strEmail = [self.editEmail.text removeWhiteSpaces];
    
    if ([strEmail length] == 0)
    {
        errorMessage =@"Enter Email";
        return errorMessage;
    }
    BOOL isEmailvalid = [strEmail validateEmail];
    if (!isEmailvalid)
    {
        errorMessage =@"Invalid Email";
        return errorMessage;
    }
    
    return 0;
}

-(void)callForgotPasswordWebService
{
    parameters = @{@"email":self.editEmail.text,};

    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"users" Screen:@"forgot" AcessToken:NULL completionBlock:^(id  response,NSString *error)
     {
         //NSLog(@"FORGOT PASSWORD    :   %@",response);
         dispatch_async(dispatch_get_main_queue(),^
                        {
                            if([[response valueForKey:@"status"] integerValue] == 200)
                            {
                                [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                               {
                                                   [self resetUserDefaults];
                                                   [self dismissViewControllerAnimated:YES completion:nil];
                                               });
                            }
                            else
                                [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                        });
     }];
}

@end
