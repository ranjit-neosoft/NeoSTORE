//
//  LeftMenuViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/5/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    responseData = [[NSMutableArray alloc]init];
    [self initializeArray];
    self.SMTableView.delegate = self;
    self.SMTableView.dataSource = self;
    [self registerLeftMenuTableViewCell];
    [self callCartWebservice];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.buttonProfile.userInteractionEnabled = NO;
    [self callCartWebservice];
    
    if ((IS_IPHONE6) || (IS_IPHONE6PLUS))
    {
        [self.SMLabelUserName setFont:[UIFont fontWithName:@"Gotham-Medium" size:20]];
        [self.SMLeftMenuUserEmail setFont:[UIFont fontWithName:@"Gotham-Medium" size:16]];
    }
    
    self.SMLabelUserName.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_FIRSTNAME],[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_LASTNAME]];
    self.SMLeftMenuUserEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOGIN_EMAIL]];
    
    [self.buttonProfile setImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IMAGE_DATA]] forState:UIControlStateNormal];
    dispatch_async(dispatch_get_main_queue(),^{
        
        myCell.leftMenuMyCartQuantity.text = cartItems;
         [self.SMTableView reloadData];
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.buttonProfile.layer.borderWidth = 1.5f;
    self.buttonProfile.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonProfile.layer.cornerRadius = self.buttonProfile.frame.size.width / 2;
    self.buttonProfile.clipsToBounds = YES;
    dispatch_async(dispatch_get_main_queue(),^{
        
        myCell.leftMenuMyCartQuantity.text = cartItems;
         [self.SMTableView reloadData];
    });
    [self.SMTableView reloadData];
}

#pragma mark - Other Method Implementations
-(void)initializeArray
{
    arrayLeftMenuItems = [[NSArray alloc] initWithObjects: LEFT_MENU_MY_CART,HOME, LEFT_MENU_TABLE, LEFT_MENU_SOFAS, LEFT_MENU_CHAIRS, LEFT_MENU_BEDS, LEFT_MENU_MY_ACCOUNT, LEFT_MENU_STORE_LOCATOR, LEFT_MENU_MY_ORDERS, LEFT_MENU_LOYOUT,nil];
    
    arrayLeftMenuItemIconImages = [[NSArray alloc]initWithObjects: IMAGE_SM_MY_CART, IMAGE_HOME, IMAGE_SM_TABLES,IMAGE_SM_SOFAS, IMAGE_SM_CHAIRS, IMAGE_SM_BEDS, IMAGE_SM_MY_ACCOUNT,IMAGE_SM_STORE_LOCATOR, IMAGE_SM_MY_ORDERS, IMAGE_SM_LOYOUT,nil];
}

-(void)registerLeftMenuTableViewCell
{
    [self.SMTableView registerNib:[UINib nibWithNibName:LEFT_MENU_TABLE_VIEW_CELL bundle:nil] forCellReuseIdentifier:LEFT_MENU_TABLE_VIEW_CELL];
}

-(void)callCartWebservice
{
    [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:NULL withHud:NO User:NULL Screen:@"cart" AcessToken:[self getAccessToken] completionBlock:^(id response, NSString *error)
      {
          //NSLog(@"cart  :   %@",response);
          responseData = [response objectForKey:@"data"];
          cartItems = [[response objectForKey:@"count"] stringValue];
          dispatch_async(dispatch_get_main_queue(),^{
              if([[response objectForKey:@"sucess"] integerValue]== 200)
              {
                  [self.SMTableView reloadData];
              }
              });
    }];
}

#pragma mark - TableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayLeftMenuItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if ((IS_IPHONE4) || (IS_IPHONE5))
    {
        self.leftViewRightWidth.constant =80;
         height = 42;
    }
   else if (IS_IPHONE6)
    {
        self.leftViewRightWidth.constant =100;
           height = 48;
    }
    else if (IS_IPHONE6PLUS)
    {
        self.leftViewRightWidth.constant =115;//103.5;
        height = 54.9;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.SMTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.SMTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myCell = [self.SMTableView dequeueReusableCellWithIdentifier:LEFT_MENU_TABLE_VIEW_CELL];
    if (myCell == nil)
    {
        myCell = [[LeftMenuCellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LEFT_MENU_TABLE_VIEW_CELL];
    }
   
    myCell.leftMenuItemName.text = arrayLeftMenuItems[indexPath.row];
    myCell.leftMenuIconImageView.image = [UIImage imageNamed:arrayLeftMenuItemIconImages[indexPath.row]];
    
    if((indexPath.row == 0) && (![cartItems isKindOfClass:[NSNull class]]) && (cartItems != nil))
    {
        myCell.leftMenuMyCartQuantityView.hidden = NO;
        myCell.leftMenuMyCartQuantity.text = cartItems;
    }
    else
    {
        myCell.leftMenuMyCartQuantityView.hidden = YES;
    }
    return myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<[arrayLeftMenuItems count]; i++)
    {
        if (indexPath.row!=i)
        {
            [self tableView:tableView didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    selectedIndexPath = indexPath;
    myCell = (LeftMenuCellTableViewCell*)[self.SMTableView cellForRowAtIndexPath:indexPath];
    myCell.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.0];
    switch (indexPath.row)
    {
        case 0:
        {
           // NSLog(@"My Cart     :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(MyCartViewController *)[Utils instantiateViewControllerWithId:MY_CART_VIEW_CONTROLLER_ID]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 1:
        {
            //NSLog(@"Home     :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(HomeViewController *)[Utils instantiateViewControllerWithId:HOME_VIEW_CONTROLLER_ID]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 2:
        {
            //NSLog(@"Tables  :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(ProductListViewController *)[Utils instantiateViewControllerWithId:PRODUCT_LIST_VIEW_CONTROLLER_ID]]animated:YES];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:@"Category"];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 3:
        {
            //NSLog(@"Sofas   :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(ProductListViewController *)[Utils instantiateViewControllerWithId:PRODUCT_LIST_VIEW_CONTROLLER_ID]]animated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",3] forKey:@"Category"];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 4:
        {
            //NSLog(@"Chairs  :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(ProductListViewController *)[Utils instantiateViewControllerWithId:PRODUCT_LIST_VIEW_CONTROLLER_ID]]animated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",2] forKey:@"Category"];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 5:
        {
            //NSLog(@"Beds    :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(ProductListViewController *)[Utils instantiateViewControllerWithId:PRODUCT_LIST_VIEW_CONTROLLER_ID]]animated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",4] forKey:@"Category"];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 6:
        {
            //NSLog(@"My Account  :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(MyAccountViewController *)[Utils instantiateViewControllerWithId:MY_ACCOUNT_VIEW_CONTROLLER_ID]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 7:
        {
            //NSLog(@"Store Locator   :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(StoreLocatorViewController *)[Utils instantiateViewControllerWithId:STORE_LOCATOR_VIEW_CONTROLLER_ID]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 8:
        {
            //NSLog(@"My Orders   :   selected row: %ld",(long)indexPath.row);
            [self.sideMenuViewController setContentViewController:[[self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"] initWithRootViewController:(MyOrdersViewController *)[Utils instantiateViewControllerWithId:MY_ORDERS_VIEW_CONTROLLER_ID]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
            
        case 9:
        {
            //NSLog(@"Logout  :   selected row: %ld",(long)indexPath.row);
            [self logoutUser];
            break;
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuCellTableViewCell *cell = (LeftMenuCellTableViewCell*)[self.SMTableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
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

#pragma mark - Logout User
- (void)logoutUser
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOGOUT_TITLE message:LOGOUT_MESSAGE delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    if (buttonIndex == 1)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:KEY_LOGIN_STATUS];
        [defaults synchronize];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate showLoginViewController];
    }
}

@end
