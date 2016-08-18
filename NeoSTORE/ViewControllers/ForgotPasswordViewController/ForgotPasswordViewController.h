//
//  ForgotPasswordViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"

@interface ForgotPasswordViewController : BaseViewController<UITextFieldDelegate>
#pragma mark - Instance Variables
{
    NSDictionary *parameters;
}

#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *editEmail;
@property (weak, nonatomic) IBOutlet UIButton *buttonReset;

#pragma mark - IBAction Methods
- (IBAction)buttonReset:(id)sender;
- (IBAction)buttonBackToLoginVC:(id)sender;


@end
