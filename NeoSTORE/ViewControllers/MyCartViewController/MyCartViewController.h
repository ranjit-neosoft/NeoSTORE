//
//  MyCartViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartProductCell.h"
#import "MyCartTotalCell.h"
#import "MyCartButtonCell.h"

@interface MyCartViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
#pragma mark - Instance Variables
{
    NSMutableArray *arrayCartData;
    NSDictionary *parameters;
    id serverData;
    NSInteger cellCount;
    int quantity;
    NSString *productID;
    
    MyCartProductCell *productCell;
    MyCartTotalCell *totalCell;
    MyCartButtonCell *orderNowCell;
    NSMutableDictionary *deleteResponse;
    BOOL cellDelete;
}

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UITableView *myCartTableView;
@property (weak, nonatomic) IBOutlet UIView *myCartEmptyView;

@end
