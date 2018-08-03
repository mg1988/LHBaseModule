//
//  BaseTableViewCell.m
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/15.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "LableItem.h"
#import "LHTextItem.h"
#import <UIImageView+WebCache.h>
#define CELL_HEIGHT 50
@interface BaseTableViewCell ()
@property(nonatomic,assign)UITableViewCellStyle style;
@property(nonatomic,strong)UIView* line;// 底部分割线
@end
@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContrants];//添加视图
        self.textLabel.textAlignment= NSTextAlignmentLeft;
        self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.font = DEFAULTFONTSIZE;
        self.detailTextLabel.font = DEFAULTFONTSIZE;
        self.style = style;
      //  self.backgroundColor = TABLECELLCOLOR;
       // [self addObservers];
        
    }
    return self;
}
- (void)addContrants
{
    [self addSubview:self.line];
    [self addSubview:self.bgImage];
    
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
- (void)addObservers
{
    MJWeakSelf
    [RACObserve(self, detailTextLabel)subscribeNext:^(id x) {
        NSString * text =  x;
        if (text.length > 0 ) {
           ((LableItem*) weakSelf.item).detailText = text;
  
        }
    }];
}
- (void)setItem:(BaseItem *)item
{
     _item = item;
    if ([item isKindOfClass:[LableItem class]]) {
        LableItem * model = (LableItem*)item;
        [self.line setHidden:!model.showLine];
        self.accessoryType = model.accessoryType;
        if (model.labelAttributedString) {
            self.textLabel.attributedText = model.labelAttributedString;
        }else
        {
             self.textLabel.text = model.lableText?:@"";
        }
        if (model.labelTextAlignment) {
            self.textLabel.textAlignment = model.labelTextAlignment;
        }else
        {
             self.textLabel.textAlignment = NSTextAlignmentLeft;
        }
        if (model.detailAttributedString) {
            self.detailTextLabel.attributedText = model.detailAttributedString;
        }else
        {
             self.detailTextLabel.text = model.detailText?:@"";
        }
        if (model.urlImage) {
            MJWeakSelf
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.urlImage] placeholderImage:model.placeHorlderImage?ImageNamed(model.placeHorlderImage):ImageNamed(@"empty")completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (image) {
                    CGSize size = ImageNamed(@"empty").size;
                    weakSelf.imageView.image = [BaseTableViewCell thumbnailWithImage:image size:size];
                }else{
                }
            }];
        }
        if (model.leftImage.length > 0) { // 设置图片
            self.imageView.image =ImageNamed(model.leftImage)?:nil;
        }
        if (model.rightImage.length > 0) { // 设置图片
            UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageNamed(model.rightImage)?:nil highlightedImage:ImageNamed(model.rightImageHlight)?:nil];
            self.accessoryView = imageView;
        }
        if (model.labelColor) {
              self.textLabel.textColor =model.labelColor;
        }
        if (model.detailColor) {
             self.detailTextLabel.textColor = model.detailColor;
        }
        if (model.bgImage.length > 0) {
            self.bgImage.image = ImageNamed(model.bgImage);
        }else
        {
            self.bgImage.image = nil;
        }
        self.selectionStyle = model.selectionStyle;
        if (model.labelTextFont) {
            self.textLabel.font = model.labelTextFont;
        }
        if (model.detailTexttFont) {
            self.detailTextLabel.font = model.detailTexttFont;
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat left = isPad?GLOBLE_MARGIN*3:GLOBLE_MARGIN;
    if (!self.imageView.image) {
        CGRect frame = self.textLabel.frame;
        frame.origin.x = left;
        self.textLabel.frame = frame;
        if (self.style == UITableViewCellStyleSubtitle) {
            CGRect frame = self.detailTextLabel.frame;
            frame.origin.x = left;
            self.detailTextLabel.frame = frame;
        }
    }
    if (!self.bgImage.image) {
        [self.bgImage setHidden:YES];
    }else
    {
        [self.bgImage setHidden:NO];
    }

}
+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath*)indexPath widthRadio:(CGFloat)radio
{
    return CELL_HEIGHT;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = BACKGROUND_COLOR;
        [_line setHidden:YES];// 默认隐藏
    }
    return _line;
}
- (UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
    }
    return _bgImage;
}
+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size

{
    UIImage *newimage;
    if (nil == originalImage) {
        originalImage = nil;
    }
    else{
        UIGraphicsBeginImageContext(size);
        [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}
@end
