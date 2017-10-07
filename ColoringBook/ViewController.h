//
//  ViewController.h
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSMutableArray *contentImages;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender;


@end

