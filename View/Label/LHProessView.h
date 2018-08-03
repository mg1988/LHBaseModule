//
//  LHProessLabel.h
//  LHOASystem
//
//  Created by 刘航宇 on 2017/3/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>

// 这个label可以显示进度
@interface LHProessView : UIView
@property (nonatomic, strong) UILabel * textLabel;// 用于显示的label
@property (nonatomic, assign) CGFloat value;// 显示的数据
@property (nonatomic, strong) UIColor * hilightColor;// 需要高亮显示的数据
@end
