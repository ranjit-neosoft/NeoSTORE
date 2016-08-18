//
//  AddAddressViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/11/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self initAddAddressScreen];
    [self.editAddress setPlaceholder:NeoSTORE_ADDRESS_DADAR];
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
    [self setFontAndColorNavaigationBarItems:ADD_ADDRESS_VIEW_CONTROLLER_ID];
    self.navigationItem.title = ADD_ADDRESS;
    [self addBackButtonOnNavigationBar];
}

-(void)initAddAddressScreen
{
    self.editAddress.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editLandmark.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editCity.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editState.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editZipCode.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.editCountry.inputAccessoryView = [self getCancelAndDoneToolbar];
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
    [self.editAddress endEditing:YES];
    [self.editLandmark endEditing:YES];
    [self.editCity endEditing:YES];
    [self.editState endEditing:YES];
    [self.editZipCode endEditing:YES];
    [self.editCountry endEditing:YES];
}

- (IBAction)buttonPlaceOrder:(id)sender
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
            [self callPlaceOrderWebService];
        }
    }
}

#pragma mark - Validation
- (NSString *)validateFields
{
    NSString *errorMessage ;
    
    NSString *strAddress = [self.editAddress.text removeWhiteSpaces];
    NSString *strLandmark = [self.editLandmark.text removeWhiteSpaces];
    NSString *strCity = [self.editCity.text removeWhiteSpaces];
    NSString *strState = [self.editState.text removeWhiteSpaces];
    NSString *strZipcode = [self.editZipCode.text removeWhiteSpaces];
    NSString *strCountry = [self.editCountry.text removeWhiteSpaces];

    if ([strAddress length] == 0)
    {
        errorMessage =@"Enter Address";
        return errorMessage;
    }
//    BOOL isAddressValid = [strAddress validateTextForAlphaNumerics];
//    if (!isAddressValid)
//    {
//        errorMessage =@"Address - Only alphanumeric characters are allowed";
//        return errorMessage;
//    }
    
    if ([strLandmark length] == 0)
    {
        errorMessage =@"Enter Landmark";
        return errorMessage;
    }
//    BOOL isLandmarkValid = [strLandmark validateTextForAlphaNumerics];
//    if (!isLandmarkValid)
//    {
//        errorMessage =@"Landmark - Only alphanumeric characters are allowed";
//        return errorMessage;
//    }
    
    if ([strCity length] == 0)
    {
        errorMessage =@"Enter City";
        return errorMessage;
    }
    BOOL isCityValid = [strCity validateTextForAlphabatesOnly];
    if (!isCityValid)
    {
        errorMessage =@"City - Only alphabate characters are allowed";
        return errorMessage;
    }
    
    if ([strState length] == 0)
    {
        errorMessage =@"Enter State";
        return errorMessage;
    }
    BOOL isStateValid = [strState validateTextForAlphabatesOnly];
    if (!isStateValid)
    {
        errorMessage =@"State - Only alphabate characters are allowed";
        return errorMessage;
    }
    
    if ([strZipcode length] == 0)
    {
        errorMessage =@"Enter Zipcode";
        return errorMessage;
    }
    BOOL isZipcodeValid = [strZipcode validateZipNumber];
    if (!isZipcodeValid)
    {
        errorMessage =@"Invalid Zipcode";
        return errorMessage;
    }

    if ([strCountry length] == 0)
    {
        errorMessage =@"Enter Country";
        return errorMessage;
    }
    BOOL isCountryValid = [strCountry validateTextForAlphabatesOnly];
    if (!isCountryValid)
    {
        errorMessage =@"Country - Only alphabate characters are allowed";
        return errorMessage;
    }

    return 0;
}

-(void) callPlaceOrderWebService
{
    NSDictionary *parameters = @{
                                 @"address":[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",self.editAddress.text,self.editLandmark.text,self.editCity.text,self.editState.text,self.editZipCode.text,self.editCountry.text],
                                 };
    
    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"order" Screen:NULL AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
     {
         //NSLog(@"PLACE ORDER :   %@",response);
         dispatch_async(dispatch_get_main_queue(),^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             if([[response valueForKey:@"status"]integerValue] == 200)
             {
                 [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.navigationController popToRootViewControllerAnimated:YES];
                 });
             }
             else
                 [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
         });
     }];

}

@end
