//
//  AppDelegate.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "AppDelegate.h"
#import <RESideMenu/RESideMenu.h>
#import "ViewController.h"
#import "MainUsercenterViewController.h"
#import "SecondViewController.h"
#import "FirstViewController.h"
#import <WeiboSDK/WeiboSDK.h>

#import <iRate.h>

@interface AppDelegate ()<RESideMenuDelegate,UITabBarControllerDelegate,EAIntroDelegate>
{
    UITabBarController *tabController;
    FirstViewController *first;
    UINavigationController *nav3;
}
@end

@implementation AppDelegate

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iRate sharedInstance].applicationBundleID = @"com.xincap.XinCap-New";
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    //enable preview mode
    [iRate sharedInstance].previewMode = YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WeiboSDK registerApp:@""];
    [WeiboSDK enableDebugMode:YES];
    
    UIApplication *ap = [UIApplication sharedApplication];
    //在设置之前, 要注册一个通知,从ios8之后,都要先注册一个通知对象.才能够接收到提醒.
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    //注册通知对象
    [ap registerUserNotificationSettings:notice];
   //设置提醒数字
    ap.applicationIconBadgeNumber = 120;
    ap.networkActivityIndicatorVisible = YES;
    
    [self setGuideView];
    return YES;
}

- (void)setGuideView{
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"GoodFreshfirstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GoodFreshfirstLaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用 (用户引导页面) 作为根视图
        EAIntroPage *page1 = [EAIntroPage page];
        page1.bgImage=[UIImage imageNamed:@"IMG_0237.jpg"];
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.bgImage=[UIImage imageNamed:@"IMG_0239.jpg"];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.bgImage=[UIImage imageNamed:@"IMG_0237.jpg"];
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
        intro.backgroundColor=[UIColor lightGrayColor];
        intro.pageControlY = 44+20;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setFrame:CGRectMake(0, 450, 230, 40)];
        [btn setTitle:@"立即体验" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor greenColor];
        intro.skipButton = btn;
        intro.skipButtonY = 160.f;
        intro.skipButtonAlignment = EAViewAlignmentCenter;
        [intro setDelegate:self];
        [self.window.rootViewController.view addSubview:intro];
    }else{
        //NSLog(@"不是第一次启动");
        [self initMainViewData:YES];
    }
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView{
    [self initMainViewData:YES];
}

- (void)initMainViewData:(BOOL)firstLoadBool{
    
    tabController=[[UITabBarController alloc] init];
    ViewController *viewController=[[ViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:viewController];
    nav.tabBarItem.title=@"FirstVC";
    nav.tabBarItem.image=[UIImage imageNamed:@"personCenter"];
    
    SecondViewController *secondViewController=[[SecondViewController alloc] init];
    UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:secondViewController];
    nav2.tabBarItem.title=@"SecondVC";
    nav2.tabBarItem.image=[UIImage imageNamed:@"personCenter"];
    
    tabController.viewControllers=@[nav,nav2];
    tabController.delegate = self;
    tabController.selectedIndex=0;
    //设置tabbar的文字颜色
    UIColor *tabTinColor =  [UIColor greenColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tabTinColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=[UIFont systemFontOfSize:30.0f];
//    [addButton setBackgroundColor:[UIColor greenColor]];
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [addButton sizeToFit];
    [tabController.tabBar addSubview:addButton];
//
    CGFloat w = tabController.tabBar.frame.size.width;
    CGFloat h = tabController.tabBar.frame.size.height;
//    CGFloat btnX = 0;
//    CGFloat btnY = 0;
//    CGFloat btnW = w / (tabController.viewControllers.count+1);
//    CGFloat btnH = h;
//    int i = 0;
//    //1 , 遍历当前tabBar上的所有view
//    for (UIView *tabBarBtn in tabController.tabBar.subviews) {
//        //2，如果是UITabBarButton，就取出来重新设置他们的位置
//        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            btnX = i * btnW;
//            tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//            //当到了第1个时候，再加一个位置添加按钮的位置。
//            if (i==0) {
//                i++;
//            }
//            i++;
//        }
//    }
//    //设置添加按钮 add按钮的位置
    addButton.center = CGPointMake(w * 0.5, h * 0.5);

    
    MainUsercenterViewController *mainUserVC=[[MainUsercenterViewController alloc] init];
    
    RESideMenu *sideMenuVC=[[RESideMenu alloc] initWithContentViewController:tabController
                                                      leftMenuViewController:mainUserVC
                                                     rightMenuViewController:nil];
    sideMenuVC.backgroundImage=[UIImage imageNamed:@""];
    sideMenuVC.menuPreferredStatusBarStyle=1;
    sideMenuVC.delegate=self;
    sideMenuVC.contentViewShadowColor = [UIColor blackColor];
    sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuVC.contentViewShadowOpacity = 0.6;
    sideMenuVC.contentViewShadowRadius = 12;
    sideMenuVC.contentViewShadowEnabled = YES;
    sideMenuVC.panGestureEnabled=NO;
    
    self.window.backgroundColor=[UIColor colorWithRed:122/255.0f green:123/255.0f blue:124/255.0f alpha:1.0f];
    self.window.rootViewController=sideMenuVC;
    
    viewController.firstLoadBool=firstLoadBool;
}

- (void)addButtonAction:(UIButton *)sender{
    if (first==nil) {
        first=[[FirstViewController alloc] init];
        nav3=[[UINavigationController alloc] initWithRootViewController:first];
    }
    [self.window.rootViewController presentViewController:nav3 animated:YES completion:nil];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (url != nil) {
        NSString *path = [url absoluteString];
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        if ([path hasPrefix:@"file://"]) {
            [string replaceOccurrencesOfString:@"file://" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, path.length)];
        }
        NSLog(@"stringstring = %@",string);
        
    }
    
    return YES;
}

//当我们应用程序即将失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"1%s",__func__);
}

//当我们应用程序完全进⼊后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"2%s",__func__);
}

//当我们应用程序即将进⼊前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"3%s",__func__);
    application.applicationIconBadgeNumber=0;
}

//当我们应用程序完全获取焦点的时候调用
//只有当一个应用程序完全获取到焦点,才能与用户交互.
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"4%s",__func__);
}

//当我们应用程序即将关闭的时候调用
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"5%s",__func__);
}

@end
