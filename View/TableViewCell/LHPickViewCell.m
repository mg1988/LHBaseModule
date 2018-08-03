//
//  LHPickViewCell.m
//  LHOASystem
//
//  Created by migenwei on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHPickViewCell.h"
#import "LHPickItem.h"
#import "LHPikerView.h"
#import "LHDatePickItem.h"
#import "LHDatePickerView.h"
@interface LHPickViewCell ()
@property(nonatomic,strong)UIButton *tapButton;
@end
@implementation LHPickViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = isPad?GLOBLE_MARGIN*3:GLOBLE_MARGIN;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.frame = CGRectMake(margin, 0, 80, self.mj_h);
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame)+margin, 0, self.mj_w - CGRectGetMaxX(self.textLabel.frame)-margin*2, self.mj_h);
}

- (void)addSubViews
{
    [self addSubview:self.tapButton];
    [self.tapButton addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)showPicker
{
    if ([self.item isKindOfClass:[LHPickItem class]]) {
      __weak  LHPickItem * model = (LHPickItem*)self.item;
        if (model.pickData.count == 0) {
            return;
        }
        MJWeakSelf
        
        LHPikerView *pickView = [[LHPikerView alloc]initWithTitle:model.title?:@"" data:model.pickData type:LHPikerViewTypeCenter];
        if(model.keyPro.length > 0)
        {
            pickView = [[LHPikerView alloc]initWithTitle:model.title?:@"" data:model.pickData style:LHPikerViewStyleNomal andProperty:model.keyPro];
        }
        pickView.selectCallBack = ^(NSInteger index, NSString *title) {
            weakSelf.detailTextLabel.text = title;
            model.detailText = title;
            model.selecIndex = index;
            model.selectData = model.pickData[index];
        };
        [pickView show];
    }else if ([self.item isKindOfClass:[LHDatePickItem class]])
    {
        MJWeakSelf
      LHDatePickerView * pick = [[LHDatePickerView alloc]initTimePickWithDate:[NSDate new] Response:^(NSString *dateStr) {
          LHDatePickItem * model = (LHDatePickItem*)weakSelf.item;
          if (model.dateFomatter) {
              NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
              [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
              NSDate * date = [formatter dateFromString:dateStr];
              [formatter setDateFormat:model.dateFomatter];
               dateStr = [formatter stringFromDate:date];
          }
          model.dateStr = dateStr;
          model.detailText = dateStr;
          weakSelf.detailTextLabel.text = dateStr;
      }];
        [pick show];
    }
 
}
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHPickItem class]]) {
       LHPickItem * model = (LHPickItem*)item;
        if (!model.selectData) {
            model.selectData = model.pickData.firstObject;
        }
    }
    [super setItem:item];
}

#pragma mark ---------属性声明
- (UIButton *)tapButton
{
    if (!_tapButton) {
        _tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _tapButton;
}

@end
