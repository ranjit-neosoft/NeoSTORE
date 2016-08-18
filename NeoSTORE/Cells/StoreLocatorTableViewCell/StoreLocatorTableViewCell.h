//
//  StoreLocatorTableViewCell.h
//  NeoSTORE
//
//  Created by webwerks on 7/15/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreLocatorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeLocatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelStoreName;
@property (weak, nonatomic) IBOutlet UILabel *labelStoreAddress;

@end
