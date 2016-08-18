//
//  ProductListViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/30/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.productListTableView addSubview:refreshControl];
    [self registerProductListTableCell];
    
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    // Do your job, when done:
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.productListTableView.hidden = YES;
    [self showStatusBarOnViewController];
    [self getProductListFromServer];
    [self loadNavigationItems];
}

#pragma mark - Other Method Implementations
-(void)registerProductListTableCell
{
    [self.productListTableView registerNib:[UINib nibWithNibName:PRODUCT_LIST_VIEW_CELL_ID bundle:nil] forCellReuseIdentifier:PRODUCT_LIST_VIEW_CELL_ID];
}

-(void) getProductListFromServer
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        parameters = @{@"product_category_id":[[NSUserDefaults standardUserDefaults]valueForKey:@"Category"]};
        
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"products" Screen:@"getList" AcessToken:NULL completionBlock:^(id response, NSString *error)
         {
             //NSLog(@"PRODUCT LIST    :   %@",response);
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                self.productListTableView.hidden = NO;
                                if ([[response valueForKey:@"status"] integerValue] == 200)
                                {
                                    arrayProductList = [response objectForKey:@"data"];
                                    [self.productListTableView reloadData];
                                }
                                else
                                {
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                }
                            });
         }];
    }
}

-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:PRODUCT_LIST_VIEW_CONTROLLER_ID];
    
    if([[parameters valueForKey:@"product_category_id"]integerValue] == 1)
        self.navigationItem.title = TITLE_TABLES;
    
    else if ([[parameters valueForKey:@"product_category_id"]integerValue] == 2)
        self.navigationItem.title = TITLE_CHAIRS;
    
    else if ([[parameters valueForKey:@"product_category_id"]integerValue] == 3)
         self.navigationItem.title = TITLE_SOFAS;
    
    else if ([[parameters valueForKey:@"product_category_id"]integerValue] == 4)
        self.navigationItem.title = TITLE_BEDS;
    
    if (self.checkView)
    {
        [self addBackButtonOnNavigationBar];
    }
    else
    {
        [self addLeftMenuButtonOnNavigationBar];
    }
    [self addRightSearchButtonOnNavigationBar];
}

-(void)buttonSearchClicked
{
    //NSLog(@"buttonSearchClicked");
}
#pragma mark - TableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return [arrayProductList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (IS_IPHONE4)
        height = 83.2;
    else if ((IS_IPHONE5) || (IS_IPHONE6PLUS))
        height = 84;
    else if (IS_IPHONE6)
        height = 86;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.productListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    ProductListTableViewCell *cell = [self.productListTableView dequeueReusableCellWithIdentifier:PRODUCT_LIST_VIEW_CELL_ID];
    if (cell == nil)
    {
        cell = [[ProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PRODUCT_LIST_VIEW_CELL_ID];
    }
    
    productRating = [[[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"rating"]integerValue];
    
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:[[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"product_images"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    //[cell.productImageView sd_setImageWithURL:[NSURL URLWithString:[[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"product_images"]]];
    
    cell.labelProductName.text = [[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.labelProductProducer.text =  [[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"producer"];
    cell.labelProductCost.text = [NSString stringWithFormat:@"₹%@",[[[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"cost"]stringValue]];
    
    for(int ratingCount=1; ratingCount<=5; ratingCount++)
    {
        if(ratingCount<=productRating)
        {
            UIImageView *ratingImage=(UIImageView*)[cell viewWithTag:ratingCount];
            ratingImage.image=[UIImage imageNamed:IMAGE_STAR_FILLED];
        }
        else if((ratingCount>productRating)&&(ratingCount<=5))
        {
            UIImageView *ratingImage=(UIImageView*)[cell viewWithTag:ratingCount];
            ratingImage.image=[UIImage imageNamed:IMAGE_STAR_UNFILLED];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.productListTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductDetailsViewController *vc = (ProductDetailsViewController *)  [Utils instantiateViewControllerWithId:PRODUCT_DETAILS_VIEW_CONTROLLER_ID];
    
    vc.productID = [[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"id"];
    vc.productName = [[arrayProductList objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [cell setPreservesSuperviewLayoutMargins:NO];
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSArray *visibleCells = [self.productListTableView visibleCells];
    if ([visibleCells count]>0)
    {
        ProductListTableViewCell *vc  = [visibleCells lastObject];
        NSIndexPath *tag= [self.productListTableView indexPathForCell:vc];
        
        [self.view makeToast:[NSString stringWithFormat:@"%ld of %lu", (long)tag.row+1,(unsigned long)[arrayProductList count]] duration:1 position:CSToastPositionBottom style:nil];
    }
}

@end
