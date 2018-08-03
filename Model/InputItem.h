//
//  InputItem.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseItem.h"
#import "TextInputTableViewCell.h"
// 带有输入域的item
@interface InputItem : BaseItem
@property (nonatomic, strong) NSString * title; // 标题
@property (nonatomic, strong) NSAttributedString * titleAttribute;// 设置富文本标题
@property (nonatomic, strong) NSString * titleIcon;// 标题图标
@property (nonatomic, strong) NSString * text;// 文字
@property(nonatomic,strong)   NSAttributedString * textAttribute;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) NSString * placeHorderText;// 占位字符
@property (nonatomic, strong) UIFont *placeHorderTextFont;
@property (nonatomic, assign) BOOL canEdit;// 能否编辑(默认是可编辑的)
@property (nonatomic, assign) BOOL  showLine;
@property(nonatomic,strong)NSString *otherText;
@property(nonatomic,assign) TextInputType inputType;
// 初始化方法
- (instancetype)initWithTitle:(NSString*)title titleIcon:(NSString*)titleIcon;
- (instancetype)initWithAttributedTitle:(NSAttributedString*)titleAttribute titleIcon:(NSString*)titleIcon;
@end
