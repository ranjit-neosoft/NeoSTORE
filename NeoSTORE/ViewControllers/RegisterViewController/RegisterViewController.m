//
//  RegisterViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self initRegisterScreen];
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
-(void)initRegisterScreen
{
    [self makeCornerForButton: self.buttonRegisterClick];
    self.editFirstName.delegate = self;
    self.editLastName.delegate = self;
    self.editEmail.delegate = self;
    self.editPassword.delegate = self;
    self.editConfirmPassword.delegate = self;
    self.editPhoneNumber.delegate = self;
    
    self.editFirstName.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editLastName.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editEmail.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editPassword.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editConfirmPassword.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editPhoneNumber.inputAccessoryView = [self getCancelAndDoneToolbar];
    
    [self initTextField:self.editFirstName withImageName:IMAGE_USER withPlaceholder:FIRST_NAME];
    [self initTextField:self.editLastName withImageName:IMAGE_USER withPlaceholder:LAST_NAME];
    [self initTextField:self.editEmail withImageName:IMAGE_EMAIL withPlaceholder:EMAIL];
    [self initTextField:self.editPassword withImageName:IMAGE_PASSWORD_UNLOCK withPlaceholder:PASSWORD];
    [self initTextField:self.editConfirmPassword withImageName:IMAGE_PASSWORD withPlaceholder:CONFIRM_PASSWORD];
    [self initTextField:self.editPhoneNumber withImageName:IMAGE_PHONE withPlaceholder:PHONE_NUMBER];
    self.buttonMaleClick.selected = TRUE;
    userGender = GENDER_MALE;
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
    [self.editFirstName endEditing:YES];
    [self.editLastName endEditing:YES];
    [self.editEmail endEditing:YES];
    [self.editPassword endEditing:YES];
    [self.editConfirmPassword endEditing:YES];
    [self.editPhoneNumber endEditing:YES];
}

#pragma mark - Button Methods Implementation
- (IBAction)buttonRegisterClick:(id)sender
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
            [self callRegisterUserWebService];
        }
    }
}

#pragma mark - Validation
- (NSString *)validateFields
{
    NSString *errorMessage ;
    NSString *strFirstname = [self.editFirstName.text removeWhiteSpaces];
    NSString *strLastname = [self.editLastName.text removeWhiteSpaces];
    NSString *strEmail = [self.editEmail.text removeWhiteSpaces];
    NSString *strPassword = [self.editPassword.text removeWhiteSpaces];
    NSString *strConfirmPassword = [self.editConfirmPassword.text removeWhiteSpaces];
    NSString *strPhoneNumber = [self.editPhoneNumber.text removeWhiteSpaces];
    
    if ([strFirstname length] == 0)
    {
        errorMessage =@"Enter Firstname";
        return errorMessage;
    }
    BOOL isFirstNameValid = [strFirstname validateTextForAlphabatesOnly];
    if (!isFirstNameValid)
    {
        errorMessage =@"First name - Only alphabates characters are allowed";
        return errorMessage;
    }
    
    if ([strLastname length] == 0)
    {
        errorMessage =@"Enter Laststname";
        return errorMessage;
    }
    BOOL isLastNameValid = [strLastname validateTextForAlphabatesOnly];
    if (!isLastNameValid)
    {
        errorMessage =@"Last name - Only alphabates characters are allowed";
        return errorMessage;
    }
    
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
    
    if ([strPassword length] == 0)
    {
        errorMessage =@"Enter Password";
        return errorMessage;
    }
    BOOL isPasswordlvalid = [self isPasswordValid:strPassword];
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
    BOOL isPasswordMatch = [self isPasswordMatch:self.editPassword.text withConfirmPwd:self.editConfirmPassword.text];
    if (!isPasswordMatch)
    {
        errorMessage =@"Password not match";
        return errorMessage;
    }
    
    if ([strPhoneNumber length] == 0)
    {
        errorMessage =@"Enter Phone Number";
        return errorMessage;
    }
    BOOL isPhoneNumberValid = [self.editPhoneNumber.text validateMobileNumber];
    if (!isPhoneNumberValid)
    {
        errorMessage =@"Invalid Phone Number";
        return errorMessage;
    }
    
     if (!self.buttonAgreeClick.selected)
     {
         errorMessage =PLEASE_SIGN_AGREEMENT;
         return errorMessage;
     }

    return 0;
}

-(void)callRegisterUserWebService
{
    parameters = @{@"first_name":self.editFirstName.text, @"last_name":self.editLastName.text,
                   @"email":self.editEmail.text, @"password":self.editPassword.text,
                   @"confirm_password":self.editConfirmPassword.text, @"gender":userGender,
                   @"phone_no":self.editPhoneNumber.text, };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"users" Screen:@"register" AcessToken:NULL completionBlock:^(id  response,NSString *error)
     {
         //NSLog(@"REGISTER    :   %@",response);
         dispatch_async(dispatch_get_main_queue(),^
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if([[response valueForKey:@"status"] integerValue] == 200)
            {
                [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^
                    {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
            }
            else
            {
                [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
            }
    });
    }];
}

- (IBAction)buttonMaleClick:(id)sender
{
    //NSLog(@"buttonMaleClick");
    [self.buttonMaleClick setImage:[self getSelectImage] forState:UIControlStateNormal];
    [self.buttonFemaleClick setImage:[self getUnselectImage] forState:UIControlStateNormal];
    userGender = GENDER_MALE;
}

- (IBAction)buttonFemaleClick:(id)sender
{
    //NSLog(@"buttonFemaleClick");
    [self.buttonFemaleClick setImage:[self getSelectImage] forState:UIControlStateNormal];
    [self.buttonMaleClick setImage:[self getUnselectImage] forState:UIControlStateNormal];
    userGender = GENDER_FEMALE;
}

- (IBAction)buttonAgreeClick:(id)sender
{
    if(self.buttonAgreeClick.selected)
    {
        //NSLog(@"UNSELECTED - buttonAgreeClick");
        self.buttonAgreeClick.selected = FALSE;
        [self.buttonAgreeClick setImage:[self getUncheckedImage] forState:UIControlStateNormal];
    }
    else
    {
        //NSLog(@"SELECTED - buttonAgreeClick");
        self.buttonAgreeClick.selected = TRUE;
        [self.buttonAgreeClick setImage:[self getCheckedImage] forState:UIControlStateNormal];
    }
}

- (IBAction)buttonBackToLoginVC:(id)sender
{
    //NSLog(@"buttonBackToLoginVC");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Get image methods
-(UIImage*)getSelectImage
{
    return [UIImage imageNamed:IMAGE_SELECT];
}

-(UIImage*)getUnselectImage
{
    return [UIImage imageNamed:IMAGE_UNSELECT];
}

-(UIImage*)getCheckedImage
{
    return [UIImage imageNamed:IMAGE_CHECKED];
}

-(UIImage*)getUncheckedImage
{
    return [UIImage imageNamed:IMAGE_UNCHECKED];
}
@end
