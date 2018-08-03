//
//  BaseViewModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel
- (instancetype)init
{
    if (self = [super init]) {
        _loading = NO;
    }
    return self;
}
@end
