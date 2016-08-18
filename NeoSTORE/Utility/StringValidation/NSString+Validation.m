//
//  NSString+Validation.m
//  NeoSTORE
//
//  Created by neosoft on 04/05/16.
//  Copyright (c) 2016 NeoSOFT. All rights reserved.
//
#import "NSString+Validation.h"

static NSString *const NoNetwork = @"The Internet connection appears to be offline";
static NSString *const EnterEmail = @"Please enter Email Address";
static NSString *const EnterPassword = @"Please enter Password";
static NSString *const InvalidEmail = @"Please enter valid Email";
static NSString *const FirstnameStr = @"First name  should not be Empty";
static NSString *const LastnameStr =@"Last name should not be Empty";
static NSString *const ConfirmStr = @"Confirm should not be Empty";
static NSString *const phoneStr=@"Phone number should not be Empty";
static NSString *const REConfirmStr =@"Please re-enter confirm password";
static NSString *const CountryStr=@"Country should not be Empty";
static NSString *const ZipcodeStr =@"Zipcode should not be Empty";
static NSString *const ZipcodeDigit =@"Zipcode should  be  Equal six digit";
static NSString *const StateStr =@"State  should not be Empty";
static NSString *const CityStr =@"City should not be Empty";
static NSString *const CitylandStr =@"CityLand should not be Empty";
static NSString *const AddressStr =@"address field  should not be Empty";
static NSString *const STDStr=@"DOB field should not be Empty";
static NSString *const CurrentPass=@"Curentpassword should not be Empty";
static NSString *const NewpassStr=@"Newpassword  should not be Empty";
static NSString *const termselectedStr=@"please select Term and condition ! ";
static NSString *const GenderStr=@"please select Gender ! ";
static NSString *const zipStr1=@"Zipcode number should be six digits";

// edit Setting
static NSString *const appName=@"please enter your App Name";
static NSString *const myfriend=@"please enter your Friend";
static NSString *const enterpassword=@"Please enter Password";
static NSString *const retypepass=@"Please enter Retype Password";
static NSString *const username = @"User name  should not be Empty";
static NSString *const MobileNumber=@"phone number should be ten digits";
static NSString *const denomination=@"Select Denomination";

@implementation NSString (Validation)

- (BOOL)validateEmail
{
    NSString *emailText = self;
    NSString *emailformat = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailformat];
    return [emailTest evaluateWithObject:emailText];
}



- (BOOL)validateMobileNumber
{
    NSString *mobileNumberText = self;
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    return [numberTest evaluateWithObject:mobileNumberText];
}

- (BOOL)validateNumbers
{
    NSString *ZipNumberText = self;
    NSString *numberRegEx = @"[0-9]";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    return [numberTest evaluateWithObject:ZipNumberText];
}

- (BOOL)validateZipNumber
{
    NSString *ZipNumberText = self;
    NSString *numberRegEx = @"[0-9]{6}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    return [numberTest evaluateWithObject:ZipNumberText];
}

- (BOOL)validateTextForAlphabatesOnly
{
    NSString *wordText = self;
    NSString *numberRegEx = @"[A-Za-z]+";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    return [numberTest evaluateWithObject:wordText];
}

- (BOOL)validateTextForAlphaNumerics
{
    NSString *wordText = self;
    NSString *numberRegEx = @"[A-Z0-9a-z]";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    return [numberTest evaluateWithObject:wordText];
}

- (BOOL)isEmpty
{
    if([self  isEqual: @""])
        return FALSE;
    else
        return TRUE;
}



@end
