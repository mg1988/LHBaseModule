//
//  BaseFormViewModel.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseFormViewModel.h"

@implementation BaseFormViewModel

#pragma mark ------数据源
- (NSInteger)numberOfSection
{
    if ([self isAllArray]) return self.formItems.count;
    return 1;
}
- (NSInteger)numOfRowsInSection:(NSInteger)section
{
     if ([self isAllArray]) return [ self.formItems[section] count];
     return self.formItems.count;
}
- (BaseItem*)dataSourceAtRow:(NSInteger)row Section:(NSInteger)section
{
    if ([self isAllArray])return self.formItems[section][row];
    return self.formItems[row];
}

- (void)didSelectIndex:(NSIndexPath *)indexPath completeBlcok:(void (^)(id))completeBlock
{
    BaseItem * item = [self dataSourceAtRow:indexPath.row Section:indexPath.section];
    if ([self.delegate respondsToSelector:@selector(selectItem:completeBlcok:)]) {
        [self.delegate selectItem:item completeBlcok:completeBlock];
    }
}
// 判断是否都是数组
- (BOOL)isAllArray
{
    __block BOOL isAllArray = YES;
    [self.formItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isKindOfClass:[NSArray class]]) {
            isAllArray = NO;
        }
           }];
    return isAllArray;
}
- (CGFloat)countCellHeight:(NSIndexPath*)indexPath
{
    return 0;
}
- (NSMutableArray *)uploadFiles
{
    if (!_uploadFiles) {
        _uploadFiles = [NSMutableArray array];
    }
    return _uploadFiles;
}
@end
