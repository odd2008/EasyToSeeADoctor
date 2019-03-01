//
//  AppDelegate.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "AppDelegate.h"
#import "FMLoginController.h"
#import "FMTabController.h"
#import "FMLoginController.h"
#import "FMFuntionController.h"
#import "FMNavController.h"
#import "FMtableController.h"
#import "FMMeController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerNotification];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FMLoginController *loginController = [[FMLoginController alloc] init];
    self.window.rootViewController = loginController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)registerNotification{
    /// 登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:UserDidLoginNotification object:nil];
    
    /// 退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
}
- (void)userDidLogin {
    if ([self.window.rootViewController class]==[FMTabController class]){
        return;
    }
    FMTabController *tabBarVc = [[FMTabController alloc] init];
    FMFuntionController *fcon = [[FMFuntionController alloc] init];
    FMNavController *nav1 = [[FMNavController alloc] initWithRootViewController:fcon];
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBarFunction"];
    nav1.tabBarItem.title = @"预约挂号";
    [tabBarVc addChildViewController:nav1];
    
    FMtableController *recordController = [[FMtableController alloc] init];
    FMNavController *nav2 = [[FMNavController alloc] initWithRootViewController:recordController];
    nav2.tabBarItem.image = [UIImage imageNamed:@"record"];
    nav2.tabBarItem.title = @"预约记录";
    [tabBarVc addChildViewController:nav2];
    
    FMMeController *meCon = [[FMMeController alloc] init];
    FMNavController *nav3 = [[FMNavController alloc] initWithRootViewController:meCon];
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBarMe"];
    nav3.tabBarItem.title = @"我";
    [tabBarVc addChildViewController:nav3];
    
    self.window.rootViewController = tabBarVc;
}
- (void)userDidLogout {
    FMLoginController *loginVc = [[FMLoginController alloc] init];;
    self.window.rootViewController = loginVc;
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
}


@end
