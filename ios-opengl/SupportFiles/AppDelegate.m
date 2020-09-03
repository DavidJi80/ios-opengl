//
//  AppDelegate.m
//  ios-opengl
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 TongArk. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)navigationApp{
    // 创建UIWindows对象
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置UIWindows的背景色
    self.window.backgroundColor=[UIColor whiteColor];
    // 创建ViewController
    ViewController *vc=[[ViewController alloc]init];
    // 创建导航控制器
    UINavigationController * navc=[[UINavigationController alloc]initWithRootViewController:vc];
    // 设置root view
    self.window.rootViewController =navc;
    // 设置window为主window且可见
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self navigationApp];
    return YES;
}



@end
