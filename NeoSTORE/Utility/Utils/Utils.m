//
//  Utils.m
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIViewController *)instantiateViewControllerWithId:(NSString *)viewControllerID
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:viewControllerID];
}

//+ (void)showAlert:(NSString *)title withMessage:(NSString*)message
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
//}
@end
