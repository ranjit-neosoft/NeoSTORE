//
//  OrderDetailsTableViewCell.h
//  NeoSTORE
//
//  Created by webwerks on 7/14/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *orderDetailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelProductCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelCost;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;

@end
