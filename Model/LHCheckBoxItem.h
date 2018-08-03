//
//  LHCheckBoxItem.h
//  LHOASystem
//
//  Created by Unidat on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseItem.h"

@interface LHCheckBoxItem : BaseItem

@property (nonatomic, assign) BOOL isMultiselect;//是否多选
@property (nonatomic, strong) NSArray *titleArr;//标题内容数组
@property (nonatomic, copy) NSArray *backTitleArr;
@property(nonatomic,strong)NSArray *valueArr;// 值数组
@end
