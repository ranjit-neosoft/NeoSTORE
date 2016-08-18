//
//  CustomActionSheet.h
//  BlockDemo
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 Ranjits_NeoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomActionSheet : NSObject <UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet *actionSheet;


@property (nonatomic, strong) void(^completionHandler)(NSString *, NSInteger);

-(id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)showInView:(UIView *)view withCompletionHandler:(void(^)(NSString *buttonTitle, NSInteger buttonIndex))handler;

@end


