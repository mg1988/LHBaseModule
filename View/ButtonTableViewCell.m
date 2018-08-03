//
//  ButtonTableViewCell.m
//  BaseProject
//
//  Created by 刘航宇 on 2017/2/16.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "ButtonTableViewCell.h"
#import "LHButtonItem.h"
#import <MessageUI/MessageUI.h>
#import "CorePhotoPickerVCManager.h"
#import "LHEmailTools.h"
#import "UploadParam.h"
#import "CheckDataTool.h"
#import "LHPikerView.h"
#import "LHAchmentModel.h"
#import "LHAchmentListViewController.h"
@interface ButtonTableViewCell () <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIView * line;
@end
@implementation ButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.line = [UIView new];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addContrants];
    }
    return self;
}


/**
 添加约束
 */
- (void)addContrants
{
    [self addSubview:self.button];
    [self addSubview:self.line];
    self.line.backgroundColor = BACKGROUND_COLOR;
    CGFloat margin = isPad ?GLOBLE_MARGIN*3:GLOBLE_MARGIN;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-margin);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.8);
        make.left.mas_equalTo(self.mas_left).mas_offset(margin);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
  
}

#pragma mark -------属性
-(void)setItem:(BaseItem *)item
{
    
    if ([item isKindOfClass:[LHButtonItem class]]) {
        LHButtonItem * model = (LHButtonItem*)item;
        if (model.title)[self.button setTitle:model.title?:@"" forState:UIControlStateNormal];
        if (model.bgColor)[self.button setBackgroundColor:model.bgColor];
        if (model.bgImage)[self.button setBackgroundImage:ImageNamed(model.bgImage) forState:UIControlStateNormal];
        if (model.selectedImage)[self.button setImage:ImageNamed(model.selectedImage) forState:UIControlStateSelected];
         if (model.selectedImage)[self.button setImage:ImageNamed(model.selectedImage) forState:UIControlStateHighlighted];
        if (model.radius) self.button.layer.cornerRadius = model.radius;
        if (model.titleColor)[self.button setTitleColor:model.titleColor forState:UIControlStateNormal];
        if (model.image)[self.button setImage:ImageNamed(model.image) forState:UIControlStateNormal];
        self.button.contentHorizontalAlignment = model.aligenment;
        self.button.selected = model.isSelected;
        [self.line setHidden:!model.showLine];
    }
    [super setItem:item];
}
- (void)buttonClick
{
    
    MJWeakSelf
    if (isPad) {
        [self uploadImage];
        return;
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:LHSTRING(@"选取文件") message:LHSTRING(@"选取您要上传的文件") preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * camare = [UIAlertAction actionWithTitle:LHSTRING(@"相机") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakSelf didDismissWithButtonIndex:0];
    }];
    UIAlertAction * photo = [UIAlertAction actionWithTitle:LHSTRING(@"照片多选") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakSelf didDismissWithButtonIndex:1];
    }];
    UIAlertAction * file = [UIAlertAction actionWithTitle:LHSTRING(@"本地文件") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf fileSelectAction:1];// 选择已经上传的附件
    }];
    UIAlertAction * yunfile = [UIAlertAction actionWithTitle:LHSTRING(@"云文件") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf fileSelectAction:2];// 选择已经上传的附件
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:LHSTRING(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
     [alert addAction:camare];
     [alert addAction:photo];
    if (self.onlyImage) {
        
    }else{
        if (self.fileType.length >0 && ![self.fileType isEqualToString:@"mailOutside"]) {
            [alert addAction:file];
            [alert addAction:yunfile];
        }
    }
  
     [alert addAction:cancel];
    
    UIViewController * vc = [self currentViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}


- (void)fileSelectAction:(NSInteger)type;
{
    LHAchmentListViewController * vc = [[LHAchmentListViewController alloc]init];
    vc.editType = type;
    MJWeakSelf
    if (type == 2) {// 云文件
        vc.comfirmCallBack = ^(NSArray<LHAchmentModel *> *files) {
            if (weakSelf.clickBlock) {
                NSString *str=@"";
                NSMutableArray *mArr = [NSMutableArray array];
                NSMutableArray * filesArray = [NSMutableArray array];
                [weakSelf.files removeAllObjects];
                [weakSelf.model.uploadFiles removeAllObjects];// 上传模型
                for (LHAchmentModel * model in files) {
                    [filesArray addObject:model];
                    str = [NSString stringWithFormat:@"%@%@,",str,model.file_id];
                    [weakSelf.files addObject:model.file_name?:@""];
                    [mArr addObject:model.file_id];
                }
                if (weakSelf.clickBlock) {
                    weakSelf.clickBlock(weakSelf.files, mArr, str);
                }
                if (weakSelf.getFiles) {
                    weakSelf.getFiles(filesArray);
                }
            }
        };
    }else if (type == 1)// 本地文件
    {// 上传文件
        vc.comfirmCallBack = ^(NSArray<LHAchmentModel *> *files) {
               [weakSelf.files removeAllObjects];
             [weakSelf.model.uploadFiles removeAllObjects];// 上传模型
            for (LHAchmentModel * model in files) {
                  UploadParam * upload = [UploadParam new];
                upload.name = @"file";
                upload.data =  [NSData dataWithContentsOfFile:model.file_path];
                upload.filename = model.file_name;
                upload.mimeType = @"application/octet-stream";
                  [weakSelf.files addObject:model.file_name?:@""];
                 [weakSelf.model.uploadFiles addObject:upload];// 上传模型
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                DDLogDebug(@"添加图片完毕");
                [HUDManager showLoading];
                [LHRequestManager uploadFile:weakSelf.model.uploadFiles parameters:@{@"token":[UserInfoModel shared].token,@"fileType":weakSelf.fileType} completion:^(NSMutableArray *successResultPath, NSMutableArray *failIndex) {

                    NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc]init];
                    for (NSNumber *num in failIndex) {
                        [indexSet addIndex:num.unsignedIntegerValue];
                    }
                    
                    [weakSelf.files removeObjectsAtIndexes:indexSet];// 移除掉
                    
                    NSString *str=@"";
                    NSMutableArray *mArr = [NSMutableArray array];
                    NSMutableArray * filesArray = [NSMutableArray array];
                    for (id dic in successResultPath) {
                        DDLogDebug(@"上传成功的数据：：：%@",dic);
                        if (![dic isKindOfClass:[NSNull class]]&&dic &&dic != NULL &&[dic valueForKey:@"result"]&&dic[@"result"][@"file_id"] ) {
                            LHAchmentModel * model = [LHAchmentModel mj_objectWithKeyValues:dic[@"result"]];
                            [filesArray addObject:model];
                            str = [NSString stringWithFormat:@"%@%@,",str,dic[@"result"][@"file_id"]];
                            
                            [mArr addObject:dic[@"result"][@"file_id"]];
                        }
                    }
                    
                    if (weakSelf.clickBlock) {
                        weakSelf.clickBlock(weakSelf.files, mArr, str);
                    }
                    if (weakSelf.getFiles) {
                        weakSelf.getFiles(filesArray);
                    }
                    
                    [HUDManager hideLoading];
                    
                }];
            });
            

        };
    }
   
    [[weakSelf currentViewController].navigationController pushViewController:vc animated:YES];
}
#pragma mark actionSheetDelegate
-(void)didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex!=2) {
        
        CorePhotoPickerVCMangerType type=0;
        if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeCamera;
        if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeMultiPhoto;
        CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
        
        //设置类型
        manager.pickerVCManagerType=type;
        
        //最多可选50张
        manager.maxSelectedPhotoNumber=5;
        
        //错误处理
        if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
            DDLogDebug(@"设备不可用");
            return;
        }
        
        UIViewController *pickerVC=manager.imagePickerController;
        
        
        __weak typeof(self) weakSelf=self;
        //选取结束
        manager.finishPickingMedia=^(NSArray *medias){
            DDLogDebug(@"%@",medias);
            [weakSelf.files removeAllObjects];
            NSMutableArray * filedatas = [NSMutableArray array];
            NSMutableArray * fileNames = [NSMutableArray array];
            [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
                DDLogDebug(@"%@",photo.editedImage);
                
                [weakSelf.files addObject:photo.editedImage];
                
                //                UIImage *newImage = [LHEmailTools imageWithImageSimple:photo.editedImage scaledToSize:CGSizeMake(120.0, 120.0)]; // 压缩图片
                NSString *newImageName=[NSString stringWithFormat:@"%@%@",[LHEmailTools getCurrentDateString],@".png"];//获得当前时间戳取名
                UploadParam * model = [UploadParam new];
                model.name = @"file";
                model.data =[CheckDataTool imageData:photo.editedImage];
                model.filename = newImageName;
                model.mimeType = @"image/png";
                [weakSelf.model.uploadFiles addObject:model];// 上传模型
                [filedatas addObject:model.data];
                [fileNames addObject:newImageName];
            }];
            if (weakSelf.fileType.length == 0) {
                if (weakSelf.clickBlock) {
                    weakSelf.clickBlock(weakSelf.files, filedatas, [fileNames componentsJoinedByString:@","]);
                }
                return ;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                DDLogDebug(@"添加图片完毕");
                [HUDManager showLoading];
                [LHRequestManager uploadFile:weakSelf.model.uploadFiles parameters:@{@"token":[UserInfoModel shared].token,@"fileType":weakSelf.fileType} completion:^(NSMutableArray *successResultPath, NSMutableArray *failIndex) {
                    
                    NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc]init];
                    for (NSNumber *num in failIndex) {
                        [indexSet addIndex:num.unsignedIntegerValue];
                    }
                    
                    [weakSelf.files removeObjectsAtIndexes:indexSet];// 移除掉
                    
                    NSString *str=@"";
                    NSMutableArray *mArr = [NSMutableArray array];
                    NSMutableArray * filesArray = [NSMutableArray array];
                    for (id dic in successResultPath) {
                        DDLogDebug(@"上传成功的数据：：：%@",dic);
                        if (![dic isKindOfClass:[NSNull class]]&&dic &&dic != NULL &&dic[@"result"]&&dic[@"result"][@"file_id"]) {
                            LHAchmentModel * model = [LHAchmentModel mj_objectWithKeyValues:dic[@"result"]];
                            [filesArray addObject:model];
                            str = [NSString stringWithFormat:@"%@%@,",str,dic[@"result"][@"file_id"]];
                            
                            [mArr addObject:dic[@"result"][@"file_id"]];
                        }
                    }
                    
                    if (weakSelf.clickBlock) {
                        weakSelf.clickBlock(weakSelf.files, mArr, str);
                    }
                    if (weakSelf.getFiles) {
                        weakSelf.getFiles(filesArray);
                    }
                    
                    [HUDManager hideLoading];
                    
                }];
            });
            
            
        };
        
    
        
        [[weakSelf currentViewController] presentViewController:pickerVC animated:YES completion:nil];
    }
    
}


