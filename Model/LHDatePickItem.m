//
//  LHDatePickItem.m
//  LHOASystem
//
//  Created by migenwei on 2017/7/26.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHDatePickItem.h"

@implementation LHDatePickItem
+ (LHDatePickItem*)createItemWithTitle:(NSString*)title fomatter:(NSString*)fomatter key:(NSString*)key{
    LHDatePickItem * buyDate = [[LHDatePickItem alloc]init];
    buyDate.lableText = title;
    buyDate.labelColor = BLACK;
    buyDate.showLine = YES;
    buyDate.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    buyDate.key = key;
    buyDate.dateFomatter = fomatter;
    return buyDate;
}
@end
