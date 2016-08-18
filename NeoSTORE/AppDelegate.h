//
//  AppDelegate.h
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"
#import "Reachability.h"
@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginViewController *loginViewController;
    UIViewController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@property(assign,nonatomic)BOOL isReachable;
@property (strong, nonatomic) Reachability *reachability;

- (void)showHomeNavigation;
- (void)showLoginViewController;

@end

