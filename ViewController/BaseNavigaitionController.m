//
//  BaseNavigaitionController.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseNavigaitionController.h"


#define NAVIBACK @"ARROW---LEFT_b"// 导航栏返回按钮名称

@interface BaseNavigaitionController ()

@end
@implementation BaseNavigaitionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:[LHThemeManager shared].naviColor];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    if ([LHThemeManager shared].naviBgImage) {
        [[UINavigationBar appearance]setBackgroundImage:[LHThemeManager shared].naviBgImage forBarMetrics:UIBarMetricsDefault];
    }else
    {
        [[UINavigationBar appearance]setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        
    }
    //将返回按钮的文字设置不在界面显示
    if(iOS11_OR_LATER)
    {
        [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, 0) forBarMetrics:UIBarMetricsDefault];
    }else
    {
         [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, 0) forBarMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setTintColor:WHITE];
      [[UINavigationBar appearance] setBarTintColor:NAVIBACKCOLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:WHITE forKey:NSForegroundColorAttributeName]];

    
}

-(void)backItemDidClick
{
    if (self.isPresent) {
        if (self.viewControllers.count == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }

    }
    [self popViewControllerAnimated:YES];
}
@end
