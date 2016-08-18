//
//  MyOrdersViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrayMyOrdersData;
}
@property (weak, nonatomic) IBOutlet UITableView *myOrdersTableView;

@end
