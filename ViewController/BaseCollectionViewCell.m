//
//  BaseCollectionViewCell.m
//  LHShoppingCentre
//
//  Created by migenwei on 2017/9/8.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "LableItem.h"
#import <UIImageView+WebCache.h>
#import "LHWorker.h"
@interface  BaseCollectionViewCell()

@end
@implementation BaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addViews];
    }
    return self;
}
- (void)addViews
{
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)setItem:(BaseItem *)item
{
    _item = item;
    if ([item isKindOfClass:[LableItem class]]) {
        LableItem * model = (LableItem*)item;
        if (model.urlImage) {
             [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.urlImage?:@""] placeholderImage:ImageNamed(model.bgImage?:@"")];
        }else
        {
            self.bgImage.image = ImageNamed(model.bgImage);
        }
    }
}
- (UIImageView *)bgImage
{
    if (!_bgImage ) {
        _bgImage = [[UIImageView alloc]init];
    }
    return _bgImage;
}
@end
