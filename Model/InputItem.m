//
//  InputItem.m
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "InputItem.h"

@implementation InputItem
- (instancetype)initWithTitle:(NSString*)title titleIcon:(NSString*)titleIcon
{
    if (self = [super init]) {
        _title = title;
        _titleIcon = titleIcon;
         _canEdit = YES;
    
    }
    return self;
}

- (instancetype)initWithAttributedTitle:(NSAttributedString*)titleAttribute titleIcon:(NSString*)titleIcon
{
    if (self = [super init]) {
        _titleAttribute = titleAttribute;
        _titleIcon = titleIcon;
         _canEdit = YES;
    }
    return self;
}
- (instancetype)init
{
    if (self =[ super init]) {
       
        _canEdit = YES;
    }
    return self;
}
@end
