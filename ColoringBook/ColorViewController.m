//
//  ColorViewController.m
//  ColoringBook
//
//  Created by MacBook Pro on 1/2/17.
//  Copyright © 2017 Odyssey. All rights reserved.
//

#import "ColorViewController.h"
#import "FloodFill.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+FloodFill.h"
#import "ColoringBook-Swift.h"
#import "AppDelegate.h"

@interface ColorViewController () < UIScrollViewDelegate >
{
    SharingViewController *sharingView;
    WhellController *wheelController;
    UIColor *currentColor;
    
}

@end

@implementation ColorViewController

@synthesize editImageView;
@synthesize scrollView;
//@synthesize newvc;

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"I am here in ScrollView Delegate ");
    return editImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img = _dataImage ;
    
    editImageView.tolorance = 0 ;
    [editImageView setImage:img];
    editImageView.scrollView = scrollView ;
    scrollView.minimumZoomScale = 1.0 ;
    scrollView.maximumZoomScale = 10.0 ;
    
    wheelController = ((WhellController *) [self.storyboard instantiateViewControllerWithIdentifier: @"whellVC"]);
    wheelController.imageView = editImageView ;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        wheelController.view.frame = CGRectMake(self.view.center.x-250, self.view.frame.size.height - 370, 500, self.view.frame.size.height);//self.view.frame;
        //wheelController.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height);//2 * self.view.center.y + wheelController.view.frame.size.height/2 - 175);//200
    }
    else{
        wheelController.view.frame = CGRectMake(self.view.center.x-112.5, self.view.frame.size.height - 200, 225, self.view.frame.size.height);//self.view.frame;
        
        //wheelController.view.center = CGPointMake(self.view.center.x, wheelController.view.frame.size.height+112.5);//200
    }

    
    [self.view addSubview:wheelController.view];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wheelController.view];
    
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [wheelController removeFromParentViewController];
    [wheelController.view removeFromSuperview];
    wheelController = ((WhellController *) [self.storyboard instantiateViewControllerWithIdentifier: @"whellVC"]);
    wheelController.imageView = editImageView ;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        wheelController.view.frame = CGRectMake(self.view.center.x-250, self.view.frame.size.height - 370, 500, self.view.frame.size.height);//self.view.frame;
        //wheelController.view.center = CGPointMake(self.view.center.x, wheelController.view.frame.size.height+250);//2 * self.view.center.y + wheelController.view.frame.size.height/2 - 175);//200
    }
    else{
        wheelController.view.frame = CGRectMake(self.view.center.x-112.5, self.view.frame.size.height - 200, 225, self.view.frame.size.height);//self.view.frame;
        
        //wheelController.view.center = CGPointMake(self.view.center.x, wheelController.view.frame.size.height+112.5);//200
    }
    

    
    [self.view addSubview:wheelController.view];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wheelController.view];
}


- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)saveImage:(UIBarButtonItem *)sender
{
    sharingView = ((SharingViewController *) [self.storyboard instantiateViewControllerWithIdentifier: @"SharingViewController"]);
    sharingView.coloredImage = editImageView.image;
    
    
    [NewViewController helloNewVC : editImageView.image];
    
    // Save Data To Core Data
    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    NSManagedObject *entityNameObj = [NSEntityDescription insertNewObjectForEntityForName:@"Draft" inManagedObjectContext:context];
    [entityNameObj setValue:UIImagePNGRepresentation(editImageView.image) forKey:@"image"];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) saveContext];
    // Saving Data to Core Data finished
    
    [self presentViewController:sharingView animated:false completion:nil];
    //[self performSegueWithIdentifier:@"SharingViewController" sender:self];
    //UIImageWriteToSavedPhotosAlbum(editImageView.image, nil, nil, nil);
}


- (IBAction)shareImage:(UIBarButtonItem *)sender
{
    
    NSArray *objectsToShare = @[editImageView.image];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (UIColor*)getRandomColor
{
    
    
    currentColor = wheelController.selectedColor;
    
    CGFloat hue, saturation, brightness, alpha;
    
    [currentColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
