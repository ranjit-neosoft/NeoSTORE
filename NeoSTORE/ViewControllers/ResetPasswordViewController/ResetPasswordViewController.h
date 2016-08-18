//
//  ResetPasswordViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"

@interface ResetPasswordViewController : BaseViewController
{
    NSDictionary *parameters;
}
@property (weak, nonatomic) IBOutlet UITextField *editCurrentPassword;
@property (weak, nonatomic) IBOutlet UITextField *editNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *editConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonResetPassword;
- (IBAction)buttonResetPassword:(id)sender;

@end
