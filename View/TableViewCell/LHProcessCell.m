//
//  LHProcessCell.m
//  LHOASystem
//
//  Created by 刘航宇 on 2017/3/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHProcessCell.h"
#import "LHProessView.h"
#import "LHProssItem.h"
@interface LHProcessCell()
@property (nonatomic, strong) LHProessView * prossView;// 进度条

@end
@implementation LHProcessCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.prossView];
    }
    return self;
}
- (void)layoutSubviews
{
    //
    CGFloat margin = isPad?GLOBLE_MARGIN*3:GLOBLE_MARGIN;
    self.prossView.frame = CGRectMake(self.mj_w - margin - self.mj_w*0.3, self.mj_h*0.3, self.mj_w*0.3, self.mj_h*0.4);
    [super layoutSubviews];
}

#pragma mark ---------属性声明
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHProssItem class]]) {
        LHProssItem * model = (LHProssItem*)item;
        self.textLabel.text = model.leftTitle?:@"";
        self.textLabel.textColor = model.leftTitleColor?:BLACK;
        self.textLabel.font = model.leftTitleFont?:FONTSIZE(13);
        self.prossView.textLabel.textColor = model.valueColor?:WHITE;
        self.prossView.hilightColor = model.valueBgColor?:[LHThemeManager shared].naviColor;
        self.prossView.value = model.value;
    }
    [super setItem:item];
}
- (LHProessView *)prossView
{
    if (!_prossView) {
        _prossView = [[LHProessView alloc]init];
    }
    return _prossView;
}
@end
