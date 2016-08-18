//
//  BaseViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark - Method Declaration
-(void)makeCornerForButton:(UIButton*)myButton;

-(void)initTextField:(UITextField*)editTextfield withImageName:(NSString *)imageName withPlaceholder:(NSString*)placeHolderName;

-(void)initTextField:(UITextField*)editTextfield withImageName:(NSString *)imageName;

-(void)addLeftMenuButtonOnNavigationBar;

-(void)addBackButtonOnNavigationBar;

-(void)addRightSearchButtonOnNavigationBar;

-(void)setFontAndColorNavaigationBarItems:(NSString *)viewControllerID;

-(void)resetUserDefaults;

-(void)setUserDefaults:(NSDictionary*)userDefaultsData withVC:(NSString *)viewControllerID;

-(NSString *)getAccessToken;

-(void)showStatusBarOnViewController;

-(UIToolbar *) getCancelAndDoneToolbar;

- (NSString *)imageToNSString:(UIImage *)image;

- (UIImage *)stringToUIImage:(NSString *)string;

- (BOOL)isPasswordValid:(NSString *)password;
-(BOOL)isPasswordMatch:(NSString *)pwd withConfirmPwd:(NSString *)cnfPwd;
@end
