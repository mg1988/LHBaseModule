//
//  BaseTabBarController.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseTabBarController.h"
#import "LHHomeViewController.h"
#import "LHMessageViewController.h"
#import "LHMyViewController.h"
#import "LHContactsTableViewController.h"
#import "LHMessageManager.h"
#import "SP_HomeViewController.h"
#import "LHNewHomeViewController.h"
@implementation BaseTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.tabBar setTranslucent:YES];
     self.tabBar.tintColor = BLACK;
    [[UITabBar appearance]setBackgroundColor:WHITE];
    [[UITabBar appearance] setShadowImage:nil];
     [self addChildViewController:[SP_HomeViewController new] Title:@"首页" ImageName:@"tab_1" selectedImage:@"tab_h_1"];
     [self addChildViewController:[LHContactsTableViewController new] Title:@"通讯录" ImageName:@"tab_2" selectedImage:@"tab_h_2"];
      [self addChildViewController:[BaseViewController new] Title:@"同事圈" ImageName:@"tab_4" selectedImage:@"tab_h_4"];
     [self addChildViewController:[LHMyViewController new] Title:@"我的" ImageName:@"tab_5" selectedImage:@"tab_h_5"];
     // [self.tabBar setHidden:YES];
}

- (void)addChildViewController:(UIViewController *)childController Title:(NSString*)title ImageName:(NSString*)imageName selectedImage:(NSString *)selectedImage
{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = ImageNamed(imageName);
    childController.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.title = title;
    BaseNavigaitionController * navi = [[BaseNavigaitionController alloc]initWithRootViewController:childController];
    [self addChildViewController:navi];
    
}
@end
