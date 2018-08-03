//
//  LHButtonItem.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/17.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LableItem.h"

@interface LHButtonItem : BaseItem
@property (nonatomic, strong) NSString * title;// 按钮名称
@property (nonatomic, strong) UIColor * titleColor;// 按钮标题颜色
@property (nonatomic, strong) UIColor * bgColor;// 背景颜色
@property (nonatomic, assign) CGFloat  radius;// 圆角半径
@property (nonatomic, strong) NSString * image;// 按钮图标
@property (nonatomic, strong) NSString * selectedImage;// 被选中的图片
@property (nonatomic, assign) NSString * bgImage;// 按钮背景图片
@property (nonatomic, assign) BOOL showLine;// 显示分割线
@property (nonatomic, assign) BOOL isSelected;// 是否被选中
@property (nonatomic, assign) UIControlContentHorizontalAlignment aligenment;
@end
