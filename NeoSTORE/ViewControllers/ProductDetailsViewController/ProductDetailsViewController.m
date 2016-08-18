//
//  ProductDetailsViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/30/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController

static NSString *identifier = @"Cell";

#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setImageViewSize];
    self.popUpEditQuantity.inputAccessoryView = [self getCancelAndDoneToolbar];
    self.popUpScrollView.hidden = YES;
    self.popUpScrollView.userInteractionEnabled = YES;
    
    self.ratePopUpView.hidden = YES;
    self.ratePopUpView.userInteractionEnabled = YES;
    
    [self makeCornerForButton: self.buttonBuyNow];
    [self makeCornerForButton: self.buttonRate];
    self.productLabelView.hidden = YES;
    self.buttonView.hidden = YES;
    self.middleView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showStatusBarOnViewController];
    [self loadNavigationItems];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        [self fetchProductDetailsFromServer];
    }
}

#pragma mark - Other Method Implementations
-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:PRODUCT_DETAILS_VIEW_CONTROLLER_ID];
    self.navigationItem.title = [NSString stringWithFormat:@"%@", self.productName];
    [self addBackButtonOnNavigationBar];
}

-(void)doneButtonToolbar
{
    [self.popUpEditQuantity endEditing:YES];
}

-(void)cancelButtonToolbar
{
    self.popUpEditQuantity.text = @"";
    [self.popUpEditQuantity endEditing:YES];
}

-(void) fetchProductDetailsFromServer
{
        parameters =  @{@"product_id":self.productID};
        
        [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:parameters withHud:YES User:@"products" Screen:@"getDetail" AcessToken:NULL completionBlock:^(id response, NSString *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if([[response valueForKey:@"status"] integerValue] == 200)
                 {
                     self.productLabelView.hidden = NO;
                     self.buttonView.hidden = NO;
                     self.middleView.hidden = NO;
                     arrayProductDetails = [response objectForKey:@"data"];
                     [self setDetails:arrayProductDetails];
                 }
                 else
                     [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
             });
         }];
}

-(void)setImageViewSize
{
    if (IS_IPHONE6)
        self.productImageViewHeight.constant = 183;
    else if (IS_IPHONE6PLUS)
    {
        self.productImageViewHeight.constant = 206;
        self.middleViewHeight.constant = 580.0f;
    }
    else
        self.productImageViewHeight.constant = 150;
}

