//
//  MyOrdersViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "MyOrdersViewController.h"

@interface MyOrdersViewController ()

@end

@implementation MyOrdersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self registerMyOrdersTableCell];
    arrayMyOrdersData = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.myOrdersTableView.hidden = YES;
    [self callMyOrdersWebService];
    [self showStatusBarOnViewController];
}

-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:MY_ORDERS_VIEW_CONTROLLER_ID];
    self.navigationItem.title = MY_ORDERS;
    [self addLeftMenuButtonOnNavigationBar];
    [self addRightSearchButtonOnNavigationBar];
}

-(void)registerMyOrdersTableCell
{
     [self.myOrdersTableView registerNib:[UINib nibWithNibName:MY_ORDER_TABLE_VIEW_CELL_ID bundle:nil] forCellReuseIdentifier:MY_ORDER_TABLE_VIEW_CELL_ID];
}

-(void)callMyOrdersWebService
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:NULL withHud:YES User:NULL Screen:@"orderList" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
         {
             
             //NSLog(@"MY ORDERS   :   %@",response);
             if([[response valueForKey:@"status"] integerValue] == 200)
             {
                 arrayMyOrdersData = [response objectForKey:@"data"];
                 if(![arrayMyOrdersData isKindOfClass:[NSNull class]])
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.myOrdersTableView.hidden = NO;
                         [self.myOrdersTableView reloadData];
                     });
                 }
                 else
                     [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
             }
             else
                 [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
         }];
    }
}

#pragma mark - TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayMyOrdersData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =0;
    if ((IS_IPHONE4) || (IS_IPHONE5))
        height = 84;

    else if (IS_IPHONE6)
        height = 86;
    
    else if (IS_IPHONE6PLUS)
        height = 84;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myOrdersTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    MyOrdersTableViewCell *cell = [self.myOrdersTableView dequeueReusableCellWithIdentifier:MY_ORDER_TABLE_VIEW_CELL_ID];
    if (cell == nil)
    {
        cell = [[MyOrdersTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MY_ORDER_TABLE_VIEW_CELL_ID];
    }

    cell.labelID.text = [NSString stringWithFormat:@"Order ID : %@",[[arrayMyOrdersData objectAtIndex:indexPath.row] valueForKey:@"id"]];
    
    cell.labelDate.text = [NSString stringWithFormat:@"Ordererd Date : %@",[[arrayMyOrdersData objectAtIndex:indexPath.row] valueForKey:@"created"]];
    
    cell.labelCost.text = [NSString stringWithFormat:@"₹%@.00",[[arrayMyOrdersData objectAtIndex:indexPath.row] valueForKey:@"cost"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.myOrdersTableView deselectRowAtIndexPath:indexPath animated:YES];
        
    OrderDetailsViewController *vc = (OrderDetailsViewController *)  [Utils instantiateViewControllerWithId:ORDER_DETAILS_VIEW_CONTROLLER_ID];
    vc.orderID = [[arrayMyOrdersData objectAtIndex:indexPath.row] valueForKey:@"id"];
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

@end
