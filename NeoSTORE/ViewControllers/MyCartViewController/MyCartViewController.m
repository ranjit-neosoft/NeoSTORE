//
//  MyCartViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "MyCartViewController.h"

@interface MyCartViewController ()

@end

@implementation MyCartViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self registerMyCartTableCell];
    arrayCartData = [[NSMutableArray alloc]init];
    self.myCartEmptyView.hidden = YES;
    self.myCartTableView.hidden = YES;
   // [self fetchMyCartWebService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showStatusBarOnViewController];
    [self fetchMyCartWebService];
}

#pragma mark - Other Method Implementations
-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:MY_CART_VIEW_CONTROLLER_ID];
    self.navigationItem.title = MY_CART;
    [self addLeftMenuButtonOnNavigationBar];
    [self addRightSearchButtonOnNavigationBar];
}

-(void)registerMyCartTableCell
{
    [self.myCartTableView registerNib:[UINib nibWithNibName:MY_CART_PRODUCT_CELL_ID bundle:nil] forCellReuseIdentifier:MY_CART_PRODUCT_CELL_ID];
    
    [self.myCartTableView registerNib:[UINib nibWithNibName:MY_CART_TOTAL_CELL_ID bundle:nil] forCellReuseIdentifier:MY_CART_TOTAL_CELL_ID];
    
    [self.myCartTableView registerNib:[UINib nibWithNibName:MY_CART_BUTTON_CELL_ID bundle:nil] forCellReuseIdentifier:MY_CART_BUTTON_CELL_ID];
}

#pragma  mark - Webservice methods
-(void) fetchMyCartWebService
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        self.myCartEmptyView.hidden = YES;
        self.myCartTableView.hidden = YES;
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:NULL withHud:YES User:NULL Screen:@"cart" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
         {
             //NSLog(@"MY CART    :   %@",response);
             if ([[response valueForKey:@"status"] integerValue] == 200)
             {
                 arrayCartData = [response valueForKey:@"data"];
                 serverData = response;
                 if(![arrayCartData isKindOfClass:[NSNull class]])
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.myCartTableView.hidden = NO;
                         self.myCartEmptyView.hidden = YES;
                         [self.myCartTableView reloadData];
                     });
                 }
                 else
                 {
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        self.myCartEmptyView.hidden = NO;
                                        self.myCartTableView.hidden = YES;
                                    });
                 }
             }
             else
             {
                 self.myCartTableView.hidden = NO;
                 self.myCartEmptyView.hidden = YES;
                 [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
             }
         }];

    }
}

-(void) editMyCartWebService
{
    parameters = @{@"product_id":productID,
                                 @"quantity":[NSString stringWithFormat:@"%d",quantity],};
    
    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"editCart" Screen:NULL AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
    {
        //NSLog(@"EDIT CART    :   %@",response);
        if([[response objectForKey:@"status"]integerValue] == 200)
        {
            
            dispatch_async(dispatch_get_main_queue(),^{
               [self fetchMyCartDataFromServer];
                [self.myCartTableView reloadData];
                [self.view makeToast:response[@"user_msg"] duration:0.5 position:CSToastPositionCenter];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.view makeToast:response[@"user_msg"] duration:0.5 position:CSToastPositionCenter];
        });
        }
    }];
}

-(void) deleteMyCartItemWebService
{
    parameters = @{@"product_id":productID,};
    
    [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"deleteCart" Screen:NULL AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
    {
       // NSLog(@"DELETE CART    :   %@",response);
        cellDelete = YES;
        deleteResponse =[[NSMutableDictionary alloc]init];
        deleteResponse = response;
        
        if([[response valueForKey:@"status"]integerValue] == 200)
        {
            
            dispatch_async(dispatch_get_main_queue(),^
            {
                [self fetchMyCartDataFromServer];
                [self.myCartTableView reloadData];
                [self.view makeToast:response[@"user_msg"] duration:0.5 position:CSToastPositionCenter];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),^
            {
                [self.view makeToast:response[@"user_msg"] duration:0.5 position:CSToastPositionCenter];
            });
        }
    }];
}

