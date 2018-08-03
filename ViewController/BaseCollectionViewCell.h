//
//  BaseCollectionViewCell.h
//  LHShoppingCentre
//
//  Created by migenwei on 2017/9/8.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) BaseItem * item;
@property (nonatomic, assign)  CGFloat cellHeight;//记录高度
@property(nonatomic,strong)UIImageView *bgImage;
@end
