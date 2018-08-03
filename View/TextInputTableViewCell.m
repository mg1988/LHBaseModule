//
//  TextInputTableViewCell.m
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/15.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "TextInputTableViewCell.h"
#import "InputItem.h"
#import "IQKeyboardManager.h"

#define INPUTCELLHEIGHT 160
#define TextViewPlaceHorder @"输入邮件内容"

@interface TextInputTableViewCell ()<UITextViewDelegate>

@property (nonatomic, strong) UIImageView * titleIcon;//输入域标题图标
@property (nonatomic, strong) UILabel * titleLabel; // 输入域标题
@property (nonatomic, strong) UILabel * palceHordLable;// textView的placeHorler
@property (nonatomic, strong) UIView * line;
@property(nonatomic,assign) TextInputType inputType;// 输入框类型
@property(nonatomic,assign) CGFloat   keyBoardHeight;//键盘高度
@end
@implementation TextInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellHeight = INPUTCELLHEIGHT;
        [self addsubViews];
         //   [self addNoti];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.inputText.scrollEnabled = NO;
    }
    return self;
}
// 添加子视图
- (void)addsubViews
{
    [self addSubview:self.inputText];
    [self addSubview:self.titleIcon];
    [self addSubview:self.titleLabel];

    self.line = [[UIView alloc]init];
    self.line.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:self.line];
    [self.inputText addSubview:self.palceHordLable];
 
    MJWeakSelf
    [self.inputText.rac_textSignal subscribeNext:^(id x) {
        // 监控
     
       NSString * text = x;
       ((InputItem*)weakSelf.item).text = text;// 文本框每次改变 都要将值与模型关联起来
        if (!weakSelf.inputText.mj_w) {
            return ;// 页面布局还未显示的时候 则不进行后面操作
        }
        CGSize size = [weakSelf.inputText sizeThatFits:CGSizeMake(weakSelf.inputText.mj_w, MAXFLOAT)];
        if (self.inputType == TextInputHorizontal) {
            if (size.height + weakSelf.inputText.mj_y  <= 50) {
                return;
            }
            weakSelf.item.cellHeight = size.height + weakSelf.inputText.mj_y+GLOBLE_MARGIN;
            UITableView *tableView = [weakSelf tableView];
            if (tableView) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillShowNotification object:nil];
//                });
                [tableView beginUpdates];
                [tableView endUpdates];

            }
        }else
        {
            if (90 >= size.height + weakSelf.inputText.mj_y+GLOBLE_MARGIN) {
                return;//
            }
            weakSelf.item.cellHeight = size.height + weakSelf.inputText.mj_y+GLOBLE_MARGIN;
            UITableView *tableView = [weakSelf tableView];
            if (tableView) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter]postNotificationName:UIKeyboardWillShowNotification object:nil];
//                });
                [tableView beginUpdates];
                [tableView endUpdates];
                
            }

        }
          }];
    
}
- (void)layoutSubviews
{ // 视图布局
    CGFloat padding = 10;// 视图之间的间距
    CGFloat margin = isPad ?GLOBLE_MARGIN*3:GLOBLE_MARGIN;// 距离父视图的距离
    CGFloat labelHeight = 15;
    CGFloat labelWidth = 120;
    if (self.titleIcon.image) {
        self.titleIcon.frame = CGRectMake(margin, padding, labelHeight, labelHeight);
    }else
    {
        self.titleIcon.frame = CGRectMake(margin, padding, 0, labelHeight);
    }
    if (self.inputType == TextInputVertical) { // 竖向 即输入框在标题底部
        if (self.titleLabel.text.length == 0) {
             self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleIcon.frame), self.titleIcon.mj_y, self.mj_w -CGRectGetMaxX(self.titleIcon.frame)+padding - margin , 0);
        }else
        {
             self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleIcon.frame), self.titleIcon.mj_y, self.mj_w -CGRectGetMaxX(self.titleIcon.frame)+padding - margin , labelHeight);
        }
       
        
       
        self.inputText.frame = CGRectMake(margin,CGRectGetMaxY(self.titleLabel.frame),self.mj_w -2*margin, self.mj_h -CGRectGetMaxY(self.titleLabel.frame));
        self.palceHordLable.frame = CGRectMake(padding, padding, self.inputText.mj_w - padding*2, labelHeight);
      
    }else if(self.inputType == TextInputHorizontal)
    {
        //横向 ，即输入框在标题右边
        labelWidth = 100;
        CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, labelHeight)];
        if (size.width > labelWidth) {
             CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)];
            self.titleLabel.frame = CGRectMake(self.titleIcon.image?CGRectGetMaxX(self.titleIcon.frame)+padding:CGRectGetMaxX(self.titleIcon.frame), self.titleIcon.mj_y, labelWidth, size.height);
        }else
        { // 只有一行的时候
             self.titleLabel.frame = CGRectMake(self.titleIcon.image?CGRectGetMaxX(self.titleIcon.frame)+padding:CGRectGetMaxX(self.titleIcon.frame),0, labelWidth, self.mj_h);
        }
        CGSize inputSize = [self.inputText sizeThatFits:CGSizeMake(self.mj_w -CGRectGetMaxX(self.titleLabel.frame)-padding -margin, MAXFLOAT)];
        self.inputText.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), self.mj_h/2.0 -inputSize.height/2.0, self.mj_w -CGRectGetMaxX(self.titleLabel.frame)-padding -margin, inputSize.height);
       self.palceHordLable.frame = CGRectMake(padding,0, self.inputText.mj_w - padding*2, self.inputText.mj_h);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    self.line.frame = CGRectMake(0, self.mj_h -1, self.mj_w, 1);
    self.item.cellHeight = self.mj_h;
}

