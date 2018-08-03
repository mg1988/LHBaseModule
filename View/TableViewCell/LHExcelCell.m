//
//  LHExcelCell.m
//  LHOrder
//
//  Created by migenwei on 2017/9/21.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHExcelCell.h"
#import "LHExcelView.h"
#import "LHExcelTableViewItem.h"
@interface LHExcelCell ()<LHExcelViewDelegate,LHExcelViewDataSource>
@property(nonatomic,strong)LHExcelView *excelView;
@end
@implementation LHExcelCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self installViews];
       
    }
    return self;
}
- (void)installViews
{
    [self.excelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.excelView.backgroundColor = GRAYCOLOR;
}
- (NSInteger)numOfArrangeExcelView:(LHExcelView *)excelView
{
    if ([self.item isKindOfClass:[LHExcelTableViewItem class]]) {
        LHExcelTableViewItem * model = (LHExcelTableViewItem*)self.item;
        return model.unitDatas.count;
    }
    return 0  ; //
}
- (NSInteger)numOfRowExcelView:(LHExcelView *)excelView
{
    if ([self.item isKindOfClass:[LHExcelTableViewItem class]]) {
        LHExcelTableViewItem * model = (LHExcelTableViewItem*)self.item;
        if ([model.unitDatas.firstObject isKindOfClass:[NSArray class]]) {
            NSArray * data = model.unitDatas.firstObject;
            return data.count;
        }
        
    }
    return 0;// 行
}
- (CGFloat)rowHeight:(NSInteger)row excelView:(LHExcelView *)excelView
{
    if ([self.item isKindOfClass:[LHExcelTableViewItem class]]) {
        LHExcelTableViewItem * model = (LHExcelTableViewItem*)self.item;
        return model.rowHeight;
    }
    return 40;
}
- (CGFloat)arrangeWidth:(NSInteger)arrange excelView:(LHExcelView *)excelView
{
    if ([self.item isKindOfClass:[LHExcelTableViewItem class]]) {
        LHExcelTableViewItem * model = (LHExcelTableViewItem*)self.item;
        return model.arrangeWidth;
    }
    return 80;
}
- (LHExcelUnitItem*)excelUnitDataAtIndexPath:(NSIndexPath *)indexPath excelView:(LHExcelView *)excelView
{
    LHExcelUnitItem * item  = [LHExcelUnitItem new];
    if ([self.item isKindOfClass:[LHExcelTableViewItem class]]) {
        LHExcelTableViewItem * model = (LHExcelTableViewItem*)self.item;
         item = model.unitDatas[indexPath.section][indexPath.row];
 
    }
    return item;
}
#pragma mark-------属性声明
- (void)setItem:(BaseItem *)item
{
    [super setItem:item];
    if ([item isKindOfClass:[LHExcelTableViewItem class]]) {
         [self.excelView reloadData];
    }
   
    
}
- (LHExcelView *)excelView
{
    if (!_excelView) {
        _excelView = [[LHExcelView alloc]init];
        _excelView.dataSource = self;
        _excelView.delegate = self;
        [self addSubview:_excelView];
    }
    return _excelView;
}

@end
