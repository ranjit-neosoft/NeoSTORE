//
//  OrderDetailsViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/13/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self registerOrderDetailsTableCell];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.orderDetailsTableView.hidden = YES;
    [self callOrderDetailsWebService];
    [self showStatusBarOnViewController];
}

-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:ORDER_DETAILS_VIEW_CONTROLLER_ID];
    self.navigationItem.title =[NSString stringWithFormat:@"Order ID : %@", self.orderID];
   [self addBackButtonOnNavigationBar];
    [self addRightSearchButtonOnNavigationBar];
}

-(void)registerOrderDetailsTableCell
{
     [self.orderDetailsTableView registerNib:[UINib nibWithNibName:ORDER_DETAILS_TABLE_VIEW_CELL_ID bundle:nil] forCellReuseIdentifier:ORDER_DETAILS_TABLE_VIEW_CELL_ID];
    
     [self.orderDetailsTableView registerNib:[UINib nibWithNibName:MY_CART_TOTAL_CELL_ID bundle:nil] forCellReuseIdentifier:MY_CART_TOTAL_CELL_ID];
}

-(void)callOrderDetailsWebService
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        NSDictionary *parameters = @{@"order_id":[NSString stringWithFormat:@"%@",self.orderID]};
        
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:parameters withHud:YES User:NULL Screen:@"orderDetail" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
         {
             // NSLog(@"ORDER DETAILS   :   %@",response);
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.orderDetailsTableView.hidden = NO;
                 if([[response valueForKey:@"status"] integerValue] == 200)
                 {
                     
                     arrayResponseData = [[response objectForKey:@"data"] objectForKey:@"order_details"];
                     serverData = response;
                     [self.orderDetailsTableView reloadData];
                 }
                 else
                     [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
             });
         }];

    }
}

#pragma mark - TableView Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (section == 0)
        rows = [arrayResponseData count];
    
    else if(section == 1)
        rows = 1;
    return rows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if ([indexPath section ] == 0)
        height = 93;
    else if ([indexPath section ] == 1)
        height = 70;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.orderDetailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if(![arrayResponseData isKindOfClass:[NSNull class]])
    {
        if([indexPath section] == 0)
        {
            productCell = [self.orderDetailsTableView dequeueReusableCellWithIdentifier:ORDER_DETAILS_TABLE_VIEW_CELL_ID];
            
            [productCell.orderDetailsImageView sd_setImageWithURL:[NSURL URLWithString:[[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"prod_image"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            
             //[productCell.orderDetailsImageView sd_setImageWithURL:[NSURL URLWithString:[[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"prod_image"]]];
            dispatch_async(dispatch_get_main_queue(),^{
                productCell.labelProductName.text = [[arrayResponseData objectAtIndex:indexPath.row]  valueForKey:@"prod_name"];
                
                productCell.labelProductCategory.text = [NSString stringWithFormat:@"(%@)",[[arrayResponseData objectAtIndex:indexPath.row]  valueForKey:@"prod_cat_name"]];
                
                productCell.labelQuantity.text = [NSString stringWithFormat:@"QTY : %@",[[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"quantity"]];
                
                productCell.labelCost.text = [NSString stringWithFormat:@"₹%@.00",[[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"total"]];
            });
            return productCell;
            
        }
        else if([indexPath section] == 1)
        {
            totalCell = [self.orderDetailsTableView dequeueReusableCellWithIdentifier:MY_CART_TOTAL_CELL_ID];
            
            dispatch_async(dispatch_get_main_queue(),^{
                totalCell.labelTotalCost.text = [NSString stringWithFormat:@"₹%@.00",[[serverData objectForKey:@"data"]  valueForKey:@"cost"]];
            });
            
            return totalCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0)
    {
        [self.orderDetailsTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        ProductDetailsViewController *vc = (ProductDetailsViewController *)  [Utils instantiateViewControllerWithId:PRODUCT_DETAILS_VIEW_CONTROLLER_ID];
        vc.productID = [[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"product_id"];
        vc.productName = [[arrayResponseData objectAtIndex:indexPath.row] valueForKey:@"prod_name"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