- (void)uploadImage
{

    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"请选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"相册", nil];
    UIViewController * vc = [self currentViewController];
    [sheet showInView:vc.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex!=2) {
        
        CorePhotoPickerVCMangerType type=0;
        if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeCamera;
        if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeMultiPhoto;
        CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
        
        //设置类型
        manager.pickerVCManagerType=type;
        
        //最多可选50张
        manager.maxSelectedPhotoNumber=5;
        
        //错误处理
        if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
            DDLogDebug(@"设备不可用");
            return;
        }
        
        UIViewController *pickerVC=manager.imagePickerController;
        
        __weak typeof(self) weakSelf=self;
        //选取结束
        [[weakSelf currentViewController] presentViewController:pickerVC animated:YES completion:nil];

        manager.finishPickingMedia=^(NSArray *medias){
            DDLogDebug(@"%@",medias);
            [weakSelf.files removeAllObjects];
            [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
                DDLogDebug(@"%@",photo.editedImage);
                
                [weakSelf.files addObject:photo.editedImage];
                
                //                UIImage *newImage = [LHEmailTools imageWithImageSimple:photo.editedImage scaledToSize:CGSizeMake(120.0, 120.0)]; // 压缩图片
                NSString *newImageName=[NSString stringWithFormat:@"%@%@",[LHEmailTools getCurrentDateString],@".png"];//获得当前时间戳取名
                UploadParam * model = [UploadParam new];
                model.name = @"file";
                model.data =[CheckDataTool imageData:photo.editedImage];
                model.filename = newImageName;
                model.mimeType = @"image/png";
                [weakSelf.model.uploadFiles addObject:model];// 上传模型
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                DDLogDebug(@"添加图片完毕");
                [HUDManager showLoading];
                [LHRequestManager uploadFile:weakSelf.model.uploadFiles parameters:@{@"token":[UserInfoModel shared].token,@"fileType":weakSelf.fileType} completion:^(NSMutableArray *successResultPath, NSMutableArray *failIndex) {
                    
                    NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc]init];
                    for (NSNumber *num in failIndex) {
                        [indexSet addIndex:num.unsignedIntegerValue];
                    }
                    
                    [weakSelf.files removeObjectsAtIndexes:indexSet];// 移除掉
                    
                    NSString *str=@"";
                    NSMutableArray *mArr = [NSMutableArray array];
                    NSMutableArray * filesArray = [NSMutableArray array];
                    for (id dic in successResultPath) {
                        DDLogDebug(@"上传成功的数据：：：%@",dic);
                        if (dic &&dic != NULL &&dic[@"result"]&&dic[@"result"][@"file_id"]) {
                            LHAchmentModel * model = [LHAchmentModel mj_objectWithKeyValues:dic[@"result"]];
                            [filesArray addObject:model];
                            str = [NSString stringWithFormat:@"%@%@,",str,dic[@"result"][@"file_id"]];
                            
                            [mArr addObject:dic[@"result"][@"file_id"]];
                        }
                    }
                    
                    if (weakSelf.clickBlock) {
                        weakSelf.clickBlock(weakSelf.files, mArr, str);
                    }
                    if (weakSelf.getFiles) {
                        weakSelf.getFiles(filesArray);
                    }
                    
                    [HUDManager hideLoading];
                    
                }];
            });
            
            
        };
        
    }
    
}


#pragma mark --- 属性
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.titleLabel.font = FONTSIZE(13);
        [_button setTitleColor:[LHThemeManager shared].naviColor forState:UIControlStateHighlighted];
         [_button setTitleColor:[LHThemeManager shared].naviColor forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.tag = 888;
    }
    return _button;
}
- (NSMutableArray *)files
{
    if (!_files) {
        _files  = [[NSMutableArray alloc]init];
    }
    return _files;
}

- (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}


@end
