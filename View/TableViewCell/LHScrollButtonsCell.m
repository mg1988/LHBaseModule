//
//  LHScrollButtonsCell.m
//  LHOASystem
//
//  Created by migenwei on 2017/7/2.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHScrollButtonsCell.h"
#import "LHButtonsScrollView.h"
#import "LHScrollButtonItem.h"

@interface LHScrollButtonsCell()<LHButtonsScrollViewDelegate>
@property(nonatomic,strong)LHButtonsScrollView *buttonsView;
@property(nonatomic,strong)UIView *line;
@end
@implementation LHScrollButtonsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.buttonsView];
        [self addConstraint];
    }
    return self;
}
- (void)addConstraint
{
    [self.buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)setItem:(BaseItem *)item
{
  
    if ([item isKindOfClass:[LHScrollButtonItem class]]) {
        self.buttonsView.item = (LHScrollButtonItem*)item;
    }
    [super setItem:item];
}
#pragma mark ---------属性声明
- (void)buttonClickAtIndex:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(buttonClickAtIndex:cell:)]) {
        [self.delegate buttonClickAtIndex:sender.tag cell:self];
    }
}
- (LHButtonsScrollView *)buttonsView
{
    if (!_buttonsView) {
        _buttonsView = [[LHButtonsScrollView alloc]init];
        _buttonsView.buttonDelegate = self;
    }
    return _buttonsView;
}

@end
