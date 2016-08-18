//
//  StoreLocatorViewController.h
//  NeoSTORE
//
//  Created by webwerks on 7/6/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface StoreLocatorViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>
{
    NSArray *arrayStoreAddress;
    NSArray *arrayLatitude;
    NSArray *arrayLongitude;
    MyAnnotation *storeAnnotation;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *storeLocatorTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;

@end
