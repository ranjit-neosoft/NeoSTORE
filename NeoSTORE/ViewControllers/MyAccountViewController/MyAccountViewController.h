//
//  MyAccountViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"

@interface MyAccountViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
#pragma mark - Instance Variables
{
     NSMutableArray *responseData;
    NSDictionary *parameters;
    NSString *imageStr;
    UIDatePicker *datePicker;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *myAccountScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;


@property (weak, nonatomic) IBOutlet UIButton *profileImageView;

- (IBAction)profileImageView:(id)sender;
//@property(weak,nonatomic) UIImage *userImage;

@property (weak, nonatomic) IBOutlet UITextField *editFirstName;
@property (weak, nonatomic) IBOutlet UITextField *editLastName;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UITextField *editPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *editBirthDate;
@property (weak, nonatomic) IBOutlet UIButton *buttonEditSubmit;

@property (weak, nonatomic) NSString *profileImageName;
- (IBAction)buttonEditSubmit:(id)sender;
- (IBAction)buttonResetPassword:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *buttonResetPasswordView;

@property (nonatomic, strong) CustomActionSheet *customActionSheet;
@end
