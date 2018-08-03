//
//  InputTableViewCell.m
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "InputTableViewCell.h"
#import "LHInputItem.h"// 这个在我的页面 ，用户信息里创建的
#import "CheckDataTool.h"
@interface InputTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * inputTextField;// 输入框
@property (nonatomic, strong) UILabel * leftLabel;// 左边标签
@property (nonatomic, strong) UIView * line;// 分割线
@property (nonatomic, strong) NSString * rex;
@property (nonatomic, assign) NSInteger keyBoardHeight;
@end
@implementation InputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         // 添加视图
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    [self addSubview:self.inputTextField];
    [self addSubview:self.leftLabel];
    [self addSubview:self.line];
    self.inputTextField.font = FONTSIZE(13);
    MJWeakSelf
    [[self.inputTextField rac_textSignal]subscribeNext:^(id x) {
         ((LHInputItem*)weakSelf.item).text = x;
        if ([weakSelf.item isKindOfClass:[LHInputItem class]]) {
            CGSize size = [weakSelf.inputTextField sizeThatFits:CGSizeMake(weakSelf.inputTextField.mj_w, MAXFLOAT)];
            if (size.height  >=  weakSelf.inputTextField.mj_h) {
                weakSelf.item.cellHeight = size.height + weakSelf.inputTextField.mj_y;
                if ([weakSelf.delegate respondsToSelector:@selector(updateCell:)]) {
                    [weakSelf.delegate updateCell:weakSelf];
                }
            }
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([textField.placeholder isEqualToString:@"%"]) {
        if (textField.text.length <2) {
            return YES;
        }else if (textField.text.integerValue ==10)
        {
            if ([string isEqualToString:@"0"]) {
                return YES;
            }else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }else {
        return YES;
    }
    
    
}
// 页面布局
- (void)layoutSubviews
{
    [super layoutSubviews];
   // 从左到右布局
    CGFloat margin = 10;
    CGFloat width = [self.leftLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.mj_h)].width;// 计算lable占用的宽度
    width = 80;
    // 左边lable
    self.leftLabel.frame = CGRectMake(isPad?GLOBLE_MARGIN*3:GLOBLE_MARGIN,0,width, self.mj_h);
    // 输入域
    self.inputTextField.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame)+margin, self.mj_h*0.1, self.mj_w-CGRectGetMaxX(self.leftLabel.frame) - (isPad?GLOBLE_MARGIN*3:GLOBLE_MARGIN)*2 - 4 * margin , self.mj_h*0.8);
    self.line.frame = CGRectMake(0, self.mj_h-1, self.mj_w, 1);
    self.item.cellHeight = self.mj_h;
}
- (UIView*)getFirstResponder
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}

- (void)removeNoti
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
#pragma mark ---------属性声明
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHInputItem class]]) {
        LHInputItem * model = (LHInputItem*)item;
        if (model.leftAttibuteTitle) {
            self.leftLabel.attributedText = model.leftAttibuteTitle;
        }else
        {
            self.leftLabel.text = model.leftTitle?:@"";
        }
        [self.line setHidden:!model.showLine];// 是否显示分割线
        self.inputTextField.placeholder = model.palceHolder?:@"";// 占位字符
        self.inputTextField.text = model.text?:@"";
        self.inputTextField.enabled = model.canEdit; // 能否编辑
        self.inputTextField.keyboardType = model.keyboardType;// 键盘类型
        self.inputTextField.borderStyle = UITextBorderStyleNone;
        self.inputTextField.textAlignment = model.textAlignment;
        if (model.becomeFirstResponser) {
             [self.inputTextField becomeFirstResponder];
        }else
        {
             [self.inputTextField resignFirstResponder];
        }
        self.accessoryType = model.accesssoryType;
        self.rex = model.regEx;// 正则表达式
    }
    [super setItem:item];
}
- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]init];
        _inputTextField.delegate = self;
        _inputTextField.font = FONTSIZE(13);
        _inputTextField.textColor = GRAYCOLOR;
        _inputTextField.borderStyle = UITextBorderStyleNone;// 无边框
        
    }
        return _inputTextField;
}
- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = BLACK;
        _leftLabel.font = FONTSIZE(13);
        _leftLabel.numberOfLines = 0;
        _leftLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _leftLabel;
}
-(UIView*)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BACKGROUND_COLOR;
    }
    return _line;
}
@end
