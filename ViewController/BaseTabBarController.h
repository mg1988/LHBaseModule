//
//  BaseTabBarController.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 自定义tableBar
 */
@interface BaseTabBarController : UITabBarController


/**
 添加子视图控制器

 @param childController 子控制器对象
 @param title           tableBar 名称
 @param imageName       tableBar 图片
 @param selectedImage   tableBar 选中图片
 */
- (void)addChildViewController:(UIViewController *)childController Title:(NSString*)title ImageName:(NSString*)imageName selectedImage:(NSString *)selectedImage;
@end
