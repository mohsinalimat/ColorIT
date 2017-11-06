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
@import GoogleMobileAds;


@interface ColorViewController () < UIScrollViewDelegate,GADNativeExpressAdViewDelegate,GADInterstitialDelegate >
{
    SharingViewController *sharingView;
    WhellController *wheelController;
    UIColor *currentColor;
    __weak IBOutlet UIButton *undoBtn;
    __weak IBOutlet UIButton *redoBtn;
}

@end

@implementation ColorViewController

@synthesize editImageView;
@synthesize scrollView;
@synthesize nativeExpressAdView;
@synthesize  toolBar;
@synthesize interstitial;
//@synthesize newvc;

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"I am here in ScrollView Delegate ");
    return editImageView;
}

// MARK: - Google AdMob
-(void) showBannerAdOn
{
    
    self.nativeExpressAdView.adUnitID = @"ca-app-pub-3940256099942544/4270592515";
    self.nativeExpressAdView.rootViewController = self;
    nativeExpressAdView.delegate = self ;
    GADRequest *request = [GADRequest request];
    request.testDevices = [[NSArray alloc] initWithObjects:@"94bf2cef1fc4c0ca65d3b2806c70123a", @"9700d0add289a36421ea4776a2eb5e8c", nil];
    [self.nativeExpressAdView loadRequest:request];
    
}

-(void) showInterestitialAdOn
{
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(presentInterestitialAd)
                                   userInfo:nil
                                    repeats:NO];
    
    
    
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitialx =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitialx.delegate = self;
    [interstitialx loadRequest:[GADRequest request]];
    return interstitialx;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    self.interstitial = [self createAndLoadInterstitial];
}

-(void) presentInterestitialAd
{
    [self.interstitial presentFromRootViewController: self];
}


// MARK: - View Controllers


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImage *img = _dataImage ;
    //UIImage *imgNew = _dataImage ;
    
    editImageView.tolorance = 0 ;
    editImageView.stackColorUR = [[NSMutableArray alloc]init];
    editImageView.stackTouchLocationUR = [[NSMutableArray alloc]init];
    editImageView.redoColorStack = [[NSMutableArray alloc]init];
    editImageView.redoTouchLocation = [[NSMutableArray alloc]init];
    
    [editImageView setImage:img];
    editImageView.scrollView = scrollView ;
    scrollView.minimumZoomScale = 1.0 ;
    scrollView.maximumZoomScale = 10.0 ;
    /*scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width - 20, self.view.frame.size.width - 20);
    editImageView.frame = scrollView.frame;
    scrollView.center = self.view.center ;*/
    
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
    
   
    [self showBannerAdOn];
    [self showInterestitialAdOn];
    
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
    
    [self presentInterestitialAd];
    
}


-(void) viewDidAppear:(BOOL)animated
{
    
    
    //scrollView.backgroundColor = [UIColor blueColor];

}

- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}




// MARK: - Undo Redo Buttons

- (IBAction)undoButton:(UIButton *)sender
{
    printf("Undo\n");
    
    int stackSize = (int) editImageView.stackColorUR.count ;
    if ( stackSize > 0 )
    {
        
        
        UIColor *tempColor = editImageView.stackColorUR.lastObject;
        [editImageView.stackColorUR removeLastObject];
        CGPoint  tempPoint = [editImageView.stackTouchLocationUR.lastObject CGPointValue];
        [editImageView.stackTouchLocationUR removeLastObject];
        
        UIImage *image1 = [editImageView.image floodFillFromPoint:tempPoint withColor: tempColor andTolerance: 0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void)
        {
            [editImageView setImage:image1];
            [editImageView.redoColorStack addObject:tempColor];
            [editImageView.redoTouchLocation addObject:[NSValue valueWithCGPoint:tempPoint]];
        });
        
    }
    
    
    
    
    
    
    
    
}
- (IBAction)redoButton:(UIButton *)sender
{
    printf("Redo\n");
    int stackSize = (int) editImageView.redoColorStack.count ;
    if ( stackSize > 0 )
    {
        
        
        UIColor *tempColor = editImageView.redoColorStack.lastObject;
        [editImageView.redoColorStack removeLastObject];
        CGPoint  tempPoint = [editImageView.redoTouchLocation.lastObject CGPointValue];
        [editImageView.redoTouchLocation removeLastObject];
        
        UIImage *image1 = [editImageView.image floodFillFromPoint:tempPoint withColor: tempColor andTolerance: 0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           [editImageView setImage:image1];
                           [editImageView.stackColorUR addObject:tempColor];
                           [editImageView.stackTouchLocationUR addObject:[NSValue valueWithCGPoint:tempPoint]];
                       });
        
    }
    
    
    
    
}







- (IBAction)saveImage:(UIBarButtonItem *)sender
{
    sharingView = ((SharingViewController *) [self.storyboard instantiateViewControllerWithIdentifier: @"SharingViewController"]);
    sharingView.coloredImage = editImageView.image;
    sharingView.coloredImageNew = _dataImage;
    
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
