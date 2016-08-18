//
//  MyCartProductCell.m
//  NeoSTORE
//
//  Created by webwerks on 7/11/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "MyCartProductCell.h"

@implementation MyCartProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    NSLog(@"EventTableCell willTransitionToState");
    [super willTransitionToState:state];
    [self overrideConfirmationButtonColor];
}

- (UIView*)recursivelyFindConfirmationButtonInView:(UIView*)view
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
    {
        // iOS 8+ code here
        for(UIView *subview in view.subviews)
        {
            if([NSStringFromClass([subview class]) rangeOfString:@"UITableViewCellActionButton"].location != NSNotFound)
                return subview;
            
            UIView *recursiveResult = [self recursivelyFindConfirmationButtonInView:subview];
            if(recursiveResult)
                return recursiveResult;
        }
    }
    
    else
    {
        // Pre iOS 8 code here
        for(UIView *subview in view.subviews)
        {
            if([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationButton"]) return subview;
            UIView *recursiveResult = [self recursivelyFindConfirmationButtonInView:subview];
            if(recursiveResult) return recursiveResult;
        }
    }
    return nil;
}

-(void)overrideConfirmationButtonColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *confirmationButton = [self recursivelyFindConfirmationButtonInView:self];
        if(confirmationButton)
        {
            confirmationButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"delete"]];
        }
    });
}

@end
