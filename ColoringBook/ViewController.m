//
//  ViewController.m
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import "ViewController.h"
//#import "PageItemController.h"
#import "DrawerViewController.h"
#import "ColoringBook-Swift.h"
#import "ColorViewController.h"

@interface ViewController () {
    DrawerViewController *drawerViewController;
    ColorViewController * colorVC;
    //TabViewController *drawerViewController;
    BOOL isSimilarPropertyViewVisible;
    NSUInteger count;
}


//@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self createPageViewController];
    //[self setupPageControl];
    NSLog(@"%f", ([[UIScreen mainScreen] bounds].size.width));
    NSLog(@"%f", ([[UIScreen mainScreen] bounds].size.height));
    count = 0;
    
    //NSBundle *mainBundle = [NSBundle mainBundle];
    //NSArray *pngs = [mainBundle pathsForResourcesOfType:@".png" inDirectory:@"folder"];
    
    //NSLog(@"pngs in my dir:%@", pngs);
    
    //_contentImages = [[NSMutableArray alloc] initWithArray:pngs];
    
    
    /*
    NSString *bundleRootPath = [[NSBundle mainBundle] bundlePath];
    NSArray *bundleRootContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundleRootPath error:nil];
    NSArray *files = [bundleRootContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self endswith '.png'"]];
    NSLog(@"%@", files);
    NSString *string = files[0];
    NSLog(@"%@", string);*/
    //_contentImages = [[NSMutableArray alloc] initWithArray:files];
    
    _imageView.image = _contentImages[count];
    
    
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    isSimilarPropertyViewVisible = NO;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!drawerViewController) {
        drawerViewController = ((DrawerViewController *)[self.storyboard  instantiateViewControllerWithIdentifier:@"DrawerViewController"]);
        //drawerViewController = ((TabViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"TabViewController"]);
        
        //drawerViewController.containerViewController = self;
        
        drawerViewController.view.frame = self.view.frame;
        drawerViewController.view.center = CGPointMake(drawerViewController.view.center.x, 2 * self.view.center.y + drawerViewController.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
        
        [self.view addSubview:drawerViewController.view];
        //[drawerViewController.view.superview bringSubviewToFront:drawerViewController.view];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:drawerViewController.view];
        
        drawerViewController.view.userInteractionEnabled = YES;
        drawerViewController.view.superview.userInteractionEnabled = YES;
        
        drawerViewController.sData = _data;
    }
    
    drawerViewController.image = _contentImages[count];
    //drawerViewController.cc = count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) createPageViewController {
//    
//    // Add all the images to the array
////    NSString *bundleRootPath = [[NSBundle mainBundle] bundlePath];
////    NSArray *bundleRootContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: bundleRootPath error: nil];
////    NSArray *files = [bundleRootContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self endswith '.png'"]];
//    
//    
////    NSString *bundleRootPath = [[NSBundle mainBundle] bundlePath];
////    NSArray *bundleRootContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundleRootPath error:nil];
////    NSArray *files = [bundleRootContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self beginswith '1' AND self endswith '.png'"]]; //you can provide your string in ' ' to filter specific content
//    
//    
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSArray *pngs = [mainBundle pathsForResourcesOfType:@".png"
//                                            inDirectory:@"folder"];
//    
//    //NSLog(@"pngs in my dir:%@", pngs);
//    
//    _contentImages = [[NSMutableArray alloc] initWithArray:pngs];
//    
//    // Add all the images to the image array
//    //_contentImages = [[NSMutableArray alloc] initWithArray:files];
//
//    
//    
//    //Create PageView Controller
//    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageController"];
//    pageController.dataSource = self;
//    if ([_contentImages count]) {
//        NSArray *startingViewControllers = @[[self itemControllerForIndex:0]];
//        [pageController setViewControllers:startingViewControllers
//                                 direction:UIPageViewControllerNavigationDirectionForward
//                                  animated:NO
//                                completion:nil];
//    }
//    
//    self.pageViewController = pageController;
//    //[self addChildViewController:self.pageViewController];
//    //[self.view addSubview:self.pageViewController.view];
//    //[self.pageViewController didMoveToParentViewController:self];
//    
//    // Change the size of page view controller
//    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200);
//    
//    [self addChildViewController:self.pageViewController];
//    [self.view addSubview:self.pageViewController.view];
//    [self.pageViewController didMoveToParentViewController:self];
//
//    
//}
//
//- (void)setupPageControl {
//    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
//    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
//    [[UIPageControl appearance] setBackgroundColor:[UIColor darkGrayColor]];
//}
//
//#pragma mark UIPageViewControllerDataSource
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
//    
//    PageItemController *itemController = (PageItemController *)viewController;
//    
//    count = [(PageItemController *)viewController itemIndex];
//    
//    if (count == 0) {
//        count = 0;
//    }
//    
//    count--;
//    drawerViewController.cc = count;
//    NSLog(@"SS: %lu", count);
//    
//    if (itemController.itemIndex > 0) {
//        return [self itemControllerForIndex:itemController.itemIndex-1];
//    }
//    
//    return nil;
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    PageItemController *itemController = (PageItemController *)viewController;
//    
//    count++;
//    
//    if (count == [_contentImages count]) {
//        count = [_contentImages count];
//    }
//    
//    drawerViewController.cc = count;
//    NSLog(@"SS: %lu", count);
//    
//    if (itemController.itemIndex+1 < [_contentImages count]) {
//
//        return [self itemControllerForIndex:itemController.itemIndex+1];
//    }
//    
//    return nil;
//}
//
//- (PageItemController *)itemControllerForIndex:(NSUInteger)itemIndex {
//    
//    if (itemIndex < [_contentImages count]) {
//        PageItemController *pageItemController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemController"];
//        pageItemController.itemIndex = itemIndex;
//        NSString *imgName = _contentImages[itemIndex];
//        //pageItemController.imageName = _contentImages[itemIndex];
//        pageItemController.imageName = imgName;
//        drawerViewController.name = imgName;
//        //drawerViewController.cc = count;
//        
//        return pageItemController;
//    }
//    
//    return nil;
//}
//
//
//#pragma mark Page Indicator
//
////- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
////{
////    return [_contentImages count];
////}
////
////- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
////{
////    return 0;
////}
//
//#pragma mark - Additions
//
//- (NSUInteger)currentControllerIndex {
//    PageItemController *pageItemController = (PageItemController *) [self currentController];
//    
//    if (pageItemController) {
//        return pageItemController.itemIndex;
//    }
//    
//    return -1;
//}
//
//- (UIViewController *)currentController {
//    if ([self.pageViewController.viewControllers count]) {
//        return self.pageViewController.viewControllers[0];
//    }
//    
//    return nil;
//}

- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *) sender direction];
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            count++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            count--;
            break;
            
        default:
            break;
    }
    
    count = (count < 0) ? ([_contentImages count] - 1): count % [_contentImages count];
    _imageView.image = _contentImages[count];
    
    drawerViewController.image = _contentImages[count];
    
}
@end
