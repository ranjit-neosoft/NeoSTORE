//
//  MyAccountViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

#pragma mark - UIViewController Methods
{
    BOOL isNeedToRefresh;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    self.profileImageView.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (!isNeedToRefresh)
    {
        [self showStatusBarOnViewController];
        [self loadTextFields];
        [self getUserData];
    }
    else
    {
        isNeedToRefresh=false;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.profileImageView.layer.borderWidth = 1.5f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
}

#pragma mark - Other Method Implementations
-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:MY_ACCOUNT_VIEW_CONTROLLER_ID];
    self.navigationItem.title = MY_ACCOUNT;
    [self addLeftMenuButtonOnNavigationBar];
    [self makeCornerForButton: self.buttonEditSubmit];
}

-(void)loadTextFields
{
    [self disableTextFields];
    [self initTextField:self.editFirstName withImageName:IMAGE_USER];
    [self initTextField:self.editLastName withImageName:IMAGE_USER];
    [self initTextField:self.editEmail withImageName:IMAGE_EMAIL];
    [self initTextField:self.editPhoneNumber withImageName:IMAGE_PHONE];
    [self initTextField:self.editBirthDate withImageName:IMAGE_BIRTHDATE];
}

-(void)getUserData
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:NULL withHud:YES User:@"users" Screen:@"getUserData" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
         {
             if([[response valueForKey:@"status"]integerValue] == 200)
             {
                 dispatch_async(dispatch_get_main_queue(),^{
                     responseData = [[response valueForKey:@"data"] valueForKey:@"user_data"];
                     [self fetchResponseData:response];
                 });
                 
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(),^{
                     [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                 });
             }
         }];
    }
}

-(void)fetchResponseData:(id)dataFromServer
{
    NSDictionary *tempData = [[dataFromServer valueForKey:@"data"] valueForKey:@"user_data"];
    [self setUserDefaults:tempData withVC:MY_ACCOUNT_VIEW_CONTROLLER_ID];
    [self setDetails];
}

-(void)setDetails
{
    dispatch_async(dispatch_get_main_queue(),^{
        self.editFirstName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_FIRSTNAME]];
        
        self.editLastName.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_LASTNAME]];
        
        self.editEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_EMAIL]];
        
        self.editPhoneNumber.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_MOBILE]];
        
        self.editBirthDate.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_BIRTHDATE]];
        
        UIImage *tempImage=[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IMAGE_DATA]];
        
        [self.profileImageView setImage:tempImage forState:UIControlStateNormal];
    });
}

#pragma mark - Button Methods
- (IBAction)buttonEditSubmit:(id)sender
{
    if (![[self.buttonEditSubmit titleForState:UIControlStateNormal] isEqualToString: SUBMIT_BUTTON])
    {
        //NSLog(@"button EDIT PROFILE clicked");
        self.navigationItem.title = EDIT_PROFILE;
        [self addBackButtonOnNavigationBarTemp];
        if (IS_IPHONE4)
        {
            self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width,550);
            self.contentViewHeight.constant = 550;
        }
        [self enableTextFields];
        
        datePicker=[[UIDatePicker alloc]init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.date = [NSDate date];
    
        datePicker.maximumDate = [NSDate date];

        
        self.editFirstName.inputAccessoryView = [self getCancelAndDoneToolbar];
        self.editLastName.inputAccessoryView = [self getCancelAndDoneToolbar];
        self.editEmail.inputAccessoryView = [self getCancelAndDoneToolbar];
        self.editPhoneNumber.inputAccessoryView = [self getCancelAndDoneToolbar];
        self.editBirthDate.inputAccessoryView = [self getCancelAndDoneToolbar];
        [self.editBirthDate setInputView:datePicker];
        
        self.profileImageView.userInteractionEnabled = YES;
        [self.buttonEditSubmit setTitle:SUBMIT_BUTTON forState:UIControlStateNormal];
        [self.buttonResetPasswordView setHidden:YES];
    }
    else
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
                self.navigationItem.title = MY_ACCOUNT;
                [self addLeftMenuButtonOnNavigationBar];
                [self.buttonEditSubmit setTitle:EDIT_PROFILE_BUTTON forState:UIControlStateNormal];
                
                if (IS_IPHONE4)
                {
                    self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width,410);
                    self.contentViewHeight.constant = 410;
                }

                [self.buttonResetPasswordView setHidden:NO];
                [self disableTextFields];
                [self callUpdateProfile];
            }
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
    
    if ([strPhoneNumber length] == 0)
    {
        errorMessage =@"Enter Phone Number";
        return errorMessage;
    }
    BOOL isPhoneNumbervalid = [strPhoneNumber validateMobileNumber];
    if (!isPhoneNumbervalid)
    {
        errorMessage =@"Invalid Phone Number";
        return errorMessage;
    }

    return 0;
}

-(void)addBackButtonOnNavigationBarTemp
{
    UIButton *leftMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    [leftMenuButton setBackgroundImage:[UIImage imageNamed:IMAGE_BACK] forState:UIControlStateNormal];
    [leftMenuButton addTarget:self action:@selector(buttonBackClickedFromMyAccount) forControlEvents: UIControlEventTouchUpInside];
    [leftMenuButton setShowsTouchWhenHighlighted:NO];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
}

