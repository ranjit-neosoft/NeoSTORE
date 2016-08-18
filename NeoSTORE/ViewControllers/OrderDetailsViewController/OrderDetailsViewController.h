//
//  OrderDetailsViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/13/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailsTableViewCell.h"

@interface OrderDetailsViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrayResponseData;
    id serverData;
    
    MyCartTotalCell *totalCell;
    OrderDetailsTableViewCell *productCell;
}
@property (weak, nonatomic) NSString *orderID;
@property (weak, nonatomic) IBOutlet UITableView *orderDetailsTableView;

@end
