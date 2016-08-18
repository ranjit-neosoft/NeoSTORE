//
//  BaseViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

#pragma mark - Button Methods
-(void)makeCornerForButton:(UIButton*)myButton
{
    myButton.layer.cornerRadius = 7;
    myButton.layer.borderWidth = 1;
    myButton.layer.borderColor =[UIColor colorWithRed:189.0/255.0f green:189.0/255.0f blue:189.0/255.0f alpha:1.0].CGColor;
}

#pragma mark - TextField Methods
-(void)initTextField:(UITextField*)editTextfield withImageName:(NSString *)imageName withPlaceholder:(NSString*)placeHolderName
{
    editTextfield.layer.borderWidth = 1.0;
    editTextfield.layer.borderColor = [[UIColor whiteColor] CGColor];
    editTextfield.tintColor = [UIColor lightTextColor];
    
    UIImageView *usernameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    usernameImage.frame = CGRectMake(0, 0, usernameImage.image.size.width+10.0, usernameImage.image.size.height);
    usernameImage.contentMode = UIViewContentModeCenter;
    editTextfield.leftViewMode = UITextFieldViewModeAlways;
    editTextfield.leftView = usernameImage;
    
    UIColor *color = [UIColor whiteColor];
    editTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderName attributes:@{NSForegroundColorAttributeName:color}];
}

-(void)initTextField:(UITextField*)editTextfield withImageName:(NSString *)imageName
{
    editTextfield.layer.borderWidth = 1.0;
    editTextfield.layer.borderColor = [[UIColor whiteColor] CGColor];
    editTextfield.tintColor = [UIColor lightTextColor];
    
    UIImageView *usernameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    usernameImage.frame = CGRectMake(0, 0, usernameImage.image.size.width+10.0, usernameImage.image.size.height);
    usernameImage.contentMode = UIViewContentModeCenter;
    editTextfield.leftViewMode = UITextFieldViewModeAlways;
    editTextfield.leftView = usernameImage;
}

#pragma mark - NavigationBar Methods

-(void)addLeftMenuButtonOnNavigationBar
{
    UIButton *leftMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    [leftMenuButton setBackgroundImage:[UIImage imageNamed:IMAGE_MENU] forState:UIControlStateNormal];
    [leftMenuButton addTarget:self action:@selector(buttonLeftMenuClicked) forControlEvents: UIControlEventTouchUpInside];
    [leftMenuButton setShowsTouchWhenHighlighted:NO];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
}

-(void)addBackButtonOnNavigationBar
{
    UIButton *leftMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    [leftMenuButton setBackgroundImage:[UIImage imageNamed:IMAGE_BACK] forState:UIControlStateNormal];
    [leftMenuButton addTarget:self action:@selector(buttonBackClicked) forControlEvents: UIControlEventTouchUpInside];
    [leftMenuButton setShowsTouchWhenHighlighted:NO];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
}

-(void)buttonLeftMenuClicked
{
    //NSLog(@"buttonLeftMenuClicked");
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)buttonBackClicked
{
    //NSLog(@"buttonBackClicked");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addRightSearchButtonOnNavigationBar
{
    UIButton *rightSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 20, 22)];
    [rightSearchButton setBackgroundImage:[UIImage imageNamed:IMAGE_SEARCH] forState:UIControlStateNormal];
    [rightSearchButton addTarget:self action:@selector(buttonSearchClicked)
                forControlEvents:UIControlEventTouchUpInside];
    [rightSearchButton setShowsTouchWhenHighlighted:NO];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightSearchButton];
}

-(void)buttonSearchClicked
{
    //NSLog(@"buttonSearchClicked");
}

-(void)setFontAndColorNavaigationBarItems:(NSString *)viewControllerID
{
    if ([viewControllerID isEqualToString:PRODUCT_DETAILS_VIEW_CONTROLLER_ID])
    {
        if ((IS_IPHONE6) || (IS_IPHONE6PLUS))
        {
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Gotham-Medium" size:20]}];
        }
        else
        {
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Gotham-Medium" size:16]}];
        }
        
    }
    else
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont fontWithName:@"Gotham-Medium" size:20]}];
    }
}

#pragma mark - NSUserDefaults Methods
-(void)resetUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [NSUserDefaults resetStandardUserDefaults];
    [defaults synchronize];
}

