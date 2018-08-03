//
//  LHKeyValueCell.m
//  LHFarm
//
//  Created by migenwei on 2017/8/3.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHKeyValueCell.h"
#import "LHKeyValueItem.h"
#import "LHPickUserItem.h"
#import "LHOrganizationViewController.h"
#import "ClientModel.h"
#import <UIButton+WebCache.h>
#define CELL_HEIGHT 40
@interface LHKeyValueCell()
@property(nonatomic,assign) CGFloat radio;// YES是半圆角
@property(nonatomic,strong)UIButton *tapButton;// 点击事件
@end
@implementation LHKeyValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addViews];
    }
    return self;
}
- (void)addViews
{
    [self addSubview:self.valueLabel];
    [self addSubview:self.keyLabel];
    [self addSubview:self.rightButton];
    [self addSubview:self.tapButton];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat padding = isPad?30:10;
    CGFloat keyWidth = 80;
    self.tapButton.frame = self.bounds;
    if(self.keyLabel.hidden){
        self.keyLabel.frame = CGRectMake(padding, 0, 0, self.mj_h);
    }else
    {
        self.keyLabel.frame = CGRectMake(padding, 0, keyWidth, self.mj_h);
    }
    if (self.rightButton.hidden) {
        self.rightButton.frame = CGRectZero;
        if(self.accessoryType == UITableViewCellAccessoryNone)
        {
           self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.keyLabel.frame)+padding, 0, self.mj_w - CGRectGetMaxX(self.keyLabel.frame)-padding*2, self.mj_h);
        }else
        {
            self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.keyLabel.frame)+padding, 0, self.mj_w - CGRectGetMaxX(self.keyLabel.frame)-padding*3, self.mj_h);
        }
        
    }else
    {
        CGFloat width = [self.rightButton.titleLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH, self.mj_h*0.5)].width;
        if (width< 60) {
            width = 60;
        }
        if(self.accessoryType == UITableViewCellAccessoryNone)
        {
             self.rightButton.frame = CGRectMake(SCREEN_WIDTH - width-padding, self.mj_h*0.25, width, self.mj_h*0.5);
        }else
        {
              self.rightButton.frame = CGRectMake(SCREEN_WIDTH - width-padding*2, self.mj_h*0.25, width, self.mj_h*0.5);
        }
        if (self.radio >0) {
            self.rightButton.layer.cornerRadius = self.radio;
        }else
        {
            self.rightButton.layer.cornerRadius = 0;
        }
        self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.keyLabel.frame)+padding, 0, self.rightButton.mj_x - CGRectGetMaxX(self.keyLabel.frame) -padding-GLOBLE_MARGIN, self.mj_h);
    }
}
-(void)clickTap{
    if ([self.item isKindOfClass:[LHPickUserItem class]]) {
        __weak LHPickUserItem * item = (LHPickUserItem*)self.item;
        LHOrganizationViewController *VC= nil;
        MJWeakSelf
        if (item.selectType == TreeSelectAllOrgType) { // 所有的组织架构 不包含人员
            VC = [LHOrganizationViewController selectAllOrgWithComplete:^(NSString *orgNames, NSString *orgids) {
                if ([weakSelf maxSelectAlert:orgids maxCount:item.maxCount]) {
                    item.value = orgNames;
                    item.ids = orgids;
                    weakSelf.valueLabel.text = orgNames;
                }
            }];
             VC.title  = item.selectTitle?: @"";
        }else if (item.selectType == TreeSelectAllOrgUserType){
            // 包含人员
            VC = [LHOrganizationViewController selectCtrlWithComplete:^(NSString *users, NSString *ids) {
                if ([weakSelf maxSelectAlert:ids maxCount:item.maxCount]) {
                    item.value = users;
                    item.ids = ids;
                    weakSelf.valueLabel.text = users;
                }
              
            }];
             VC.title  = item.selectTitle?: @"";
        }else if (item.selectType == TreeSelectCompanyType){
            //公司架构
            VC = [LHOrganizationViewController selectCompanyOrgWithComplete:^(NSString *orgNames, NSString *orgids) {
                if ([weakSelf maxSelectAlert:orgids maxCount:item.maxCount]) {
                    item.value = orgNames;
                    item.ids = orgids;
                    weakSelf.valueLabel.text = orgNames;
                }
        
            }];
             VC.title  = item.selectTitle?: @"";
        }else if (item.selectType == TreeSelectCompanyUserType){
         // 包含公司人员
            VC = [LHOrganizationViewController selectCompanyUsersWithComplete:^(NSString *users, NSString *ids) {
                if ([weakSelf maxSelectAlert:ids maxCount:item.maxCount]) {
                    item.value = users;
                    item.ids = ids;
                    weakSelf.valueLabel.text = users;
                }
            }];
             VC.title  = item.selectTitle?: @"";
        }else if (item.selectType == TreeSelectAllCompanyType){
            VC = [LHOrganizationViewController selectAllCompanyComplete:^(NSString *orgNames, NSString *orgids) {
                if ([weakSelf maxSelectAlert:orgids maxCount:item.maxCount]) {
                    item.value = orgNames;
                    item.ids = orgids;
                    weakSelf.valueLabel.text = orgNames;
                }
            }];
            VC.title  = item.selectTitle?: LHSTRING(@"选择公司");
        }else if (item.selectType == TreeSelectSuperUserType){
            if (![UserInfoModel shared].supers) {
                VC = [LHOrganizationViewController selectCompanyUsersWithComplete:^(NSString *users, NSString *ids) {
                    item.value = users;
                    item.ids = ids;
                    weakSelf.valueLabel.text = users;
                }];
            }else{
                VC = [LHOrganizationViewController selectSuperUser:^(NSString *users, NSString *ids) {
                    item.value = users;
                    item.ids = ids;
                    weakSelf.valueLabel.text = users;
                }];
                 VC.title  = item.selectTitle?: LHSTRING(@"选择上级");
            }    
        }else if (item.selectType == TreeSelectGroupUserType){
            VC = [LHOrganizationViewController selectGroupUser:^(NSString *users, NSString *ids) {
                item.value = users;
                item.ids = ids;
                weakSelf.valueLabel.text = users;
            }];
            VC.title  = item.selectTitle?: LHSTRING(@"选择人员");
        }else if (item.selectType == TreeSelectGroupAndSuperUserType){
            VC = [LHOrganizationViewController selectGroupAndSuperUser:^(NSString *users, NSString *ids) {
                item.value = users;
                item.ids = ids;
                weakSelf.valueLabel.text = users;
            }];
            VC.title  = item.selectTitle?: LHSTRING(@"选择人员");
        }
        UIViewController * base = [ClientModel currentViewController];
        [base.navigationController pushViewController:VC animated:YES];
        
    }
}
- (BOOL)maxSelectAlert:(NSString*)ids maxCount:(NSInteger)max{
    NSArray * idArray =  [ids componentsSeparatedByString:@","];
    if (idArray.count > max && max > 0) {
        [HUDManager showBriefAlert:[NSString stringWithFormat:@"%@%ld%@",LHSTRING(@"最多选择"),max,LHSTRING(@"个")]];
        return NO;
    }else{
        return YES;
    }
}
#pragma mark -------属性声明
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHKeyValueItem class]]) {
        LHKeyValueItem * model = (LHKeyValueItem*)item;
        self.keyLabel.text = model.title;
        self.keyLabel.font = model.titleFont?:FONTSIZE(13);
        self.keyLabel.textColor = model.titleColor?:BLACK;
        self.keyLabel.textAlignment = model.titleAlignment;
        self.valueLabel.textColor = model.valueColor?:GRAYCOLOR;
        self.keyLabel.hidden = !model.isShowKeyLabel;
        self.radio = model.radio;
        if (model.valueAttribute) {
            self.valueLabel.attributedText =model.valueAttribute;
        }
        else if (model.valueAttri) {
            self.valueLabel.attributedText = [[NSAttributedString alloc]initWithString:model.valueAttri];
        }else
        {
              self.valueLabel.text = model.value;
        }
        self.valueLabel.textAlignment = model.valueAlignment;
        self.valueLabel.font = model.valueFont?:FONTSIZE(13);
        self.rightButton.hidden = !model.isShowRightButton;
        [self.rightButton setTitle:model.rightButtonTitle?:@"" forState:UIControlStateNormal];
        if (model.isNetImage) {
            [self.rightButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.rightButtonImage] forState:UIControlStateNormal];
        }else{
            [self.rightButton setImage:ImageNamed(model.rightButtonImage)?:nil forState:UIControlStateNormal];
        }
        [self.rightButton setBackgroundColor:model.rightBUttonBgColor?:CLEARCOLOR];
        [self.rightButton setTitleColor:model.rightButtonTitleColor?:BLACK forState:UIControlStateNormal];
        self.rightButton.enabled = model.enable;
        self.tapButton.enabled = NO;
        
    }
    if ([item isKindOfClass:[LHPickUserItem class]]) {
         self.tapButton.enabled = YES;
    }
    [super setItem:item];
    
}
+ (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath widthRadio:(CGFloat)radio
{
    return CELL_HEIGHT;
}
- (void)click:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(buttonClickAtIndex:cell:)]) {
        [self.delegate buttonClickAtIndex:12323 cell:self];
    }
}
#pragma mark ------属性声明
-(UILabel *)keyLabel
{
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc]init];
        _keyLabel.numberOfLines = 0 ;
        _keyLabel.font = FONTSIZE(13);
        _keyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _keyLabel.textColor = GRAYCOLOR;
    }
    return _keyLabel;
}

-(UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.numberOfLines = 0 ;
        _valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _valueLabel.font = FONTSIZE(13);
        _valueLabel.textColor = GRAYCOLOR;
        _valueLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _valueLabel;
}
-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font =DEFAULTFONTSIZE;
        [_rightButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (UIButton*)tapButton{
    if (!_tapButton) {
        _tapButton = [[UIButton alloc]init];
        [_tapButton addTarget:self action:@selector(clickTap) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _tapButton;
}
@end
