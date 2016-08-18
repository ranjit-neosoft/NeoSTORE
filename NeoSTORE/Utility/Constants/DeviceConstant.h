//
//  DeviceConstant.h
//  Choovie
//
//  Created by webwerks on 11/03/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#ifndef DeviceConstant_h
#define DeviceConstant_h

#define IS_IPHONE4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE6PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)




#endif 

/* DeviceConstant_h */
