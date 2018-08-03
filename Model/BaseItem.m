//
//  BaseItem.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseItem.h"


#define CELL_View_Height 50
@implementation BaseItem

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}
+ (NSArray *)mj_ignoredPropertyNames
{
    return @[@"cellHeight"];
}
@end
