//
//  BaseModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
//归档
MJCodingImplementation

//copy 方法
- (id)copyWithZone:(NSZone *)zone

{
    
    id ret = [[[self class] allocWithZone:zone] init];
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList( [self class], &propertyCount );
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char * name = property_getName(properties[i]);
        NSString * propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSObject<NSCopying> * tempValue = [self valueForKey:propertyName];
        if (tempValue) {
            
            id value = [tempValue copy];
            
            [ret setValue:value forKey:propertyName];
            
        }
        
    }
    return ret;
    
}

#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
        //        NSLog(@"name:%s",property_getName(property));
        //        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}
@end
