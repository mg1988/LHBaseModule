//
//  LHDatePickItem.h
//  LHOASystem
//
//  Created by migenwei on 2017/7/26.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LableItem.h"

@interface LHDatePickItem : LableItem
@property(nonatomic,strong)NSString *dateStr;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *dateFomatter;// 格式化字符串
+ (LHDatePickItem*)createItemWithTitle:(NSString*)title fomatter:(NSString*)fomatter key:(NSString*)key;
@end
