//
//  BaseTableView.h
//  LHOASystem
//
//  Created by migenwei on 2017/9/13.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView
- (void)shakeAnimationWithTableView;

/*没有数据的时候 显示的提示语，默认是暂无数据*/
- (void)setTipText:(NSString*)tip;// 设置提示语

/* 只有设置了背景图 才会在没有数据的时候显示出来*/
- (void)setBgImage:(UIImage*)image;// 设置背景图
@end