-(void) fetchMyCartDataFromServer
{
    [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:NULL withHud:NO User:NULL Screen:@"cart" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
     {
         //NSLog(@"MY CART    :   %@",response);
         if ([[response valueForKey:@"status"] integerValue] == 200)
         {
             arrayCartData = [response valueForKey:@"data"];
             serverData = response;
             if(![arrayCartData isKindOfClass:[NSNull class]])
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.myCartTableView.hidden = NO;
                     self.myCartEmptyView.hidden = YES;
                     [self.myCartTableView reloadData];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    self.myCartEmptyView.hidden = NO;
                                    self.myCartTableView.hidden = YES;
                                });
             }
         }
         else
         {
             self.myCartTableView.hidden = NO;
             self.myCartEmptyView.hidden = YES;
             [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
         }
     }];

}
#pragma mark - TableView Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (section == 0)
        rows = [arrayCartData count];
    else if(section == 1)
        rows = 1;
    else if(section == 2)
        rows = 1;
    return rows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =0;
    if(![arrayCartData isKindOfClass:[NSNull class]])
    {
        if ([indexPath section] == 0)
        {
            if (IS_IPHONE4)
                height = 92;
            else if (IS_IPHONE5)
                height = 91;
            else if (IS_IPHONE6)
                height = 91;
            else if (IS_IPHONE6PLUS)
                height = 88;
        }
        else if (([indexPath section] == 1) || ([indexPath section] == 2))
            height = 70;
    }
    return  height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myCartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if(![arrayCartData isKindOfClass:[NSNull class]])
    {
          if([indexPath section] == 0)
        {
            productCell = [self.myCartTableView dequeueReusableCellWithIdentifier:MY_CART_PRODUCT_CELL_ID];
        
            NSURL *imageUrl = [NSURL URLWithString:[[[arrayCartData objectAtIndex:indexPath.row] objectForKey:@"product"] valueForKey:@"product_images"]];
            
            [productCell.productImageView sd_setImageWithURL:imageUrl];
            
            productCell.labelProductName.text = [[[arrayCartData objectAtIndex:indexPath.row] objectForKey:@"product"] valueForKey:@"name"];
            
           productCell.labelProductCategory.text = [NSString stringWithFormat:@"(%@)",[[[arrayCartData objectAtIndex:indexPath.row] objectForKey:@"product"] valueForKey:@"product_category"]];
            
            productCell.labelSubTotal.text =[NSString stringWithFormat:@"₹%@.00",[[[[arrayCartData objectAtIndex:indexPath.row] objectForKey:@"product"] valueForKey:@"sub_total"]stringValue]];
            
            
            productCell.buttonLabelProductQuantity.userInteractionEnabled = NO;
            
            [productCell.buttonLabelProductQuantity setTitle: [[[arrayCartData objectAtIndex:indexPath.row]  valueForKey:@"quantity"]stringValue] forState: UIControlStateNormal];
            productCell.buttonLabelProductQuantity.titleLabel.text = [[[arrayCartData objectAtIndex:indexPath.row]  valueForKey:@"quantity"]stringValue];
            
             productCell.buttonQuantityIncrement.tag =indexPath.row;
            productCell.buttonQuantityDecrement.tag = indexPath.row;
            [productCell.buttonQuantityIncrement addTarget:self action:@selector(incrementQuantity:) forControlEvents:UIControlEventTouchUpInside];
            [productCell.buttonQuantityDecrement addTarget:self action:@selector(decrementQuantity:) forControlEvents:UIControlEventTouchUpInside];
            
            return productCell;
        }
        else if([indexPath section] == 1)
        {
            totalCell = [self.myCartTableView dequeueReusableCellWithIdentifier:MY_CART_TOTAL_CELL_ID];
            totalCell.labelTotalCost.text = [NSString stringWithFormat:@"₹ %@.00",[serverData valueForKey:@"total"]];
            return totalCell;
        }
        else if([indexPath section] == 2)
        {
            orderNowCell = [self.myCartTableView dequeueReusableCellWithIdentifier:MY_CART_BUTTON_CELL_ID];
            orderNowCell.buttonOrderNow.tag = indexPath.row;
            [orderNowCell.buttonOrderNow addTarget:self action:@selector(orderNow:) forControlEvents:UIControlEventTouchUpInside];
            return orderNowCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==0)
    {
        [self.myCartTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        ProductDetailsViewController *vc = (ProductDetailsViewController *)  [Utils instantiateViewControllerWithId:PRODUCT_DETAILS_VIEW_CONTROLLER_ID];
        vc.productID = [[arrayCartData objectAtIndex:indexPath.row] valueForKey:@"product_id"];
        vc.productName = [[[arrayCartData objectAtIndex:indexPath.row] objectForKey:@"product"] valueForKey:@"name"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"          " ;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellDelete = NO;
    productID = [[arrayCartData objectAtIndex:indexPath.row] valueForKey:@"product_id"];
    [self deleteMyCartItemWebService];
    if(cellDelete)
        [arrayCartData removeObjectAtIndex:indexPath.row];
    else
    {
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           [self.view makeToast:deleteResponse[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                       });
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0)
        return UITableViewCellEditingStyleDelete;
    
    return UITableViewCellEditingStyleNone;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteAction ;
    if ([indexPath section] == 0)
    {
        deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"          "  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            cellDelete = NO;
            productID = [[arrayCartData objectAtIndex:indexPath.row] valueForKey:@"product_id"];
            [self deleteMyCartItemWebService];
            if(cellDelete)
                    [arrayCartData removeObjectAtIndex:indexPath.row];
            else
            {
                dispatch_async(dispatch_get_main_queue(),^
                {
                    [self.view makeToast:deleteResponse[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                });
            }
        }];
        deleteAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"delete"]];
    }
    return @[deleteAction];
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//}

#pragma mark - Selector methods
-(void)incrementQuantity:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myCartTableView];
    NSIndexPath *indexPath = [self.myCartTableView indexPathForRowAtPoint:buttonPosition];
    productCell= (MyCartProductCell *)[self.myCartTableView cellForRowAtIndexPath:indexPath];

    if ((quantity>= 0 ) || (quantity<= 8))
    {
        productID = [[arrayCartData objectAtIndex:sender.tag] valueForKey:@"product_id"];
        quantity =  [[productCell.buttonLabelProductQuantity titleForState:UIControlStateNormal]intValue];
        quantity ++;
       [self editMyCartWebService];
    }
   else
       [CustomAlertView showAlertWithOk:NeoSTORE withMessage:MAX_QUANTITY];
 }

-(void)decrementQuantity:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myCartTableView];
    NSIndexPath *indexPath = [self.myCartTableView indexPathForRowAtPoint:buttonPosition];
    productCell= (MyCartProductCell *)[self.myCartTableView cellForRowAtIndexPath:indexPath];

    if ((quantity>= 0 ) || (quantity<= 8))
    {
        productID = [[arrayCartData objectAtIndex:sender.tag] valueForKey:@"product_id"];
        quantity =  [[productCell.buttonLabelProductQuantity titleForState:UIControlStateNormal]intValue];
        quantity --;
        [self editMyCartWebService];
    }
    else
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:MAX_QUANTITY];
}

#pragma mark - Button Methods
-(void)orderNow:(UIButton *)sender
{
    AddAddressViewController *vc = (AddAddressViewController *) [Utils instantiateViewControllerWithId:ADD_ADDRESS_VIEW_CONTROLLER_ID];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
