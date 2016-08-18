//
//  HomeViewController.m
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "RESideMenu.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
static NSString * const reuseIdentifier = @"newCell";
#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
   [self showStatusBarOnViewController];
    [self loadNavigationItems];
    [self initializeArray];
    [self setImageViewHeight];
    [self.imageViewSlider setAnimationImages:@[[UIImage imageNamed:@"slider_img1.jpg"], [UIImage imageNamed:@"slider_img2.jpg"], [UIImage imageNamed:@"slider_img3.jpg"], [UIImage imageNamed:@"slider_img4.jpg"]]];
    
    [self.imageViewSlider setImage:[self.imageViewSlider.animationImages objectAtIndex:self.sliderImageCount]];
    [self.pageControlSlider setCurrentPage:self.sliderImageCount];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.imageViewSlider addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.imageViewSlider addGestureRecognizer:swipeRight];

}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    [self setSliderImageCount:[swipe direction] == UISwipeGestureRecognizerDirectionLeft ? (self.sliderImageCount + 1) : (self.sliderImageCount - 1)];
    [self setSliderImageCount:(self.sliderImageCount < 0) ? 0 : self.sliderImageCount];
    [self setSliderImageCount:(self.sliderImageCount > 3) ? 3 : self.sliderImageCount];
    [self.imageViewSlider setImage:[self.imageViewSlider.animationImages objectAtIndex:self.sliderImageCount]];
    [self.pageControlSlider setCurrentPage:self.sliderImageCount];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showStatusBarOnViewController];
}

-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:YES];
    //[self showStatusBarOnViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setImageViewHeight
{
    //int height;
    if(IS_IPHONE4)
    {
        self.imageViewHeightConstraint.constant = 196;
        //height = 196;
    }
    else if (IS_IPHONE5)
    {
        self.imageViewHeightConstraint.constant = 196;
       // height = 196;
    }
    else if (IS_IPHONE6)
    {
        self.imageViewHeightConstraint.constant = 230;//245
        //height = 245;
    }
    else if (IS_IPHONE6PLUS)
    {
        self.imageViewHeightConstraint.constant = 255;//270
       // height =  270;
    }
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];

   // return height;
}
#pragma mark - NavigationBarItems Methods
-(void)loadNavigationItems
{
    [self setFontAndColorNavaigationBarItems:HOME_VIEW_CONTROLLER_ID];
    self.navigationItem.title = NeoSTORE;
    
    [self addLeftMenuButtonOnNavigationBar];
    [self addRightSearchButtonOnNavigationBar];
}

#pragma mark - Other Method Implementations
//-(int)getHeight
//{
//    int height;
//    if(IS_IPHONE4)
//    {
//        self.scrollViewHeight.constant = 196;
//        height = 196;
//    }
//    else if (IS_IPHONE5)
//    {
//        self.scrollViewHeight.constant = 196;
//        height = 196;
//    }
//    else if (IS_IPHONE6)
//    {
//        self.scrollViewHeight.constant = 245;
//        height = 245;
//        //        [self.view updateConstraintsIfNeeded];
//        //        [self.view layoutIfNeeded];
//    }
//    else if (IS_IPHONE6PLUS)
//    {
//        self.scrollViewHeight.constant = 270;
//        height =  270;
//    }
//    return height;
//}

-(void)initializeArray
{
    //sliderImagesArray = [[NSArray alloc] initWithObjects: IMAGE_SLIDER1, IMAGE_SLIDER2, IMAGE_SLIDER3, IMAGE_SLIDER4, nil];
    categoryImagesArray = [[NSArray alloc]initWithObjects:IMAGE_TABLES,IMAGE_SOFAS,IMAGE_CHAIRS,IMAGE_BEDS, nil];
}

//-(void)setSliderImage
//{
//    int width = self.view.frame.size.width;
//    int height = [self getHeight];
//        self.pageControl = [[UIPageControl alloc] init];
//        self.pageControl.frame = CGRectMake(130,175,80,20);
//        self.pageControl.numberOfPages = 4;
//        self.pageControl.currentPage = 0;
//        [self.view addSubview:self.pageControl];
//        self.pageControl.backgroundColor = [UIColor redColor];
//    //int height = 196;
//    //NSLog(@"%d",width);
//    // NSLog(@"%d",height);
//    for (int index = 0; index < [sliderImagesArray count]; index++)
//    {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = [UIImage imageNamed:[sliderImagesArray objectAtIndex:index]];
//        
//        imageView.frame = CGRectMake(index * width, 0, width, height);
//        [self.homeScrollView addSubview:imageView];
//    }
//    self.homeScrollView.contentSize = CGSizeMake(width * [sliderImagesArray count], height);
//    self.imageChangeTimer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
//}

//- (void)changeImage
//{
//    //NSLog(@"changeImage");
//    
//    int width = self.homeScrollView.frame.size.width;
//    
//    if (currentIndex < [sliderImagesArray count])
//    {
//        self.homeScrollView.contentOffset = CGPointMake (currentIndex * width, 0);
//        currentIndex++;
//        self.pageControl.currentPage++;
//    }
//    else
//    {
//        currentIndex = 0;
//        self.pageControl.currentPage = 0;
//    }
//}

#pragma mark - CollectionView Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [categoryImagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *categoryImageView =(UIImageView*)[cell viewWithTag:112];
    categoryImageView.image= [UIImage imageNamed:[categoryImagesArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     ProductListViewController *vc = (ProductListViewController *) [Utils instantiateViewControllerWithId:PRODUCT_LIST_VIEW_CONTROLLER_ID];
    
    switch (indexPath.row)
    {
        case 0:
        {
            //table = 1
            //NSLog(@"category_ID: %ld    Table" ,indexPath.row + 1);
            vc.product_category_id = indexPath.row + 1;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",indexPath.row+1] forKey:@"Category"];
            vc.checkView = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 1:
        {
            //sofa = 3
            //NSLog(@"category_ID: %ld    sofa" ,indexPath.row + 2);
             vc.product_category_id = indexPath.row + 2;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", indexPath.row + 2] forKey:@"Category"];
            vc.checkView = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2:
        {
            //chair = 2
            //NSLog(@"category_ID: %ld    chair" ,indexPath.row);
            vc.product_category_id = indexPath.row;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"Category"];
            vc.checkView = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 3:
        {
            //bed = 4
           // NSLog(@"category_ID: %ld    bed" ,indexPath.row + 1);
            vc.product_category_id = indexPath.row + 1;
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", indexPath.row + 1] forKey:@"Category"];
            vc.checkView = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
}

#pragma mark - CollectionView SpaceMaintain
//Space maintained of collection view items
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth,padding,itemWidth;
    screenWidth = CGRectGetWidth(self.view.frame);
    padding = 20.0 * 3;
    itemWidth = (screenWidth - padding) / 2.0;
    return CGSizeMake(itemWidth, itemWidth);
}

//Maintained padding between items
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
}

@end