-(void)buttonBackClickedFromMyAccount
{
    dispatch_async(dispatch_get_main_queue(),^{
        self.navigationItem.title = MY_ACCOUNT;
        [self addLeftMenuButtonOnNavigationBar];
        [self.buttonEditSubmit setTitle:EDIT_PROFILE_BUTTON forState:UIControlStateNormal];
        
        if (IS_IPHONE4)
        {
            self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width,410);
            self.contentViewHeight.constant = 410;
        }
        
        [self.buttonResetPasswordView setHidden:NO];
        [self disableTextFields];
    });
}

-(void)doneButtonToolbar
{
    datePicker = (UIDatePicker*)self.editBirthDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *eventDate = datePicker.date;
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    NSDate *todaysDate = [NSDate date];
    
    if ([todaysDate compare:eventDate]==NSOrderedAscending )
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage: INVALID_BIRTHDATE];
    else if ([todaysDate compare:eventDate]== NSOrderedDescending)
    {
        self.editBirthDate.text = [NSString stringWithFormat:@"%@",dateString];
        [self callTextFieldEndEditing];
    }
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
    [self.editPhoneNumber endEditing:YES];
    [self.editBirthDate endEditing:YES];
}

-(void) callUpdateProfile
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        parameters = @{
                       @"first_name":self.editFirstName.text,
                       @"last_name":self.editLastName.text,
                       @"email":self.editEmail.text,
                       @"dob":self.editBirthDate.text,
                       @"profile_pic":@"",
                       @"phone_no":self.editPhoneNumber.text,
                       };
        
        [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"users" Screen:@"update" AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
         {
             //NSLog(@"UPDATE    :   %@",response);
             dispatch_async(dispatch_get_main_queue(),^
                            {
                                if([[response valueForKey:@"status"] integerValue] == 200)
                                {
                                    [self setUserDefaults:parameters withVC:MY_ACCOUNT_VIEW_CONTROLLER_ID];
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                    
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                                                   {
                                                       
                                                   });
                                }
                                else
                                {
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                }
                            });
         }];
    }
}

-(void)enableTextFields
{
    self.editFirstName.enabled = YES;
    self.editLastName.enabled = YES;
    self.editEmail.enabled = YES;
    self.editPhoneNumber.enabled = YES;
    self.editBirthDate.enabled = YES;
}

-(void)disableTextFields
{
    self.editFirstName.enabled = NO;
    self.editLastName.enabled = NO;
    self.editEmail.enabled = NO;
    self.editPhoneNumber.enabled = NO;
    self.editBirthDate.enabled = NO;
}

- (IBAction)buttonResetPassword:(id)sender
{
    ResetPasswordViewController *vc = (ResetPasswordViewController *)  [Utils instantiateViewControllerWithId:RESET_PASSWORD_VIEW_CONTROLLER_ID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)profileImageView:(id)sender
{
    UIImage *tempImage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IMAGE_DATA]];
    NSData *data1 = UIImagePNGRepresentation(tempImage);
    NSData *data2 = UIImagePNGRepresentation([UIImage imageNamed:IMAGE_USER_COLOR]);
    
    if(data1.length == data2.length)
    {
        [self showActionSheet:nil];
        
        [_customActionSheet showInView:self.view withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
         {
             if (buttonIndex == 0)
             {
                 //NSLog(@"Take Photo");
             }
             else if (buttonIndex == 1)
             {
                 //NSLog(@"Choose Photo");
                 [self callChoosePhoto];
             }
             else if (buttonIndex == 2)
             {
                 //cancel
                 //NSLog(@"cancel");
             }
         }];
    }
    else
    {
        [self showActionSheet:@"Delete Photo"];
        
        [_customActionSheet showInView:self.view withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
         {
             if (buttonIndex == 0)
             {
                 //NSLog(@"Delete Photo");
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_USER_IMAGE_DATA] ;
                  [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([UIImage imageNamed:IMAGE_USER_COLOR])  forKey:KEY_USER_IMAGE_DATA];
                 [self.profileImageView setImage:[UIImage imageNamed:IMAGE_USER_COLOR] forState:UIControlStateNormal];
             }
             else if (buttonIndex == 1)
            {
                //NSLog(@"Take Photo");
            }
             else if (buttonIndex == 2)
             {
                 //NSLog(@"Choose Photo");
                 [self callChoosePhoto];
             }
             else if (buttonIndex == 3)
             {
                  //NSLog(@"Cancel");
             }
         }];
    }
}

-(void)showActionSheet:(NSString *)destructiveButton
{
    self.customActionSheet = [[CustomActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:destructiveButton
                                                    otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    isNeedToRefresh=true;
    UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageStr = [self imageToNSString:tempImage];
        NSData *tempImagedata=UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]);
        
        [[NSUserDefaults standardUserDefaults] setObject:tempImagedata forKey:KEY_USER_IMAGE_DATA];
        
        UIImage *tempImage=[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IMAGE_DATA]];
        
        [self.profileImageView setImage:tempImage forState:UIControlStateNormal];
        
        [self callUpdateProfile];
    });
   [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) callChoosePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)viewWillLayoutSubviews
{
    if (IS_IPHONE4)
    {
        self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width,410);
    }
//    else if (IS_IPHONE6)
//    {
//        self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width, 603);
//    }
//    else if (IS_IPHONE6PLUS)
//    {
//        self.myAccountScrollView.contentSize=CGSizeMake(self.myAccountScrollView.frame.size.width, 672);
//    }
}
@end
