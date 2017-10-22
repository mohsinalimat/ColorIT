//
//  ColorViewController.h
//  ColoringBook
//
//  Created by MacBook Pro on 1/2/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloodFillImageView.h"
@import GoogleMobileAds;

@interface ColorViewController : UIViewController
-(UIColor *) getCurrentWheelColor ;
-(void) showBannerAdOn;
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, weak) IBOutlet GADNativeExpressAdView *nativeExpressAdView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) UIImage *dataImage;
@property (strong, nonatomic) IBOutlet FloodFillImageView *editImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
 //= [[NewViewController alloc]] init ;
@end
