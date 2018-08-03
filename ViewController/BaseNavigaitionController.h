//
//  BaseNavigaitionController.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义导航控制器
 */
@interface BaseNavigaitionController : UINavigationController

@property (nonatomic, assign) BOOL isPresent;// 是否Presnet出来的
- (void)backItemDidClick;
@end
