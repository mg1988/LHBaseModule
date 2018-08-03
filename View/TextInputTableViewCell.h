//
//  TextInputTableViewCell.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/15.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableViewCell.h"


/**
 这是一个带有输入域的cell textView
 */

typedef NS_ENUM(NSInteger,TextInputType)
{
    TextInputHorizontal = 1, // 输入框与标题平行；
    TextInputVertical = 0 // 输入框在标题底部
};
@interface TextInputTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UITextView * inputText;// 输入域

@end
