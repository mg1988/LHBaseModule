//
//  LHCheckBoxCell.h
//  LHOASystem
//
//  Created by Unidat on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LHCheckBoxCell : BaseTableViewCell

@property (nonatomic, copy) void(^selectCallBack)(NSArray *titleArray);

@end
