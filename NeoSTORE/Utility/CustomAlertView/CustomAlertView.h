//
//  CustomAlertView.h
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeoSTORE_All_Header.pch"

@interface CustomAlertView : NSObject <UIAlertViewDelegate>


@property (nonatomic, strong) UIAlertView *alertView;


@property (nonatomic, strong) void(^completionHandler)(NSString *, NSInteger);

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle  otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)showInView:(UIView *)view withCompletionHandler:(void(^)(NSString *buttonTitle, NSInteger buttonIndex))handler;

+ (void)showAlertWithTitleAndMessage:(NSString*)title withMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString *)message;
+ (void)showAlertWithOk:(NSString *)title withMessage:(NSString*)message;
+ (void)dismiss:(UIAlertView*)alert;
@end
