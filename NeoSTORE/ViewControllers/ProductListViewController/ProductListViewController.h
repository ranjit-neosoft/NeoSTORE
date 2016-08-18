//
//  ProductListViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/30/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
#pragma mark - Instance Variables
{
    NSMutableArray *arrayProductList;
    NSDictionary *parameters;
    NSInteger productRating;
}

#pragma mark - Properties
@property (nonatomic) NSUInteger product_category_id;
@property (nonatomic) BOOL checkView;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UITableView *productListTableView;

@end
