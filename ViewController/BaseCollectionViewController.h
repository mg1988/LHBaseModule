//
//  BaseCollectionViewController.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/25.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;//
@end
