//
//  MyAnnotation.m
//  Mission Admission
//
//  Created by Swapnil on 19/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize imageName;

- (instancetype)initLatitude:(double)_latitude
               withLongitude:(double)_longitude
                   withTitle:(NSString *)_title
                withSubtitle:(NSString *)_subtitle
               withImageName:(NSString *)_imageName{
    
    self = [super init];
    
    if (self) {
        self->latitude = _latitude;
        self->longitude = _longitude;
        self->title = _title;
        self->subtitle = _subtitle;
        self.imageName = _imageName;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    /*
     CLLocationCoordinate2D c;
     c.latitude = 18.499440;
     c.longitude = 73.859164;
     return c; */
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (NSString *)title {
    return title;
}

- (NSString *)subtitle {
    return subtitle;
}

@end
