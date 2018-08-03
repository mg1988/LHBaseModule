//
//  LHPickUserItem.h
//  LHOASystem
//
//  Created by migenwei on 2018/7/16.
//  Copyright © 2018年 15fen. All rights reserved.
//

#import "BaseItem.h"
#import "LHKeyValueItem.h"
#import "LHOrganizationViewController.h"
@interface LHPickUserItem : LHKeyValueItem
@property(nonatomic,strong)NSString *selectTitle;// 选择标题
@property(nonatomic,strong)NSString *ids;// 选择的用户ID;
@property(nonatomic,strong)NSString *valuekey;
@property(nonatomic,assign)NSInteger maxCount;// 最多选择数据 默认不限制
@property(nonatomic,assign)OrganizationSelectType selectType;//组织架构的类型
+ (LHPickUserItem*)createPickItem:(NSString*)title value:(NSString*)value type:(OrganizationSelectType)type key:(NSString*)key valueKey:(NSString*)valueKey;
@end
