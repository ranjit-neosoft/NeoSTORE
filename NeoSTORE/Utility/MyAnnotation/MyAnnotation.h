//
//  MyAnnotation.h
//  Mission Admission
//
//  Created by Swapnil on 19/01/16.
//  Copyright (c) 2016 RS_Electronics_ranjitsChougale. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation> {
    double latitude, longitude;
    NSString *title, *subtitle;
}

@property (nonatomic) NSString *imageName;

- (instancetype)initLatitude:(double)_latitude
               withLongitude:(double)_longitude
                   withTitle:(NSString *)_title
                withSubtitle:(NSString *)_subtitle
               withImageName:(NSString *)_imageName;

@end