-(void)setDetails : (NSMutableArray *)tempData
{
//    dispatch_async(dispatch_get_main_queue(),^{
//        rating = [[tempData valueForKey:@"rating"]integerValue];
//    });
//    
//   
//    arrayProductImages = [tempData valueForKey:@"product_images"];
//    
//    switch ([[tempData valueForKey:@"product_category_id"]integerValue])
//    {
//        case 1: categoryName = TABLE; break;
//        case 2: categoryName = CHAIR; break;
//        case 3: categoryName = SOFA; break;
//        default: categoryName = BED; break;
//    }
//
//    self.labelProductName.text =  [NSString stringWithFormat:@"%@", [tempData valueForKey:@"name"]];
//    self.labelProductCategory.text = [NSString stringWithFormat:@"Category - %@",categoryName];
//    self.labelProducer.text = [tempData valueForKey:@"producer"];
//    self.productDescription.text = [tempData valueForKey:@"description"];
//    self.labelProductCost.text = [NSString stringWithFormat:@"₹ %@",[[tempData valueForKey:@"cost"]stringValue]];
    
    dispatch_async(dispatch_get_main_queue(),^{
         rating = [[tempData valueForKey:@"rating"]integerValue];
        arrayProductImages = [tempData valueForKey:@"product_images"];
        
        switch ([[tempData valueForKey:@"product_category_id"]integerValue])
        {
            case 1: categoryName = TABLE; break;
            case 2: categoryName = CHAIR; break;
            case 3: categoryName = SOFA; break;
            default: categoryName = BED; break;
        }
        
        self.labelProductName.text =  [NSString stringWithFormat:@"%@", [tempData valueForKey:@"name"]];
        self.labelProductCategory.text = [NSString stringWithFormat:@"Category - %@",categoryName];
        self.labelProducer.text = [tempData valueForKey:@"producer"];
        self.productDescription.text = [tempData valueForKey:@"description"];
        self.labelProductCost.text = [NSString stringWithFormat:@"₹ %@",[[tempData valueForKey:@"cost"]stringValue]];

        
        for( ratingCount=1; ratingCount<=5; ratingCount++)
        {
            if(ratingCount<=rating)
            {
                UIImageView *ratingImage=(UIImageView*)[ self.view viewWithTag:ratingCount];
                ratingImage.image=[UIImage imageNamed:IMAGE_STAR_FILLED];
            }
            else if((ratingCount>rating)&&(ratingCount<=5))
            {
                UIImageView *ratingImage=(UIImageView*)[self.view viewWithTag:ratingCount];
                ratingImage.image=[UIImage imageNamed:IMAGE_STAR_UNFILLED];
            }
        }
        imageUrl = [NSURL URLWithString:[[arrayProductImages objectAtIndex:0] objectForKey:@"image"]];
        //[self.productImageView sd_setImageWithURL:imageUrl];
        
     [self.productImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [self.productImagesCollectionView reloadData];
    });
}

#pragma mark - Social Share Methods
- (IBAction)buttonSocialShare:(id)sender
{
    self.customActionSheet = [[CustomActionSheet alloc] initWithTitle:nil delegate:nil                        cancelButtonTitle:BUTTON_CANCEL destructiveButtonTitle:nil                                                     otherButtonTitles:FACEBOOK, TWITTER, nil];
    
    [self.customActionSheet showInView:self.view withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
     {
        if (buttonIndex == 0)
         {
             if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
             {
                 SLComposeViewController *fbPostSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                 [fbPostSheet setInitialText:[self getSocialPostProductDetails]];
                 //[fbPostSheet addURL:[self getProductShareURL]];
                 [fbPostSheet addImage:[self getProductImageToShare]];
                 [self presentViewController:fbPostSheet animated:YES completion:nil];
             }
             else
             {
                 [self showSocialAlert:FACEBOOK_ERROR_MESSAGE];
                 [self.customAlertView showInView:self.view withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
                  {
                      if (buttonIndex == 1)
                      {
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=FACEBOOK"]];
                      }
                  }];
            }
         }
         else if (buttonIndex == 1)
         {
             if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
             {
                 SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                 [tweetSheet setInitialText:[self getSocialPostProductDetails]];
                 //[tweetSheet addURL:[self getProductShareURL]];
                 [tweetSheet addImage:[self getProductImageToShare]];
                 [self presentViewController:tweetSheet animated:YES completion:nil];
             }
             else
             {
                 [self showSocialAlert:TWITTER_ERROR_MESSAGE];
                 [self.customAlertView showInView:self.view withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
                  {
                      if (buttonIndex == 1)
                      {
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];
                      }
                  }];
             }
         }
         else if (buttonIndex == 2)
         {
         }
     }];
}

-(void)showSocialAlert:(NSString*)message
{
    self.customAlertView = [[CustomAlertView alloc] initWithTitle:NeoSTORE message:message delegate:nil cancelButtonTitle:BUTTON_GO_TO_SETTING otherButtonTitles:BUTTON_CANCEL, nil];
}
-(NSString*)getSocialPostProductDetails
{
    return [NSString stringWithFormat:@"%@, Category: %@, producer: %@, Price: Rs.%@",[arrayProductDetails valueForKey:@"name"],categoryName,[arrayProductDetails valueForKey:@"producer"],[[arrayProductDetails valueForKey:@"cost"]stringValue]];
}

