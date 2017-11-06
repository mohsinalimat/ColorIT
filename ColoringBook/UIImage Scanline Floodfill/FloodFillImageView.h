//
//  FloodFillImageView.h
//  ImageFloodFilleDemo
//
//  Created by chintan on 11/07/13.
//  Copyright (c) 2013 ZWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+FloodFill.h"



@interface FloodFillImageView : UIImageView

@property int tolorance;
@property  UIScrollView *scrollView ;
@property (strong, nonatomic)  UIColor *newcolor;
@property NSMutableArray* stackColorUR; 
@property NSMutableArray* stackTouchLocationUR;
@property NSMutableArray* redoColorStack ;
@property NSMutableArray* redoTouchLocation ;
@end
