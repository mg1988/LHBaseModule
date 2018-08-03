//
//  BaseTableViewCell.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/15.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableViewCell;
@protocol BaseTableViewCellDelegate <NSObject>
// 更新cell的数据
@optional
- (void)updateCell:(BaseTableViewCell*)cell;


/**
 cell上的button按钮触发

 @param index 按钮的标签（可以传button的tag）
 */
-(void)buttonClickAtIndex:(NSInteger)index cell:(BaseTableViewCell*)cell;
@end
@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong) BaseItem * item;
@property (nonatomic, assign) id<BaseTableViewCellDelegate> delegate;
@property (nonatomic, assign)  CGFloat cellHeight;//记录高度
@property (nonatomic, strong) UIImageView * bgImage;// 背景视图


/**
 返回cell的高度（不重写此方法返回一个默认高度）

 @param indexPath cell 的indexPath
 @param radio     宽高比例

 @return 返回cell的高度
 */
+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath*)indexPath widthRadio:(CGFloat)radio;
@end
