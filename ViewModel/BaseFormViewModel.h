//
//  BaseFormViewModel.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseItem.h"

@protocol BaseFormViewModelDelegate <NSObject>
@optional
- (void)reloadTableViewData;
- (void)selectItem:(BaseItem*)item completeBlcok:(void(^)(id))completeBlock;
@end

/**
 *  适用于TableView ,CollectionView
 */
@interface BaseFormViewModel : BaseModel

@property (nonatomic, assign) BOOL isLoad;// 是否正在加载中...
/**
 *  formItems 格式 可以是数组中嵌套数组 也可以
 */
@property (nonatomic, strong)  NSArray* formItems;

/**
 *  请求完数据后调用代理刷新数据
 */
@property (nonatomic, assign) id<BaseFormViewModelDelegate> delegate;

@property (nonatomic, strong) NSMutableArray * uploadFiles;//上传附件的模块数组

/**
 *  分区数
 *
 *  @return 分区
 */
- (NSInteger)numberOfSection;

/**
 *  每个分区的行数
 *
 *  @param section 分区号
 *
 *  @return 行数
 */
- (NSInteger)numOfRowsInSection:(NSInteger)section;

/**
 *  获取对应的数据源
 *
 *  @param row     行号
 *  @param section 分区号
 *
 *  @return 数据源
 */
- (BaseItem*)dataSourceAtRow:(NSInteger)row Section:(NSInteger)section;


// 计算cell的高度
- (CGFloat)countCellHeight:(NSIndexPath*)indexPath;



/**
 tableView 选中某个indexPath 进行跳转的逻辑
 
 @param indexPath     选中的indexPath
 @param completeBlock  选中完成后跳转
 */
- (void)didSelectIndex:(NSIndexPath*)indexPath completeBlcok:(void(^)(id))completeBlock;

@end
