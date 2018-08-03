//
//  LHTextTableCell.m
//  LHOASystem
//
//  Created by 刘航宇 on 2017/3/13.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHTextTableCell.h"
#import "LHTextItem.h"

#define CELL_HEIGHT 50
@interface LHTextTableCell()
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView * sepraterLine;
@end
@implementation LHTextTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentLabel = [[UILabel alloc]init];
        self.sepraterLine = [[UIView alloc]init];
        self.sepraterLine.backgroundColor = BACKGROUND_COLOR;
        [self addSubview:self.sepraterLine];
        [self addSubview:self.contentLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = isPad?GLOBLE_MARGIN* 3:GLOBLE_MARGIN;
    self.contentLabel.frame = CGRectMake(margin, 0, self.mj_w - margin*2, self.mj_h);
    if ([self.item isKindOfClass:[LHTextItem class]]) {
        CGRect rect =[self.contentLabel.attributedText boundingRectWithSize:CGSizeMake( self.contentLabel.mj_w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];;
        self.item.cellHeight = rect.size.height+10;
    }
    self.sepraterLine.frame = CGRectMake(0, self.mj_h - 0.5, self.mj_w, 0.5);
    if (self.item.cellHeight > CELL_HEIGHT) {
        if ([self tableView]) {
            UITableView * tableView = [self tableView];
            [tableView beginUpdates];
            [tableView endUpdates];
        }
    }

    
}


+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath*)indexPath widthRadio:(CGFloat)radio
{
    return CELL_HEIGHT;
}
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHTextItem class]])
    {
        LHTextItem * model = (LHTextItem*)item;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        NSMutableAttributedString *str = [NSMutableAttributedString new];
        if (model.firstAttributeString)
        {
            [str appendAttributedString:model.firstAttributeString];
        }
        
        if (model.secondAttributeString)
        {
            [str appendAttributedString:model.secondAttributeString];
        }
        self.contentLabel.attributedText = str;
        if (model.text) {
            self.contentLabel.text = model.text;
            self.contentLabel.textAlignment = model.alignment;
            
        }
        self.contentLabel.font = FONTSIZE(13);
        [self.sepraterLine setHidden:!model.showLine];
        
    }
    [super setItem:item];

}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
