//
//  BaseItem.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseModel.h"

/**
 *  用于作为视图的数据源
 */
@interface BaseItem : BaseModel
@property (nonatomic, assign) CGFloat cellHeight;
@property(nonatomic,strong)NSString *key;
/**
 *  重用标识
 *
 *  @return 重用标识
 */
+(NSString*)identifier;



/**
 由于部分cell 视图 要根据item高度计算视图高度，所以设置一个这样的方法用户计算cell的高度

 @return 返回cell的高度
 */
- (CGFloat)cellHeight;
@end
