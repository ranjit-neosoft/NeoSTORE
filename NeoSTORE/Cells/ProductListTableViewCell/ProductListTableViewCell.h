//
//  ProductListTableViewCell.h
//  NeoSTORE
//
//  Created by webwerks on 6/30/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelProductName;

@property (weak, nonatomic) IBOutlet UILabel *labelProductCost;
@property (weak, nonatomic) IBOutlet UILabel *labelProductProducer;

@end
