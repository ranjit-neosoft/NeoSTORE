//
//  AddAddressViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/11/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface AddAddressViewController : BaseViewController
@property (weak, nonatomic) IBOutlet SZTextView *editAddress;
@property (weak, nonatomic) IBOutlet UITextField *editLandmark;
@property (weak, nonatomic) IBOutlet UITextField *editCity;
@property (weak, nonatomic) IBOutlet UITextField *editState;
@property (weak, nonatomic) IBOutlet UITextField *editZipCode;
@property (weak, nonatomic) IBOutlet UITextField *editCountry;
- (IBAction)buttonPlaceOrder:(id)sender;

@end
