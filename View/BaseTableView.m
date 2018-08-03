//
//  BaseTableView.m
//  LHOASystem
//
//  Created by migenwei on 2017/9/13.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UIImageView *bgImageView;
@end
@implementation BaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self addSubview:self.tipLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.tipLabel bringSubviewToFront:self];
    self.tipLabel.frame = CGRectMake(20, 100, SCREEN_WIDTH -40, 60);
    _bgImageView.frame = self.bounds;
    [self showTips];
    [self showBgImage];

}
-(void)reloadData
{
    [super reloadData];
    [self showTips];
}
- (void)showBgImage
{
    NSArray * cells =self.visibleCells;
    if (cells.count == 0) {
        [_bgImageView setHidden:NO];
        
    }else
    {
        [_bgImageView setHidden:YES];
    }

}
- (void)showTips
{
    NSArray * cells =self.visibleCells;
    if (cells.count == 0) {
        [self.tipLabel setHidden:NO];
        
    }else
    {
        [self.tipLabel setHidden:YES];
    }
}
-(void)setBgImage:(UIImage *)image
{
    self.bgImageView.image = image;
}
- (void)setTipText:(NSString *)tip
{
    _tipLabel.text = tip;
}
- (void)shakeAnimationWithTableView{
    
    NSArray *cells = self.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        if (i%2 == 0) {
            cell.transform = CGAffineTransformMakeTranslation(-SCREEN_WIDTH,0);
        }else {
            cell.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH,0);
        }
        [UIView animateWithDuration:0.5 delay:i*0.03 usingSpringWithDamping:0.75 initialSpringVelocity:1/0.75 options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel.hidden = YES;
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textColor = GRAYCOLOR;
        _tipLabel.font = FONTSIZE(13);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = LHSTRING(@"");
        _tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _tipLabel;
}
- (UIImageView*)bgImageView
{
    if (!_bgImageView) {
        _bgImageView  = [[UIImageView alloc]init];
        [self insertSubview:_bgImageView atIndex:0];
    }
    return _bgImageView;
}
@end
