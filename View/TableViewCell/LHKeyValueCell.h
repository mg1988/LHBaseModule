//
//  LHKeyValueCell.h
//  LHFarm
//
//  Created by migenwei on 2017/8/3.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LHKeyValueCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *keyLabel;
@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UIButton *rightButton;

@end
