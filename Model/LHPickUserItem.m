//
//  LHPickUserItem.m
//  LHOASystem
//
//  Created by migenwei on 2018/7/16.
//  Copyright © 2018年 15fen. All rights reserved.
//

#import "LHPickUserItem.h"

@implementation LHPickUserItem
+ (LHPickUserItem*)createPickItem:(NSString*)title value:(NSString*)value type:(OrganizationSelectType)type key:(NSString*)key valueKey:(NSString*)valueKey{
    LHPickUserItem * item = [[LHPickUserItem alloc]initWithTitle:title Value:value];
    item.selectType = type;
    item.showLine = YES;
    item.valuekey = valueKey;
    item.key =key;
    item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return item;
}
@end
