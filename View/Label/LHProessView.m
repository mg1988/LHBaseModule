//
//  LHProessLabel.m
//  LHOASystem
//
//  Created by 刘航宇 on 2017/3/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHProessView.h"
#import "LHProssItem.h"
@interface LHProessView()

@end
@implementation LHProessView
- (instancetype)init
{
    if (self = [super init]) {
        [self addContrants];// 添加视图
        self.backgroundColor = GRAYCOLOR;
      
    }
    return self;
}
- (void)addContrants
{
    [self addSubview:self.textLabel];// 添加视图
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)setValue:(CGFloat)value
{
    _value = value;
    self.textLabel.text = [self getTextValue:value];
    [self setNeedsDisplay];
}

- (NSString*)getTextValue:(CGFloat)value
{
    if (value > 100) {
        self.backgroundColor =self.hilightColor?: [LHThemeManager shared].naviColor;
        return [NSNumber numberWithFloat:value].stringValue;
    }else if(value < 0)
    {
        self.backgroundColor = self.hilightColor?:CLEARCOLOR;
       return [NSNumber numberWithFloat:value].stringValue;
    }else
    {
       
       return [NSString stringWithFormat:@"%.2f%%",value];
    }
}
- (void)layoutSubviews
{
     [self setNeedsDisplay];
    [super layoutSubviews];
}
- (void)drawRect:(CGRect)rect
{
    CGFloat width = (self.value / 100) * self.mj_w;
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, self.mj_h)];
    [self.hilightColor?:[LHThemeManager shared].naviColor setFill];
    [path fill];
    
}


#pragma mark --------属性声明
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font =FONTSIZE(13);
    }
    return _textLabel;
}
@end
