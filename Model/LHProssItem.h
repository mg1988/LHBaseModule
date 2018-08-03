//
//  LHProssItem.h
//  LHOASystem
//
//  Created by 糜根维 on 17/3/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseItem.h"


/**
 用于有进度条展示的cell
 */
@interface LHProssItem : BaseItem
@property(nonatomic,strong) NSString* leftTitle;
@property(nonatomic,strong) UIFont* leftTitleFont;
@property(nonatomic,strong) UIColor* leftTitleColor;

@property(nonatomic,assign) CGFloat value;// 进度条数值
@property(nonatomic,strong) UIColor* valueBgColor;// 进度条数值背景颜色
@property(nonatomic,strong) UIColor* valueColor; // 进度条显示文本的颜色


@end