-(void)setUserDefaults:(NSDictionary*)userDefaultsData withVC:(NSString *)viewControllerID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([viewControllerID isEqualToString:LOGIN_VIEW_CONTROLLER_ID])
    {
        [defaults setBool:YES forKey:KEY_LOGIN_STATUS];
         [defaults setObject:[userDefaultsData valueForKey:@"access_token"] forKey:KEY_LOGIN_ACCESS_TOKEN];
    }
     
    [defaults setValue:[userDefaultsData valueForKey:@"first_name"] forKey:KEY_LOGIN_FIRSTNAME];
    [defaults setValue:[userDefaultsData valueForKey:@"last_name"] forKey:KEY_LOGIN_LASTNAME];
    [defaults setValue:[userDefaultsData valueForKey:@"email"] forKey:KEY_LOGIN_EMAIL];
    [defaults setValue:[userDefaultsData valueForKey:@"phone_no"] forKey:KEY_LOGIN_MOBILE];

    //NSLog(@"Birthdate   :   %@",[userDefaultsData valueForKey:@"dob"]);
    if ([userDefaultsData valueForKey:@"dob"] == NULL)
    {
        [defaults setValue:@"dd-MM-yyyy" forKey:KEY_LOGIN_BIRTHDATE];
    }
    else
    {
        [defaults setValue:[userDefaultsData valueForKey:@"dob"]  forKey:KEY_LOGIN_BIRTHDATE];
    }
    
    if ([[userDefaultsData valueForKey:@"profile_pic"] isEqual:[NSNull null]])
    {
        [defaults setObject:UIImagePNGRepresentation([UIImage imageNamed:IMAGE_USER_COLOR])  forKey:KEY_USER_IMAGE_DATA];
    }
//    else
//    {
//        UIImage *profileImage = [self stringToUIImage:[userDefaultsData valueForKey:@"profile_pic"]];
//        [defaults setObject:UIImagePNGRepresentation(profileImage) forKey:KEY_PROFILE_PICTURE];
//    }
    [defaults synchronize];
}

-(NSString *)imageToNSString:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(UIImage *)stringToUIImage:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string
                                                      options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(NSString *)getAccessToken
{
    return  [[NSUserDefaults standardUserDefaults]valueForKey:KEY_LOGIN_ACCESS_TOKEN];
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
//    return UIStatusBarStyleLightContent;
//}
-(void)showStatusBarOnViewController
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

-(UIToolbar *) getCancelAndDoneToolbar
{
    UIToolbar* cancelAndDoneButtonToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    cancelAndDoneButtonToolbar.barStyle = UIBarStyleBlackTranslucent;
    cancelAndDoneButtonToolbar.items = [NSArray arrayWithObjects:
                                        [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonToolbar)],
                                        [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                        [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonToolbar)],
                                        nil];
    [cancelAndDoneButtonToolbar sizeToFit];
    
    return cancelAndDoneButtonToolbar;
}

-(void)doneButtonToolbar
{
    
}
-(void)cancelButtonToolbar
{
    
}

- (BOOL)isPasswordValid:(NSString *)password
{
    if ([password length] >= 6)
    {
        NSCharacterSet * characterSet = [NSCharacterSet uppercaseLetterCharacterSet] ;
        NSRange range = [password rangeOfCharacterFromSet:characterSet] ;
        if (range.location == NSNotFound) {
            return NO ;
        }
        characterSet = [NSCharacterSet lowercaseLetterCharacterSet] ;
        range = [password rangeOfCharacterFromSet:characterSet] ;
        if (range.location == NSNotFound) {
            return NO ;
        }
        
        characterSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] ;
        for (NSUInteger i = 0; i < [password length]; ++i) {
            unichar uchar = [password characterAtIndex:i] ;
            if (![characterSet characterIsMember:uchar]) {
                return NO ;
            }
        }
        return YES ;

    }
    return NO;
}

-(BOOL)isPasswordMatch:(NSString *)pwd withConfirmPwd:(NSString *)cnfPwd
{
    //asume pwd and cnfPwd has not whitespace
    if([pwd length]>0 && [cnfPwd length]>0)
    {
        if([pwd isEqualToString:cnfPwd])
        {
            NSLog(@"Hurray! Password matches ");
            return TRUE;
        }
        else
        {
            NSLog(@"Oops! Password does not matches");
            return FALSE;
        }
    }
    else
    {
        NSLog(@"Password field can not be empty ");
        return FALSE;
    }
    return FALSE;
}
@end
