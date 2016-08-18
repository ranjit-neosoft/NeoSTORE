//
//  StoreLocatorViewController.m
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "StoreLocatorViewController.h"

@interface StoreLocatorViewController ()

@end

@implementation StoreLocatorViewController
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNavigationItems];
    [self registerMyCartTableCell];
    [self initializeArray];
    self.mapView.delegate = self;
    [self addAnnotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showStatusBarOnViewController];
}

#pragma mark - Other Method Implementations
-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:STORE_LOCATOR_VIEW_CONTROLLER_ID];
    self.navigationItem.title = STORE_LOCATOR;
    [self addLeftMenuButtonOnNavigationBar];
    [self addRightSearchButtonOnNavigationBar];
}

-(void)registerMyCartTableCell
{
    [self.storeLocatorTableView registerNib:[UINib nibWithNibName:STORE_LOCATOR_TABLE_VIEW_CELL_ID bundle:nil] forCellReuseIdentifier:STORE_LOCATOR_TABLE_VIEW_CELL_ID];
}

-(void)initializeArray
{
    arrayStoreAddress = [[NSArray alloc] initWithObjects:  NeoSTORE_ADDRESS_DADAR, NeoSTORE_ADDRESS_PRABHADEVI, NeoSTORE_ADDRESS_RABALE, NeoSTORE_ADDRESS_PUNE,nil];
    
    arrayLatitude = [[NSArray alloc]initWithObjects:dadar_latitude,prabhadevi_latitude,rabale_latitude,pune_latitude, nil];
    
    arrayLongitude = [[NSArray alloc] initWithObjects:dadar_longitude,prabhadevi_longitude,rabale_longitude,pune_longitude, nil];
}

-(void)addAnnotations
{
    for (NSUInteger count = 0; count <= 3; count++)
    {
        storeAnnotation = [[MyAnnotation alloc] initLatitude:[[arrayLatitude objectAtIndex:count]doubleValue]  withLongitude:[[arrayLongitude objectAtIndex:count]doubleValue] withTitle:NeoSTORE withSubtitle:[arrayStoreAddress objectAtIndex:count] withImageName:@"store_locator"];
        [self.mapView addAnnotation:storeAnnotation];
    }
}


#pragma mark - TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayStoreAddress count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height =0;
    if (IS_IPHONE4)
    {
        height = 72;
        self.mapViewHeight.constant = 200;
    }
    else if (IS_IPHONE5)
    {
        height = 76;
        self.mapViewHeight.constant = 200;
    }
    else if (IS_IPHONE6)
    {
        height = 92;
         self.mapViewHeight.constant = 235;
    }
    else if (IS_IPHONE6PLUS)
    {
        height = 103;
        self.mapViewHeight.constant = 260;
    }
    return  height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.storeLocatorTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    StoreLocatorTableViewCell *cell = [self.storeLocatorTableView dequeueReusableCellWithIdentifier:STORE_LOCATOR_TABLE_VIEW_CELL_ID];
    if (cell == nil)
    {
        cell = [[StoreLocatorTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:STORE_LOCATOR_TABLE_VIEW_CELL_ID];
    }
    
    cell.labelStoreName.text = NeoSTORE;
    cell.labelStoreAddress.text = [arrayStoreAddress objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.storeLocatorTableView deselectRowAtIndexPath:indexPath animated:YES];
    [CustomAlertView showAlertWithOk:NeoSTORE withMessage:[arrayStoreAddress objectAtIndex:indexPath.row]];
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
