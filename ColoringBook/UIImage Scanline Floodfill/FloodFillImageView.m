//
//  FloodFillImageView.m
//  ImageFloodFilleDemo
//
//  Created by chintan on 11/07/13.
//  Copyright (c) 2013 ZWT. All rights reserved.
//
//
#import "FloodFillImageView.h"


@implementation FloodFillImageView

@synthesize tolorance,newcolor,scrollView;



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Get touch Point
    NSLog(@"I am here ");
    CGPoint tpoint = [[[event allTouches] anyObject] locationInView:self];
    
    //Convert Touch Point to pixel of Image
    //This code will be according to your need
    
    CGFloat factor = (self.image.size.height / self.frame.size.height) * scrollView.zoomScale ;
    tpoint.x = roundf( tpoint.x * factor ) ;
    tpoint.y = roundf( tpoint.y * factor ) ;
    
    
    
     NSLog(@"%f", factor);
     NSLog(@"%@", NSStringFromCGPoint(tpoint));
     NSLog(@"%@", NSStringFromCGSize(self.frame.size));
     NSLog(@"%@", NSStringFromCGSize(self.image.size));
    
    //Call function to flood fill and get new image with filled color
    

    
    UIImage *image1 = [self.image floodFillFromPoint:tpoint withColor:newcolor andTolerance:tolorance];
    dispatch_async(dispatch_get_main_queue(), ^(void)
    {
        [self setImage:image1];
        
    });
    
    
}
@end
