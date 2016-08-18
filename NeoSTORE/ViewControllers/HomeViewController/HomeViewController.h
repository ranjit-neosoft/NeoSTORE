//
//  HomeViewController.h
//  NeoSTORE
//
//  Created by webwerks on 6/27/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//UICollectionViewDelegate,UICollectionViewDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate

#import <UIKit/UIKit.h>

@interface HomeViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
#pragma mark - Instance Variables
{
    int currentIndex;
    NSArray *categoryArray;
    NSArray *categoryImagesArray;
    NSArray *sliderImagesArray;
}

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UIImageView *imageViewSlider;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong)NSTimer *imageChangeTimer;
@property (nonatomic) NSInteger sliderImageCount;
@end
