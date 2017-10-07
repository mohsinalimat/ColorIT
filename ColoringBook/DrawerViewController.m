//
//  DrawerViewController.m
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import "ViewController.h"
#import "DrawerViewController.h"
#import "ColoringBook-Swift.h"
#import "ColorViewController.h"

@interface DrawerViewController () {
    
    //TableViewController *tableViewController;
    TabViewController *tabViewController;
    BOOL isSimilarPropertyViewVisible;
    ViewController *viewController;
    //ColorViewController *colorVC;
}
//@property (weak, nonatomic) IBOutlet UIView *actionView;
//@property (weak, nonatomic) IBOutlet UIButton *drawerButton;

@end

@implementation DrawerViewController


-(void)awakeFromNib {
    
    [super awakeFromNib];
    isSimilarPropertyViewVisible = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //tabBar.delegate = self;
    
    tabViewController = ((TabViewController *)[self.storyboard  instantiateViewControllerWithIdentifier:@"tabViewController"]);
    viewController = ((ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"]);
    //colorVC = ((ColorViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"colorVC"]);
    //drawerViewController = ((TabViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"TabViewController"]);
    
    //drawerViewController.containerViewController = self;
    
    tabViewController.view.frame = self.view.frame;
    tabViewController.view.center = CGPointMake(self.view.center.x, self.view.center.y + VSP_BUTTON_HEIGHT);
    //tabViewController.view.center = CGPointMake(tabViewController.view.center.x, 2 * self.view.center.y + tabViewController.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
    
    [self.view addSubview:tabViewController.view];
    //[drawerViewController.view.superview bringSubviewToFront:drawerViewController.view];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:tabViewController.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"]) {
        
    } else {
        
        if (isSimilarPropertyViewVisible)
        {
            [self openSimilarProperties:NO];
        }
        else{
            [self openSimilarProperties:YES];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirst"];
    }
    
    NSLog(@"%@", _sData);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawerPan:(UIPanGestureRecognizer *)sender {
    
    self.view.userInteractionEnabled = NO;
    self.view.superview.userInteractionEnabled = NO;
    
    CGPoint translation = [sender translationInView:self.view.superview];
    if (sender.view) {
        int currentCenterCoordinate = self.view.center.y + translation.y;
        if (currentCenterCoordinate <= self.view.superview.center.y + VSP_BUTTON_HEIGHT) {
            self.view.center = CGPointMake(self.view.center.x, self.view.superview.center.y + VSP_BUTTON_HEIGHT);
            [self openSimilarProperties:YES];
            
            return;
        }
        
        if (sender.state == UIGestureRecognizerStateEnded) {
            CGPoint gestureVelocity = [sender velocityInView: self.view.superview];
            if (currentCenterCoordinate <= 2 * self.view.superview.center.y) {
                if (gestureVelocity.y >= PANNING_VELOCITY) {
                    [self openSimilarProperties:NO];
                } else {
                    [self openSimilarProperties:YES];
                }
            } else {
                if (gestureVelocity.y <= -PANNING_VELOCITY) {
                    [self openSimilarProperties:YES];
                } else {
                    [self openSimilarProperties:NO];
                }
            }
        } else {
            self.view.center = CGPointMake(self.view.center.x, currentCenterCoordinate);
        }
    }
    
    [sender setTranslation:CGPointZero inView: self.view.superview];
}


- (IBAction)drawerTap:(UITapGestureRecognizer *)sender {
    
    if (isSimilarPropertyViewVisible) {
        [self openSimilarProperties:NO];
    }else{
        [self openSimilarProperties:YES];
    }
}

#pragma mark - View Similar Properties
-(void)openSimilarProperties:(BOOL) isTobeOpenned {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:VSP_TRANSITION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (isTobeOpenned) {
        self.view.center = CGPointMake(self.view.center.x, self.view.superview.center.y + 60);
        
        isSimilarPropertyViewVisible = YES;
    } else {
        self.view.center = CGPointMake(self.view.center.x, 2*self.view.superview.center.y + self.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
        isSimilarPropertyViewVisible = NO;
    }
    
    [UIView commitAnimations];
    
    
    if (isSimilarPropertyViewVisible) {
        //self.disclosureImageView.image = [UIImage imageNamed:@"closeDrawer"];
        //self.similarTitleLabel.text = @"Close Drawer";
        self.view.userInteractionEnabled = YES;
        self.view.superview.userInteractionEnabled = YES;
    } else {
        //self.disclosureImageView.image = [UIImage imageNamed:@"openDrawer"];
        //self.similarTitleLabel.text = @"Open Drawer";
        self.view.userInteractionEnabled = YES;
        self.view.superview.userInteractionEnabled = YES;
    }
}


//- (IBAction)editButton:(UIButton *)sender {
//    NSLog(@"SS 3: %@", _name);
//    colorVC.dataImage = _name;
//    //[self presentViewController:colorVC animated:YES completion:nil];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"imageData"]) {
        
        ColorViewController *destViewController = segue.destinationViewController;
        destViewController.dataImage = _image;
        //NSLog(@"SS: %lu", _cc);
    }
}




//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSInteger selectedTag = tabBar.selectedItem.tag;
//    NSLog(@"%ld",(long)selectedTag);
//    if (selectedTag == 0) {
//        //Do what ever you want here
//        NSLog(@"TAB 1");
//        
//        
////            tableViewController = ((TableViewController *)[self.storyboard  instantiateViewControllerWithIdentifier:@"tableView"]);
////            //drawerViewController = ((TabViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"TabViewController"]);
////            
////            //drawerViewController.containerViewController = self;
////            
////            tableViewController.view.frame = self.view.frame;
////            tableViewController.view.center = CGPointMake(tableViewController.view.center.x, 2 * self.view.center.y + tableViewController.view.frame.size.height/2 - VSP_BUTTON_HEIGHT);
////            
////            [self.view addSubview:tableViewController.view];
////            //[drawerViewController.view.superview bringSubviewToFront:drawerViewController.view];
////            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:tableViewController.view];
//        
//        
//    } else if(selectedTag == 1) {
//        //Do what ever you want
//        NSLog(@"TAB 2");
//    } else if(selectedTag == 2) {
//        //Do what ever you want here
//        NSLog(@"TAB 3");
//    } else if(selectedTag == 3) {
//        NSLog(@"TAB 4");
//    } else {
//        NSLog(@"NO TAB");
//    }
//}

@end
