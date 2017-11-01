//
//  AppDelegate.m
//  ColoringBook
//
//  Created by MacBook Pro on 12/17/16.
//  Copyright © 2016 Odyssey. All rights reserved.
//

#import "AppDelegate.h"
#import "ColoringBook-Swift.h"
#import <Chartboost/Chartboost.h>
#import "UnityAds/UnityAds.h"

@interface AppDelegate () <ChartboostDelegate, UnityAdsDelegate>




@end
@import Firebase;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.statusBarHidden = true ;
    [Chartboost startWithAppId:@"4f21c409cd1cb2fb7000001b" appSignature:@"92e2de2fd7070327bdeb54c15a5295309c6fcd2d" delegate:self];
    [UnityAds initialize:@"1088169" delegate:self];
    
    
    //[Chartboost cacheRewardedVideo:CBLocationHomeScreen];
    [FIRApp configure];
    /*NSDate *myDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:myDate forKey:@"startTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    
    return YES;
}
- (void)didInitialize:(BOOL)status {
    NSLog(@"didInitialize");
    // chartboost is ready
    [Chartboost cacheRewardedVideo:CBLocationHomeScreen];
    
    // Show an interstitial whenever the app starts up
    //[Chartboost showInterstitial:CBLocationHomeScreen];
}
- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {
    NSLog(@"completed rewarded video view at location %@ with reward amount %d", location, reward);
}
- (void)didCacheRewardedVideo:(CBLocation)location{
    NSLog(@"didCacheRewardedVideo");
}
- (void)didCloseRewardedVideo:(CBLocation)location{
    NSLog(@"didCloseRewardedVideo");
    
    
    //[UnityAds show:customVC placementId:@"video"];
}
- (BOOL)shouldDisplayRewardedVideo:(CBLocation)location{
    NSLog(@"shouldDisplayRewardedVideo");
    return YES;
}
- (void)didFailToLoadRewardedVideo:(CBLocation)location withError:(CBLoadError)error{
    NSLog(@"didFailToLoadRewardedVideo");
    [_customVC unityRewardAd];
}
- (void)didFailToLoadInterstitial:(NSString *)location withError:(CBLoadError)error {
    NSLog(@"didFailToLoadInterstitial");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ColoringBook"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
