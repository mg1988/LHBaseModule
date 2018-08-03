//
//  LHCheckBoxCell.m
//  LHOASystem
//
//  Created by Unidat on 2017/7/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHCheckBoxCell.h"
#import "LHCheckBoxItem.h"

#define nomal @"xuanze_nomal"
#define seleted @"xuanzhogn"

@interface LHCheckBoxCell ()
@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) NSMutableArray *checkArr;
@property (nonatomic, assign) BOOL isMultiselect;//是否多选
@end

@implementation LHCheckBoxCell {
    UIButton *currentBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.btnArr = [NSMutableArray array];
        self.checkArr = [NSMutableArray array];
        self.isMultiselect = NO;
    }
    return self;
}

- (void)setItem:(BaseItem *)item {
    
    if ([item isKindOfClass:[LHCheckBoxItem class]]) {
        
        LHCheckBoxItem *model = (LHCheckBoxItem *)item;
        
        self.isMultiselect = model.isMultiselect;
        
        if (self.btnArr.count == 0) {
            
            for (int i = 0; i < model.titleArr.count; i++) {
                
                UIButton *btn = [self setBtnWithTitle:model.titleArr[i]];
                
                btn.tag = i;
                
                [self.btnArr addObject:btn];
                
                [self.checkArr addObject:@(NO)];
                
            }
            
            [self layoutSubviews];
        }
        else {
            
            for (int i = 0; i < model.titleArr.count; i++) {
                
                UIButton *btn = [self viewWithTag:i];
                
                btn.selected = [self.checkArr[i] boolValue];
            
            }
            
        }
        
    }
    
}

- (void)layoutSubviews {
    
    if (self.btnArr.count == 0) {
        
        [super layoutSubviews];
        
        return;
    }
    
    CGFloat maxWidth = 0.0;
    
    int k = 0;int j = 0;
    
    for (int i = 0; i < self.btnArr.count; i++) {
        
        UIButton *btn = self.btnArr[i];
        
        CGSize detailSize = [self labelAutoCalculateRectWith:btn.titleLabel.text FontSize:12 MaxSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
        
        CGFloat width = detailSize.width + 35;
        
        maxWidth = maxWidth + width + 5;
        
        if (maxWidth > SCREEN_WIDTH || k > 0) {
            
            if (maxWidth > SCREEN_WIDTH) {
                
                j = 0;
                
                k++;
                
                maxWidth = width + 5;
                
                self.item.cellHeight = 40 * (k + 1) + 5 * k;
                
                UITableView *tableView = [self tableView];
                
                if (tableView) {
                    
                    [tableView beginUpdates];
                    [tableView endUpdates];
                    
                }
                
            }
            
            btn.frame = CGRectMake(width * j + 5 * (j + 1), 40 * k + 5 * k, width, 40);
            
            j++;
            
        }
        else {
            
            btn.frame = CGRectMake(width * i + 5 * (i + 1), 0, width, 40);
            
        }
        
        [self addSubview:btn];
        
    }
    
    [super layoutSubviews];
    
}

- (UIButton *)setBtnWithTitle:(NSString *)title {
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:ImageNamed(nomal) forState:UIControlStateNormal];
    [btn setImage:ImageNamed(seleted) forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BLACK forState:UIControlStateNormal];
    btn.titleLabel.font = FONTSIZE(12);
    
    [btn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn.mas_left).mas_offset(GLOBLE_MARGIN);
        make.right.mas_equalTo(btn.titleLabel.mas_left).mas_offset(-GLOBLE_MARGIN);
        make.centerY.mas_equalTo(btn);
        make.height.width.mas_equalTo(15);
    }];
    
    [btn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(btn.mas_right);
        make.top.bottom.mas_equalTo(btn);
    }];
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)clickBtn:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    [self.checkArr replaceObjectAtIndex:btn.tag withObject:@(btn.selected)];
    
    if (!self.isMultiselect) {
        
        if (currentBtn && currentBtn.tag != btn.tag) {
            
            currentBtn.selected = NO;
            
            [self.checkArr replaceObjectAtIndex:currentBtn.tag withObject:@(currentBtn.selected)];
            
        }
        
    }
    
    currentBtn = btn;
    
    if (self.selectCallBack) {
        
        NSMutableArray *m = [NSMutableArray array];
        
        for (int i = 0; i < self.checkArr.count; i++) {
            
            if ([self.checkArr[i] boolValue]) {
                
                UIButton *btn = self.btnArr[i];
                
                [m addObject:btn.titleLabel.text];
                
            }
            
        }
        
        self.selectCallBack([m copy]);
        
        LHCheckBoxItem *model = (LHCheckBoxItem *)self.item;
        
        model.backTitleArr = [m copy];
        
    }
    
}

- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);
    
    labelSize.width = ceil(labelSize.width);
    
    return labelSize;
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