#pragma mark --------UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.palceHordLable setHidden:YES];

}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
  
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        [self.palceHordLable setHidden:NO];
    }
}

- (void)addNoti
{
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardShow:(NSNotification*)noti
{
    UIView * first = [self getFirstResponder];
    if (first != self.inputText) {
        return;
    }
    if (self.keyBoardHeight == 0) {
        self.keyBoardHeight =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height ?:self.keyBoardHeight;
    }
    UITableView * tablew = [self tableView];
    if (tablew) {
        CGFloat y = tablew.mj_h - self.mj_h-self.mj_y ;
        if (y < self.keyBoardHeight) {
            
            CGRect rect = tablew.frame;
            rect.origin.y =(y-self.keyBoardHeight-40);
            if (y < 0) {
                rect.origin.y =-self.keyBoardHeight-40;

            }
            tablew.frame = rect;
        }
        
    }

}
- (void)keyBoardHidden:(NSNotification*)noti
{
    UIView * first = [self getFirstResponder];
    if (first != self.inputText) {
        return;
    }
    UITableView * tablew = [self tableView];
    if (tablew) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = tablew.frame;
            rect.origin.y = 0;
            tablew.frame = rect;
        }];
    }

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
#pragma mark -------属性声明

- (void)setItem:(BaseItem *)item
{
     [super setItem:item];
    if ([item isKindOfClass:[InputItem class]]) {
        InputItem * model = (InputItem*)item;
        if (model.titleAttribute) {
            self.titleLabel.attributedText = model.titleAttribute;
        }else
        {
            self.titleLabel.text = model.title?:@"";
        }
        if (model.textFont) {
            self.textLabel.font = model.textFont;
        }
        if (model.placeHorderTextFont) {
            self.palceHordLable.font = model.placeHorderTextFont;
        }
        self.inputType = model.inputType;
        [self.line setHidden:!model.showLine];
        self.titleIcon.image = model.titleIcon.length >0?ImageNamed(model.titleIcon):nil;
        self.inputText.editable = model.canEdit;
        self.inputType = model.inputType;
        self.palceHordLable.text = model.placeHorderText?:@"";
        [self.line setHidden:!model.showLine];
        if (model.textAttribute) {
            self.inputText.attributedText = model.textAttribute;
        }else if (model.text) {
              self.inputText.text = model.text ?:@"";
        }else
        {
            self.inputText.text = @"";
        }
      
        
       
        
    }
   
}
+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath widthRadio:(CGFloat)radio
{
    return INPUTCELLHEIGHT;
}
- (UITextView *)inputText
{
    if (!_inputText) {
        _inputText = [[UITextView alloc]init];
        _inputText.delegate  = self;
        _inputText.font = FONTSIZE(13);
        _inputText.textColor = GRAYCOLOR;
        
    }
    return _inputText;
}
- (UIImageView *)titleIcon
{
    if (!_titleIcon) {
        _titleIcon = [[UIImageView alloc]init];
    }
    return _titleIcon;
}
-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = FONTSIZE(13);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}
- (UILabel *)palceHordLable
{
    if (!_palceHordLable) {
        _palceHordLable = [[UILabel alloc]init];
        _palceHordLable.font = DEFAULTFONTSIZE;
        _palceHordLable.textColor = GRAYCOLOR;
    }
    return _palceHordLable;
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
@end
