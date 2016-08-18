//
//  LeftMenuViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/5/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"
#import "LeftMenuCellTableViewCell.h"
#import "CustomAlertView.h"

@interface LeftMenuViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>
#pragma mark - Instance Variables
{
    NSArray *arrayLeftMenuItems;
    NSArray *arrayLeftMenuItemIconImages;
    NSMutableArray *responseData;
    NSString *cartItems;
    LeftMenuCellTableViewCell *myCell;
     NSIndexPath *selectedIndexPath;
}

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *buttonProfile;
@property (weak, nonatomic) IBOutlet UILabel *SMLabelUserName;
@property (weak, nonatomic) IBOutlet UILabel *SMLeftMenuUserEmail;
@property (weak, nonatomic) IBOutlet UIView *SMProfileView;
@property (weak, nonatomic) IBOutlet UITableView *SMTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftViewRightWidth;

@end