-(UIImage *)getProductImageToShare
{
    imageUrl = [NSURL URLWithString:[[arrayProductImages objectAtIndex:0] objectForKey:@"image"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
   return [UIImage imageWithData:imageData];
}

-(NSURL *)getProductShareURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?product_id=%@",GET_PRODUCT_DETAILS_URL, self.productID]];
}

#pragma mark - CollectionView Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([arrayProductImages count] > 0)
        return [arrayProductImages count];
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.productImagesCollectionView.allowsMultipleSelection = NO;
    UICollectionViewCell *cell = [self.productImagesCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *tempObjects = [arrayProductImages objectAtIndex:indexPath.row];
    imageUrl = [NSURL URLWithString:[tempObjects valueForKey:@"image"]];
    
    categoryImageView =(UIImageView*)[cell viewWithTag:100];
    [categoryImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self->selectedIndexPath = indexPath;
    cell.layer.borderWidth=1.0f;
    if(indexPath.row == 0)
    {
        self.myCell= cell;
        self.myCell.layer.borderColor=[UIColor redColor].CGColor;
    }
    else
        cell.layer.borderColor=[UIColor grayColor].CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    tempIndexPath = indexPath;
    imageUrl = [NSURL URLWithString:[[arrayProductImages objectAtIndex:indexPath.row] valueForKey:@"image"]];
    [self.productImageView sd_setImageWithURL:imageUrl];
    self.myCell.layer.borderColor = [UIColor grayColor].CGColor;
    
    UICollectionViewCell *cell =[self.productImagesCollectionView cellForItemAtIndexPath:indexPath];
    if (cell.selected)
        cell.layer.borderColor=[UIColor redColor].CGColor;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    tempIndexPath = indexPath;
    UICollectionViewCell *cell =[self.productImagesCollectionView cellForItemAtIndexPath:indexPath];
    if (cell.selected)
        cell.layer.borderColor= [UIColor redColor].CGColor;
    else
        cell.layer.borderColor= [UIColor grayColor].CGColor;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE6)
    {
        self.collectionViewHeight.constant = 77;
        return CGSizeMake(106, 77);
    }
    else if (IS_IPHONE6PLUS)
    {
        self.collectionViewHeight.constant = 86;
        return CGSizeMake(119, 86);
    }
     return CGSizeMake(88, 64);
}

#pragma mark - Button Methods Implementation
- (IBAction)buttonBuyNow:(id)sender
{
    buyActive = YES;
    if(rateActive == YES)
    {
        rateActive = NO;
        self.ratePopUpView.hidden = YES;
    }
    [[self.popUpEditQuantity layer] setBorderColor:[UIColor greenColor].CGColor];
    [self.popupProductImageView sd_setImageWithURL:imageUrl];
    popup1 = [[KLCPopup alloc]init];
    
    if(IS_IPHONE4)
    {
        self.popUpByeNowWidth.constant = 256.0f;//256
        self.popUpByeNowHeight.constant = 345.0f;//352
        self.popUpImageViewHeight.constant = 128.0f;
    }
    else if (IS_IPHONE5)
    {
        self.popUpByeNowWidth.constant = 256.0f;//256 - 345
        self.popUpByeNowHeight.constant = 345.0f;//440
        self.popUpImageViewHeight.constant = 150;//128
    }
    else if (IS_IPHONE6)
    {
        self.popUpByeNowWidth.constant = 295.0f;//295 - 400
        self.contentViewBuyNowWidth.constant = 295.0f;
        self.popUpByeNowHeight.constant = 400.0f;//540
        self.popUpImageViewHeight.constant = 175;
    }
    else if (IS_IPHONE6PLUS)
    {
        self.popUpByeNowWidth.constant = 382.0f;//382 - 580
        self.contentViewBuyNowWidth.constant = 382.0f;
        self.popUpByeNowHeight.constant = 580.0f;//608
        self.contentViewBuyNowHeight.constant = 580.0f;
        self.popUpImageViewHeight.constant = 200;//175
    }
    
    popup1 = [KLCPopup popupWithContentView:self.popUpScrollView
                                  showType:KLCPopupShowTypeSlideInFromTop
                               dismissType:KLCPopupDismissTypeSlideOutToBottom
                                  maskType:KLCPopupMaskTypeDimmed
                  dismissOnBackgroundTouch:YES
                     dismissOnContentTouch:NO];
    
    [self.popUpScrollView setHidden:NO];
    self.popUpEditQuantity.text = @"";
    [popup1 show];
}

- (IBAction)buttonRate:(id)sender
{
    rateActive = YES;
    
    if(buyActive == YES)
    {
        buyActive = NO;
        self.popUpScrollView.hidden = YES;
    }
    
    [self.ratePopUpProductImageView sd_setImageWithURL:imageUrl];
    
    popup2 = [[KLCPopup alloc]init];
    
    if(IS_IPHONE4)
    {
        self.ratePopUpViewWidth.constant = 256.0f;
        self.ratePopUpViewHeight.constant = 345.0f;//352
        self.ratePopUpProductImageViewHeight.constant = 128.0f;
    }
    else if (IS_IPHONE5)
    {
        self.ratePopUpViewWidth.constant = 256.0f;
        self.ratePopUpViewHeight.constant = 345.0f;//440
        self.ratePopUpProductImageViewHeight.constant = 150;//128
    }
    else if (IS_IPHONE6)
    {
        self.ratePopUpViewWidth.constant = 295.0f;
        self.ratePopUpViewHeight.constant = 400.0f;//540
        self.ratePopUpProductImageViewHeight.constant = 175;
    }
    else if (IS_IPHONE6PLUS)
    {
        self.ratePopUpViewWidth.constant = 382.0f;
        self.ratePopUpViewHeight.constant = 580.0f;//608
        self.ratePopUpProductImageViewHeight.constant = 200;//175
    }
    
    popup2 = [KLCPopup popupWithContentView:self.ratePopUpView
                                  showType:KLCPopupShowTypeSlideInFromTop
                               dismissType:KLCPopupDismissTypeSlideOutToBottom
                                  maskType:KLCPopupMaskTypeDimmed
                  dismissOnBackgroundTouch:YES
                     dismissOnContentTouch:NO];
    
    [self.ratePopUpView setHidden:NO];
    [popup2 show];
}

- (IBAction)popUpButtonAddTOCart:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.isReachable)
    {
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:NO_NETWORK];
    }
    else
    {
        NSString *errorMessage = [self validateFields];
        if (errorMessage)
        {
            [CustomAlertView showAlertWithOk:NeoSTORE withMessage:errorMessage];
        }
        else
        {
            int productQuantity = [self.popUpEditQuantity.text intValue];
            if (productQuantity == 0)
            {
                [CustomAlertView showAlertWithOk:NeoSTORE withMessage:@"Quantity must 1 to 7"];
            }
            else if (productQuantity >= 8)
            {
                [CustomAlertView showAlertWithOk:NeoSTORE withMessage:@"Quantity must 1 to 7"];
            }
            else
            {
                cartParameters = @{@"product_id":self.productID,@"quantity":self.popUpEditQuantity.text};
                
                [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:cartParameters withHud:YES User:NULL Screen:@"addToCart" AcessToken:[self getAccessToken] completionBlock:^(id  response,NSString *error)
                 {
                     dispatch_async(dispatch_get_main_queue(),^
                                    {
                                        if([[response valueForKey:@"status"]integerValue] == 200)
                                        {
                                            [self.popUpScrollView dismissPresentingPopup];
                                            [self.view makeToast:response[@"user_msg"] duration:1.5 position:CSToastPositionCenter];
                                        }
                                        else
                                        {
                                            self.popUpEditQuantity.text = @"";
                                            [self.popUpScrollView makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                                        }
                                    });
                 }];
            }
        }
    }
}

