//
//  LeftMenuCellTableViewCell.h
//  NeoSTORE
//
//  Created by webwerks on 7/5/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftMenuIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftMenuItemName;

@property (weak, nonatomic) IBOutlet UIButton *buttonLabelMyCartQuantity;

@property (weak, nonatomic) IBOutlet UILabel *leftMenuMyCartQuantity;
@property (weak, nonatomic) IBOutlet UIView *leftMenuMyCartQuantityView;

@end
