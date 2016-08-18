//
//  AppDelegate.m
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize isReachable;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureReachability];
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
 
//    navigationController = (UINavigationController *)[Utils instantiateViewControllerWithId:HOME_NAVIGATION];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        if ([defaults boolForKey:KEY_LOGIN_STATUS])
        {
            [self showHomeNavigation];
        }
        else
        {
            [self showLoginViewController];
            
        }
    }
    return YES;
}

- (void)showHomeNavigation
{
     navigationController = (UIViewController *) [Utils instantiateViewControllerWithId:SM_ROOT_VIEW_CONTROLLER];
    self.window.rootViewController = navigationController;
}

- (void)showLoginViewController
{
    loginViewController = (LoginViewController *) [Utils instantiateViewControllerWithId:LOGIN_VIEW_CONTROLLER_ID];
    self.window.rootViewController = loginViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Reachability

- (void)configureReachability
{
    // To check the reachability for the Internet Connection
    //--- register notification to handle network change -----
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    if ([self.reachability currentReachabilityStatus] == NotReachable)
    {
        self.isReachable = NO;
    }
    else
    {
        self.isReachable = YES;
    }
}

- (void)handleNetworkChange:(NSNotification *)notice {
    //--- set the isReachable flag to YES or NO when network changes ---
    if ([self.reachability currentReachabilityStatus] == NotReachable) {
        self.isReachable = NO;
    }
    else if ([self.reachability currentReachabilityStatus] == ReachableViaWiFi) {
        self.isReachable = YES;
    }
    else if ([self.reachability currentReachabilityStatus] == ReachableViaWWAN) {
        self.isReachable = YES;
    }
}
@end
