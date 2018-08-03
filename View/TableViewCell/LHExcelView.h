//
//  LHExcelView.h
//  LHOrder
//
//  Created by migenwei on 2017/9/20.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"

@class LHExcelView;
@class LHExcelUnitItem;
@class LHExcelViewUnitCell;
@protocol LHExcelViewDelegate <NSObject>
@optional
- (void)excelView:(LHExcelView*)excelView didSelectAtIndexPath:(NSIndexPath*)index;

@end

@protocol LHExcelViewDataSource <NSObject>
@optional

/**
 每列中有多少行
 
 @param arrange 列号
 @return 行数
 */
- (NSInteger)numOfRowExcelView:(LHExcelView*)excelView;


/**
 列数
 
 @return 多少列
 */
- (NSInteger)numOfArrangeExcelView:(LHExcelView*)excelView;


/**
 某一行的行高
 
 @param row 行号
 @return 行高
 */
- (CGFloat)rowHeight:(NSInteger)row excelView:(LHExcelView*)excelView;// 行高


/**
 某一列的列宽
 
 @param arrange 列号
 @return 列宽
 */
-(CGFloat)arrangeWidth:(NSInteger)arrange excelView:(LHExcelView*)excelView;// 列宽



/**
 返回每个单元格的样式

 @param excelView 表格视图
 @param indexPath 表格单元号
 @return 单元格
 */
- (LHExcelViewUnitCell*)excelViewCell:(LHExcelView*)excelView indexPath:(NSIndexPath*)indexPath;



/**
 单元格数据模型

 @param indexPath 单元格编号
 @param excelView 表格视图
 @return 表格数据源
 */
-(LHExcelUnitItem*)excelUnitDataAtIndexPath:(NSIndexPath*)indexPath excelView:(LHExcelView*)excelView;


@end

// 单元格数据模型
@interface LHExcelUnitItem : BaseItem
@property(nonatomic,strong)NSString *bgImage;
@property(nonatomic,strong)NSString *unitData;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,assign)UIKeyboardType keyboardType;
@property(nonatomic,strong)UIColor *bgColor;
@property(nonatomic,assign)BOOL edit;// 是否编辑

- (instancetype)initWithUnitdata:(NSString*)unitdata textColor:(UIColor*)color;
@end

/*表格单元格*/
@interface LHExcelViewUnitCell : BaseCollectionViewCell

@end

/* 定义一个表格视图*/
@interface LHExcelView : UIView
@property(nonatomic,assign) id<LHExcelViewDataSource>dataSource;
@property(nonatomic,strong)id <LHExcelViewDelegate>delegate;
@property(nonatomic,assign) CGFloat height;// 建议的高度
- (BaseCollectionViewCell*)dequeueReusableCellWithReuseIdentifier:(NSString*)identifier forIndexPath:indexPath;
- (void) registerClass:(Class)class forCellWithReuseIdentifier:(NSString*)identifier;
- (void)reloadData;
@end
