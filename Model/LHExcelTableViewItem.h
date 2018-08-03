//
//  LHExcelTableViewItem.h
//  LHOrder
//
//  Created by migenwei on 2017/9/21.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseModel.h"


@interface LHExcelTableViewItem : BaseItem
@property(nonatomic,strong)NSArray *unitDatas;// 单元格数据
@property(nonatomic,assign)CGFloat rowHeight;// 行高
@property(nonatomic,assign)CGFloat arrangeWidth ;// 列宽



/* 样例
 LHExcelTableViewItem * excel = [[LHExcelTableViewItem alloc]init];
 excel.rowHeight = 30;
 excel.arrangeWidth = 80;
 NSMutableArray * datas = [NSMutableArray array];
 for (int i = 0; i < 6; i++) {// 列数
 NSMutableArray * lie = [NSMutableArray array];
 for (int j = 0 ;j< 6 ;j++) {
 if (j == 0) {
 //加入表头
 NSString * str = @"";
 switch (i) {// 加入表头
 case 0:
 str = @"商品名称";
 break;
 case 1:
 str = @"商品规格";
 break;
 case 2:
 str = @"商品编号";
 break;
 case 3:
 str = @"订单数";
 break;
 case 4:
 str = @"单价";
 break;
 case 5:
 str = @"修改";
 break;
 
 default:
 break;
 }
 LHExcelUnitItem * item1 = [[LHExcelUnitItem alloc]initWithUnitdata:str textColor:RED];
 [lie addObject:item1];
 }else
 {
 LHExcelUnitItem * item1 = [[LHExcelUnitItem alloc]initWithUnitdata:[NSString stringWithFormat:@"%d+%d",i,j] textColor:BLACK];
 [lie addObject:item1];
 }
 if (j == 5) {
 [datas addObject:lie];
 }
 }
 }
 excel.unitDatas = datas;
 excel.cellHeight = (excel.rowHeight+1)*6;
 
 */
@end