- (NSString *)validateFields
{
    NSString *errorMessage ;
    NSString *strNumber = [self.popUpEditQuantity.text removeWhiteSpaces];
    
    if ([strNumber length] == 0)
    {
        errorMessage =ENTER_QUANTITY;
        return errorMessage;
    }
    BOOL isNumbervalid = [strNumber validateNumbers];
    if (!isNumbervalid)
    {
        errorMessage =@"Quantity must 1 to 7";
        return errorMessage;
    }
    return 0;
}

- (IBAction)ratePopUpButtonRateNow:(id)sender
{
    if (isRatingMethodCall)
    {
        [self clearRatingStars:sender];
        [self.ratePopUpView setHidden:YES];
        [self.view endEditing:YES];
        cartParameters = @{@"product_id":self.productID,@"rating":[@(rateCount) stringValue]};
        
        [[WebserviceHelper sharedInstance] PostWebserviceWithParameterAndAccessToken:cartParameters withHud:YES User:@"products" Screen:@"setRating" AcessToken:NULL completionBlock:^(id  response,NSString *error)
         {
             //NSLog(@"RATE    :   %@",response);
             dispatch_async(dispatch_get_main_queue(),^
                            {
                                if([[response valueForKey:@"status"]integerValue] == 200)
                                {
                                    [self.ratePopUpView dismissPresentingPopup];
                                    [self.view makeToast:response[@"user_msg"] duration:1.5 position:CSToastPositionCenter];
                                    [self refreshView];
                                    isRatingMethodCall = false;
                                }
                                else
                                    [self.view makeToast:response[@"user_msg"] duration:1.0 position:CSToastPositionCenter];
                            });
         }];
        
    }
    else
        [CustomAlertView showAlertWithOk:NeoSTORE withMessage:RATE_PRODUCT];
}

