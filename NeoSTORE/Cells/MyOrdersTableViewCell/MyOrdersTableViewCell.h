//
//  MyOrdersTableViewCell.h
//  NeoSTORE
//
//  Created by webwerks on 7/13/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelID;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelCost;

@end
