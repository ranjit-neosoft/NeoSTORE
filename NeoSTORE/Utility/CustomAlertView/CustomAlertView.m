//
//  CustomAlertView.m
//  NeoSTORE
//
//  Created by webwerks on 6/22/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
    self = [super init];
    if (self)
    {
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        va_list arguments;
        va_start(arguments, otherButtonTitles);
        NSString *currentButtonTitle = otherButtonTitles;
        while (currentButtonTitle != nil)
        {
            [self.alertView addButtonWithTitle:currentButtonTitle];
            currentButtonTitle = va_arg(arguments, NSString *);
        }
        va_end(arguments);
        
        [self.alertView addButtonWithTitle:cancelButtonTitle];
        [self.alertView setCancelButtonIndex:self.alertView.numberOfButtons - 1];
    }
    return self;
}

-(void)willPresentAlertView:(UIAlertView *)alertView
{
    UILabel *theTitle = [alertView valueForKey:@"_titleLabel"];
    // theTitle.font = [UIFont fontWithName:@"Copperplate" size:18];
    [theTitle setTextColor:[UIColor redColor]];
    
    //UILabel *theBody = [alertView valueForKey:@"_bodyTextLabel"];
    //theBody.font = [UIFont fontWithName:@"Copperplate" size:15];
    //[theBody setTextColor:[UIColor whiteColor]];
}

-(void)showInView:(UIView *)view withCompletionHandler:(void (^)(NSString *, NSInteger))handler
{
    _completionHandler = handler;
    
    [self.alertView show];
}

-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [self.alertView buttonTitleAtIndex:buttonIndex];
    
    _completionHandler(buttonTitle, buttonIndex);
}

+ (void)showAlertWithTitleAndMessage:(NSString*)title withMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
}

+ (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.5];
}

+ (void)showAlertWithOk:(NSString *)title withMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
@end
