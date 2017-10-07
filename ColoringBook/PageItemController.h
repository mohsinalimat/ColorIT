//
//  PageItemController.h
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageItemController : UIViewController

// Item controller information
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic, strong) NSString *imageName;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end
