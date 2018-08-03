//
//  LableItem.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/15.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseItem.h"


/**
 用于展示tableView 中  标签数据(适用于普通的cell)
 */
@interface LableItem : BaseItem

@property (nonatomic, strong) NSString * lableText; //textLabel 的内容
@property (nonatomic, strong) NSAttributedString * labelAttributedString; // 富文本的文字
@property (nonatomic, strong) UIColor * labelColor; // label的颜色
@property (nonatomic, strong) UIFont * labelTextFont;
@property (nonatomic, assign) NSTextAlignment labelTextAlignment;//label对齐方式


@property (nonatomic, strong) NSString * detailText;// 描述
@property (nonatomic, strong) UIFont * detailTexttFont;
@property (nonatomic, strong) NSAttributedString * detailAttributedString;
@property (nonatomic, strong) UIColor * detailColor;// 颜色(detailLabel)
@property (nonatomic, strong) NSString * leftImage;// 左侧图片名称
@property (nonatomic, strong) NSString * urlImage;// 图片的网络路径
@property(nonatomic,strong)NSString *placeHorlderImage;// 站位图
@property (nonatomic, strong) NSString * rightImage;// 右侧图片名称
@property (nonatomic, strong) NSString * rightImageHlight;// 右侧选中状态的图片
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;// 辅助视图样式

@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;//
@property (nonatomic, strong) NSString * bgImage;// 背景视图
@property (nonatomic, assign) BOOL  showLine; // 是否显示分割线  默认不显示分割线，这个是自定义的
@property(nonatomic,assign)BOOL selected;
@end
