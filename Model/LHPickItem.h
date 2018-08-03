//
//  LHPickItem.h
//  LHOASystem
//
//  Created by migenwei on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LableItem.h"

@interface LHPickItem : LableItem
@property(nonatomic,strong)NSArray *pickData;// 数据
@property(nonatomic,strong)NSString *keyPro;// 关键属性
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)id selectData;// 选中的数据
@property(nonatomic,assign)NSInteger selecIndex;// 选中的下标
+ (LHPickItem*)createItemWithTitle:(NSString*)title pickData:(NSArray*)pickData keyPro:(NSString*)keyPro key:(NSString*)key detailText:(NSString*)detailText;
@end
