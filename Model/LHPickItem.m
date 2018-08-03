//
//  LHPickItem.m
//  LHOASystem
//
//  Created by migenwei on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHPickItem.h"

@implementation LHPickItem
+ (LHPickItem*)createItemWithTitle:(NSString*)title pickData:(NSArray*)pickData keyPro:(NSString*)keyPro key:(NSString*)key detailText:(NSString*)detailText{
    LHPickItem * item = [[LHPickItem alloc]init];
    item.lableText = title;
    item.pickData = pickData;
    item.key = key;
    item.keyPro =keyPro;
    item.selecIndex = 0;
    item.selectData = item.pickData.firstObject;
    item.detailText = detailText;
    item.showLine = YES;
    item.title = LHSTRING(@"请选择");
    item.labelTextFont = DEFAULTFONTSIZE;
    item.detailTexttFont = DEFAULTFONTSIZE;
    item.detailColor = GRAYCOLOR;
    item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return item;
}
@end