-(void)refreshView
{
    parameters = @{@"product_id":self.productID};
    
     [[WebserviceHelper sharedInstance] GetWebserviceWithParameterAndAccessToken:parameters withHud:NO
                                                                            User:@"products" Screen:@"getDetail" AcessToken:NULL completionBlock:^(id response, NSString *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            arrayProductDetails = [response objectForKey:@"data"];
            [self setDetails:arrayProductDetails];
        });
    }];
}

- (IBAction)ratePopUpButtonRating:(id)sender
{
    isRatingMethodCall = true;
    UIButton *instanceButton = (UIButton*)sender;
    rateCount = (instanceButton.tag - 700);
    for(int count=1; count<=5; count++)
    {
        if(count<=rateCount)
        {
            instanceButton = (UIButton*)[self.ratePopUpView viewWithTag:700 + count];
            [instanceButton setImage:[UIImage imageNamed:IMAGE_STAR_FILLED] forState:UIControlStateNormal];
        }
        else if ((count>rateCount) && (count<=5))
        {
            instanceButton = (UIButton*)[self.ratePopUpView viewWithTag:700 + count];
            [instanceButton setImage:[UIImage imageNamed:IMAGE_STAR_UNFILLED] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)buttonCloseBuyNowPopUp:(id)sender
{
    self.popUpEditQuantity.text=@"";
    [self.popUpScrollView dismissPresentingPopup];
}

- (IBAction)buttonCloseRatePopUp:(id)sender
{
    [self clearRatingStars:sender];
    [self.ratePopUpView dismissPresentingPopup];
}

-(void)clearRatingStars:(id)sender
{
    UIButton *instanceButton = (UIButton*)sender;
    for(int count=1; count<=5; count++)
    {
        instanceButton = (UIButton*)[self.ratePopUpView viewWithTag:700 + count];
        [instanceButton setImage:[UIImage imageNamed:IMAGE_STAR_UNFILLED] forState:UIControlStateNormal];
    }
}

#pragma mark - ScrollView Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(selectedIndexPath.row == 0)
    {
        UICollectionViewCell *cell =[self.productImagesCollectionView cellForItemAtIndexPath:selectedIndexPath];
        cell.layer.borderColor=[UIColor grayColor].CGColor;
    }
    else
    {
        UICollectionViewCell *cell =[self.productImagesCollectionView cellForItemAtIndexPath: tempIndexPath];
        cell.layer.borderColor=[UIColor redColor].CGColor;
    }
}
@end
