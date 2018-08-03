//
//  LHSeparateCell.m
//  LHOASystem
//
//  Created by migenwei on 2018/7/2.
//  Copyright © 2018年 15fen. All rights reserved.
//

#import "LHSeparateCell.h"
#import "LHSeparateItem.h"
@interface LHSeparateCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView  *leftLine;
@property(nonatomic,strong)UIView *rightLine;
@end

@implementation LHSeparateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
        self.backgroundColor = CLEARCOLOR;
    }
    return self;
}
- (void)addViews{
    self.titleLabel = [[UILabel alloc]init];
    self.leftLine = [[UIView alloc]init];
    self.rightLine = [[UIView alloc]init];
    self.leftLine.backgroundColor = GRAYCOLOR;
    self.rightLine.backgroundColor = GRAYCOLOR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = DEFAULTFONTSIZE;
    self.titleLabel.textColor = GRAYCOLOR;
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftLine];
    [self addSubview:self.rightLine];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_greaterThanOrEqualTo(80);
    }];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(GLOBLE_MARGIN);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(self.titleLabel.mas_left).mas_offset(-GLOBLE_MARGIN);
    }];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-GLOBLE_MARGIN);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(GLOBLE_MARGIN);
    }];
}
- (void)setItem:(BaseItem *)item{
    if ([item isKindOfClass:[LHSeparateItem class]]) {
        LHSeparateItem * model = (LHSeparateItem*)item;
        self.titleLabel.text = model.title;
    }
    [super setItem:item];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
