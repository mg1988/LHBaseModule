//
//  TabMyOrderItemCell.m
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import "LHButtonsTableViewCell.h"
#import "LHButtonsItem.h"
#define Size 13 //文字大小
@interface LHButtonsTableViewCell ()
{
    UIImageView *_leftImage;
    UILabel *_leftLabel;
    
    UIImageView *_middleImage;
    UILabel *_middleLabel;
    
    UIImageView *_rightRightImage;
    UILabel *_rightRightLabel;
    
    UIImageView *_rightImage;
    UILabel *_rightLabel;
}

@end

@implementation LHButtonsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self addSUbViews];// 添加子视图
    
    return self;
}
-(void)addSUbViews
{
    CGFloat margin = 10;//间距
    
    //划分为三个等宽的方格
    UIButton *grid1 = [UIButton new];
    grid1.tag = LHButtonTagLeft;
    UIButton *grid2 = [UIButton new];
    grid2.tag =LHButtonTagMiddle;
    UIButton *grid3 = [UIButton new];
    grid3.tag = LHButtonTagRight;
    
    UIButton *grid4 = [UIButton new];
    grid4.tag = LHButtonTagRightRight;
    
    [self addSubview:grid1];
    [self addSubview:grid2];
    [self addSubview:grid3];
    [self addSubview:grid4];
    
    [grid1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
    }];
    [grid2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid1.mas_right);
        make.top.bottom.width.mas_equalTo(grid1);
    }];
    [grid3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid2.mas_right);
        make.top.bottom.width.mas_equalTo(grid2);
    }];
    [grid4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid3.mas_right);
        make.top.bottom.width.mas_equalTo(grid3);
        make.right.equalTo(self.mas_right);
    }];
    _leftImage = [UIImageView new];
    _leftImage.image = [UIImage imageNamed:@"icon_my_wallet"];
    [grid1 addSubview:_leftImage];
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid1);
        make.top.equalTo(grid1.mas_top).mas_offset(GLOBLE_MARGIN);
        make.width.mas_equalTo(_leftImage.mas_height);
        make.height.mas_equalTo(grid1.mas_height).multipliedBy(0.5);
        //make.height.mas_equalTo(grid1.mas_height).multipliedBy(0.6);
    }];
    
    _leftLabel = [UILabel new];
    [grid1 addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid1);
        make.top.equalTo(_leftImage.mas_bottom).mas_offset(margin);
    }];
    
    _middleImage = [UIImageView new];
    _middleImage.image = [UIImage imageNamed:@"icon_my_car"];
    [grid2 addSubview:_middleImage];
    [_middleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid2);
        make.top.equalTo(grid2.mas_top).mas_offset(GLOBLE_MARGIN);
        make.width.mas_equalTo(_middleImage.mas_height);
        make.height.mas_equalTo(grid2.mas_height).multipliedBy(0.5);
    }];
    
    _middleLabel = [UILabel new];
    [grid2 addSubview:_middleLabel];
    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid2);
         make.top.equalTo(_middleImage.mas_bottom).mas_offset(margin);
    }];
    
    _rightImage = [UIImageView new];
    _rightImage.image = [UIImage imageNamed:@"icon_my_review"];
    [grid3 addSubview:_rightImage];
    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid3);
        make.top.equalTo(grid3.mas_top).mas_offset(GLOBLE_MARGIN);
        make.width.mas_equalTo(_middleImage.mas_height);
        make.height.mas_equalTo(grid3.mas_height).multipliedBy(0.5);
    }];
    
    _rightLabel = [UILabel new];
    _rightLabel.text = @"";
    [grid3 addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid3);
         make.top.equalTo(_rightImage.mas_bottom).mas_offset(margin);
    }];
    
    
    _rightRightImage = [UIImageView new];
    _rightRightImage.image = [UIImage imageNamed:@"icon_my_review"];
    [grid4 addSubview:_rightRightImage];
    [_rightRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid4);
        make.top.equalTo(grid4.mas_top).mas_offset(GLOBLE_MARGIN);
        make.width.mas_equalTo(_middleImage.mas_height);
        make.height.mas_equalTo(grid4.mas_height).multipliedBy(0.5);
    }];
    
    _rightRightLabel = [UILabel new];
    _rightRightLabel.text = @"";
    [grid4 addSubview:_rightRightLabel];
    [_rightRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid4);
        make.top.equalTo(_rightRightImage.mas_bottom).mas_offset(margin);
    }];
    
    [grid1 addTarget:self action:@selector(clickGrid:) forControlEvents:UIControlEventTouchUpInside];
    [grid2 addTarget:self action:@selector(clickGrid:) forControlEvents:UIControlEventTouchUpInside];
    [grid3 addTarget:self action:@selector(clickGrid:) forControlEvents:UIControlEventTouchUpInside];
    [grid4 addTarget:self action:@selector(clickGrid:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickGrid:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(buttonClickAtIndex:cell:)]) {
       [self.delegate buttonClickAtIndex:sender.tag cell:self];
    }

}
+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath widthRadio:(CGFloat)radio
{
    return 90.0 ;
}
#pragma Mark ---------属性声明
- (void)setItem:(BaseItem *)item
{
   
    if ([item isKindOfClass:[LHButtonsItem class]]) {
        LHButtonsItem * model = (LHButtonsItem*)item;
        _leftLabel.text = model.leftTitle?:@"";
        _leftLabel.font = FONTSIZE(Size);
        _leftImage.image = ImageNamed(model.leftImage ?:@"");
        _middleLabel.text = model.middleTitle?:@"";
        _middleLabel.font = FONTSIZE(Size);
        _middleImage.image = ImageNamed(model.middleImage ?:@"");
        _rightLabel.text = model.rightTitle?:@"";
        _rightLabel.font = FONTSIZE(Size);
        _rightImage.image = ImageNamed(model.rightImage ?:@"");

        _rightRightLabel.text = model.rightRightTitle?:@"";
        _rightRightLabel.font = FONTSIZE(Size);
        _rightRightImage.image = ImageNamed(model.rightRightImage ?:@"");
    }
     [super setItem:item];
}


@end
