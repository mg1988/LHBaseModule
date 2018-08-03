//
//  TabMyOrderItemCell.h
//  ETShop-for-iOS
//
//  Created by EleTeam(Tony Wong) on 15/06/03.
//  Copyright © 2015年 EleTeam. All rights reserved.
//
//  @email 908601756@qq.com
//
//  @license The MIT License (MIT)
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger ,LHButtonTag)
{
    LHButtonTagLeft = 888,// 左边按键tag
    LHButtonTagMiddle = 999,
    LHButtonTagRight = 1000, // 右边按钮
    LHButtonTagRightRight = 1001 // 最右边按钮
};
/**
 有三个按钮的cell
 */
@interface LHButtonsTableViewCell : BaseTableViewCell


@end
