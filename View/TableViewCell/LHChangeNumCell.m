//
//  LHChangeNumCell.m
//  LHOASystem
//
//  Created by migenwei on 2017/6/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHChangeNumCell.h"
#import "LHNumItem.h"

@interface LHChangeNumCell()
@property(nonatomic,strong)UIButton* addButton;// 加号按钮
@property(nonatomic,strong)UIButton * reduceButton; // 减号按钮
@property(nonatomic,strong)UITextField * inputText;

@end
@implementation LHChangeNumCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self stupeUI];
    }
    return self;
}
- (void)stupeUI
{
    [self addSubview:self.addButton];
    [self addSubview:self.reduceButton];
    [self addSubview:self.inputText];
    CGFloat margin = isPad ? GLOBLE_MARGIN*3:GLOBLE_MARGIN;
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo (self.mas_right).mas_offset(-margin);
         make.centerY.mas_equalTo(self.mas_centerY);
         make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
         make.width.mas_equalTo(self.mas_height);
    }];
    [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addButton.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        make.width.mas_equalTo(self.inputText.mas_height).multipliedBy(2);
    }];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (self.inputText.mas_left);
        make.top.bottom.width.mas_equalTo(self.addButton);

    }];
}

- (void)setItem:(BaseItem *)item
{
    if([item isKindOfClass:[LHNumItem class]])
    {
        LHNumItem * model = (LHNumItem*)item;
        self.inputText.text = model.text;
        self.inputText.placeholder = model.placeHorlder;
    
    }
    [super setItem:item];
}

- (void)clickAdd
{
    NSInteger num = self.inputText.text.integerValue;
    num++;
    self.inputText.text = @(num).stringValue;
     LHNumItem * model = (LHNumItem*)self.item;
    model.text = self.inputText.text;
    
}
- (void)clickReduce
{
    NSInteger num = self.inputText.text.integerValue;
    if (num == 0) {
        return;
    }
    num--;
    self.inputText.text = @(num).stringValue;
    LHNumItem * model = (LHNumItem*)self.item;
    model.text = self.inputText.text;
}
- (void)valueChanged:(UITextField*)textField
{
    LHNumItem * model = (LHNumItem*)self.item;
    model.text = self.inputText.text;
}
#pragma mark ----------属性声明

- (UIButton*)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:LHSTRING(@"＋") forState:UIControlStateNormal];
        [_addButton setTitleColor:BLACK forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton*)reduceButton
{
    if (!_reduceButton) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceButton setTitle:LHSTRING(@"－") forState:UIControlStateNormal];
        [_reduceButton setTitleColor:BLACK forState:UIControlStateNormal];
        [_reduceButton addTarget:self action:@selector(clickReduce) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceButton;
}


- (UITextField*)inputText
{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
       // _inputText.placeholder = @"数量";
        _inputText.borderStyle = UITextBorderStyleNone;
        _inputText.layer.borderWidth = 0.5;
        _inputText.keyboardType = UIKeyboardTypeNumberPad;
        _inputText.textAlignment = NSTextAlignmentCenter;
        _inputText.font = FONTSIZE(13);
        _inputText.layer.borderColor = GRAYCOLOR.CGColor;
        [_inputText addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _inputText;
}

@end
