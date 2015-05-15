//
//  AppDelegate.m
//  BaseFramework
//
//  Created by wendongsheng on 15/3/31.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置rootViewController
    [self settingHomeViewController];
    
    //设置键盘管理
    [self settingKeyboardManager];
    
    //初始化coreData
    [self setupCoreData];
    
    return YES;
}

- (void)setupCoreData{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"baseFramework"];
}

- (void)settingHomeViewController{
    BaseNavigationController *firstNC = [[BaseNavigationController alloc] initWithRootViewController:[FirstViewController new]];
    
    BaseNavigationController *secondNC = [[BaseNavigationController alloc] initWithRootViewController:[SecondViewController new]];
    
    BaseNavigationController *thirdNC = [[BaseNavigationController alloc] initWithRootViewController:[ThirdViewController new]];
    
    BaseNavigationController *fouthNC = [[BaseNavigationController alloc] initWithRootViewController:[FouthViewController new]];
    
    //初始化tabBarController
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    tabBarController.viewControllers = @[firstNC,secondNC,thirdNC,fouthNC];
    self.window.rootViewController = tabBarController;
    
    NSArray *titleArray = @[@"First",@"Second",@"Third",@"Fouth"];
    //设置tabBar
    for (int i = 0; i < tabBarController.tabBar.items.count; i++) {
        RDVTabBarItem *item = tabBarController.tabBar.items[i];
        item.title = titleArray[i];
        item.unselectedTitleAttributes = @{NSFontAttributeName: FONT(10),NSForegroundColorAttributeName: RGB_COLOR(95, 95, 95)};
        item.selectedTitleAttributes = @{NSFontAttributeName: FONT(10),NSForegroundColorAttributeName: RGB_COLOR(52, 152, 219)};
  
    }
}

- (void)settingKeyboardManager{
    //设置keyboardManager是否可用
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //设置键盘和textfield的距离
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:20];
    
    /**
     *  设置是否显示底部的黑框
     */
    [[IQKeyboardManager sharedManager] setPreventShowingBottomBlankSpace:YES];
    
    /**
     *  是否自动显示toobar
     */
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];//添加done的字样
    
    /**
     *  是否显示用户textfield的tintcolor
     */
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:YES];
    
    /**
     *  是否显示placeHolder
     */
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    /**
     *  适应textfield
     *
     *  @return <#return value description#>
     */
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
    
    /**
     *  点击外部使键盘收缩
     *
     *  @return <#return value description#>
     */
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [[IQKeyboardManager sharedManager] setShouldPlayInputClicks:YES];
    
    [[IQKeyboardManager sharedManager] setShouldAdoptDefaultKeyboardAnimation:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
