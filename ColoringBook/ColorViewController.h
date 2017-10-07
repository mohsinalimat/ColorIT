//
//  ColorViewController.h
//  ColoringBook
//
//  Created by MacBook Pro on 1/2/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloodFillImageView.h"


@interface ColorViewController : UIViewController
-(UIColor *) getCurrentWheelColor ;
@property (nonatomic, retain) UIImage *dataImage;
@property (strong, nonatomic) IBOutlet FloodFillImageView *editImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
 //= [[NewViewController alloc]] init ;
@end
