//
//  ProductDetailsViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/30/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeoSTORE_All_Header.pch"
#import "CustomActionSheet.h"
#import "KLCPopup.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface ProductDetailsViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
#pragma mark - Instance Variables
{
    NSMutableArray *arrayProductDetails;
    NSDictionary *parameters;
    NSDictionary *cartParameters;
    NSInteger rating;
    NSArray *arrayProductImages;
    NSString *categoryName;
    int ratingCount;
    NSInteger rateCount;
    NSURL *imageUrl;
    NSURL *productURL;
    UIImage *productImageForShare;
    UIImageView *categoryImageView;
    
    BOOL buyActive;
    BOOL rateActive;
    KLCPopup *popup1;
    
    KLCPopup *popup2;
    
    NSIndexPath *selectedIndexPath;
    NSIndexPath *tempIndexPath;
    
    BOOL isRatingMethodCall;
}

@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) NSString *productName;
@property (nonatomic, strong) CustomActionSheet *customActionSheet;

#pragma mark - ByeNow Popup
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *popUpScrollView;
@property (weak, nonatomic) IBOutlet UIView *buyNowPopUpView;
@property (weak, nonatomic) IBOutlet UIImageView *popupProductImageView;
@property (weak, nonatomic) IBOutlet UITextField *popUpEditQuantity;
@property (weak, nonatomic) IBOutlet UILabel *popUpLabelProductName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popUpByeNowWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popUpByeNowHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popUpImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBuyNowWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBuyNowHeight;

- (IBAction)popUpButtonAddTOCart:(id)sender;
- (IBAction)buttonCloseBuyNowPopUp:(id)sender;

#pragma mark - ratePopup
@property (weak, nonatomic) IBOutlet UIView *ratePopUpView;
@property (weak, nonatomic) IBOutlet UILabel *ratePopUpLabelProductName;
@property (weak, nonatomic) IBOutlet UIImageView *ratePopUpProductImageView;

- (IBAction)ratePopUpButtonRateNow:(id)sender;
- (IBAction)ratePopUpButtonRating:(id)sender;
- (IBAction)buttonCloseRatePopUp:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratePopUpViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratePopUpViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratePopUpProductImageViewHeight;

@property (weak, nonatomic) IBOutlet UIView *productLabelView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIScrollView *middleView;

@property (weak, nonatomic) IBOutlet UILabel *labelProductName;
@property (weak, nonatomic) IBOutlet UILabel *labelProductCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelProducer;
@property (weak, nonatomic) IBOutlet UILabel *labelProductCost;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *productImagesCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (weak,nonatomic) UICollectionViewCell *myCell;
@property (weak, nonatomic) IBOutlet UILabel *labelProductDescription;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;

@property (weak, nonatomic) IBOutlet UIView *scrollViewContentView;


@property (weak, nonatomic) IBOutlet UIButton *buttonBuyNow;
- (IBAction)buttonBuyNow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonRate;
- (IBAction)buttonRate:(id)sender;

- (IBAction)buttonSocialShare:(id)sender;

@property (nonatomic, strong) CustomAlertView *customAlertView;

@end
