//
//  BaseViewController.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基类控制器 ，所有自定义视图控制器 均要继承这个基类
 */
@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIImageView * bgImageView;// 背景图
- (void)changeTheme:(NSNotification*)noti;
@end
