//
//  DrawerViewController.h
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PANNING_VELOCITY 350
#define VSP_BUTTON_HEIGHT 90
#define VSP_TRANSITION_DURATION 0.2

@interface DrawerViewController : UIViewController

@property (nonatomic, weak) UIViewController *containerViewController;
//@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) NSString *sData;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) NSUInteger cc;

@end
