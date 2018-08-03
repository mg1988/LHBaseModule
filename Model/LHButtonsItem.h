//
//  LHButtonsItem.h
//  BaseProject
//
//  Created by 糜根维 on 17/2/19.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHButtonsItem : BaseItem
@property(nonatomic,strong) NSString * leftImage;
@property(nonatomic,strong) NSString * leftTitle;
@property(nonatomic,strong) NSString * leftBackImage;
@property(nonatomic,strong) UIColor * leftTitleCorlor;

@property(nonatomic,strong) NSString * middleImage;
@property(nonatomic,strong) NSString * middleTitle;
@property(nonatomic,strong) NSString * middleBackImage;
@property(nonatomic,strong) UIColor * middleTitleCorlor;



@property(nonatomic,strong) NSString * rightImage;
@property(nonatomic,strong) NSString * rightTitle;
@property(nonatomic,strong) NSString * rightBackImage;
@property(nonatomic,strong) UIColor * rightTitleCorlor;
    
@property(nonatomic,strong) NSString * rightRightImage;
@property(nonatomic,strong) NSString * rightRightTitle;
@property(nonatomic,strong) NSString * rightRightBackImage;
@property(nonatomic,strong) UIColor  * rightRightTitleCorlor;
@end
