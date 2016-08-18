//
//  MyCartProductCell.h
//  NeoSTORE
//
//  Created by webwerks on 7/11/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCartProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelProductCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelProductQuantity;

@property (weak, nonatomic) IBOutlet UIButton *buttonLabelProductQuantity;

@property (weak, nonatomic) IBOutlet UILabel *labelSubTotal;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuantityDecrement;
@property (weak, nonatomic) IBOutlet UIButton *buttonQuantityIncrement;

@end
