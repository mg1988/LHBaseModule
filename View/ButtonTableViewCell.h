//
//  ButtonTableViewCell.h
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseFormViewModel.h"

@interface ButtonTableViewCell : BaseTableViewCell
@property (nonatomic, strong) NSMutableArray * files;//需要上传的附件
@property (nonatomic, strong) BaseFormViewModel * model;
@property(nonatomic,assign)BOOL onlyImage;// 仅仅上传图片
@property (nonatomic, strong) NSString *fileType;// 文件夹名称
@property (nonatomic, copy) void(^ clickBlock)(NSArray *files, NSArray *fileData, NSString *filePathsStr);
@property(nonatomic,strong)void (^getFiles)(NSArray*files);
@end
