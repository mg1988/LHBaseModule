//
//  BaseModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  继承这个BaseModel 的类都能显示copy 和归档
 */
@interface BaseModel : NSObject<NSCopying>
#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys;

@end
