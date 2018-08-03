//
//  LHExcelView.m
//  LHOrder
//
//  Created by migenwei on 2017/9/20.
//  Copyright © 2017年 15fen. All rights reserved.
//

#import "LHExcelView.h"

/*单元格数据模型*/
@interface LHExcelUnitItem ()

@end
@implementation LHExcelUnitItem
- (instancetype)initWithUnitdata:(NSString *)unitdata textColor:(UIColor *)color
{
    if (self = [super init]) {
        _unitData = unitdata;
        _textColor = color;
    }
    return self;
}

@end

/*表格单元格*/
@interface LHExcelViewUnitCell()
@property(nonatomic,strong)UILabel *textLabel; // 显示数据
@property(nonatomic,strong)UITextField *inputText;// 输入域
@property(nonatomic,strong)UIImageView *bgImage;// 背景图
@end

@implementation LHExcelViewUnitCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =  [super initWithFrame:frame]) {
        [self addView];
    }
    return self;
}
- (void)addView
{
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    MJWeakSelf
    [[self.inputText rac_textSignal]subscribeNext:^(id x) {
        if ([x isMemberOfClass:[NSString class]]) {
            weakSelf.textLabel.text = x;
            if ([weakSelf.item isKindOfClass:[LHExcelUnitItem class]])
            {
                LHExcelUnitItem * model = (LHExcelUnitItem*)weakSelf.item;
                model.unitData = x;
            }
        }
        
        
    }];
    
}

#pragma mark------- 属性声明
- (void)setItem:(BaseItem *)item
{
    if ([item isKindOfClass:[LHExcelUnitItem class]]) {
        LHExcelUnitItem * model = (LHExcelUnitItem*)item;
        self.textLabel.hidden = model.edit;
        self.inputText.hidden = !model.edit;
        self.textLabel.text = model.unitData?:@"";
        self.inputText.text = model.unitData?:@"";
        self.textLabel.textColor = model.textColor?:BLACK;
        self.inputText.textColor = model.textColor?:BLACK;
        self.bgImage.image = ImageNamed(model.bgImage);
        self.backgroundColor = model.bgColor?:WHITE;
        self.inputText.keyboardType = model.keyboardType;
    }
    [super setItem:item];
}
- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.numberOfLines = 0;
        _textLabel.tag = 110;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = BLACK;
        _textLabel.font = DEFAULTFONTSIZE;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
- (UITextField *)inputText
{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
        _inputText.borderStyle = UITextBorderStyleNone;
        _inputText.textAlignment = NSTextAlignmentCenter;
        _inputText.font = DEFAULTFONTSIZE;
        [self addSubview:_inputText];
    }
    return _inputText;
}


@end




@interface LHExcelView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectioView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@end
@implementation LHExcelView
- (instancetype)init
{
    if (self = [super init]) {
        _collectioView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectioView.delegate = self;
        _collectioView.dataSource = self;
        _collectioView.showsVerticalScrollIndicator = NO;
        _collectioView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectioView];
        _collectioView.backgroundColor = CLEARCOLOR;
        [_collectioView registerClass:[LHExcelViewUnitCell class] forCellWithReuseIdentifier:[LHExcelUnitItem identifier]];
        [_collectioView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _collectioView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:self.layout];
        _collectioView.delegate = self;
        _collectioView.dataSource = self;
        _collectioView.showsVerticalScrollIndicator = NO;
        _collectioView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_collectioView];
        _collectioView.scrollEnabled = NO;
        _collectioView.backgroundColor = CLEARCOLOR;
        [_collectioView registerClass:[LHExcelViewUnitCell class] forCellWithReuseIdentifier:[LHExcelUnitItem identifier]];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.dataSource respondsToSelector:@selector(numOfArrangeExcelView:)]) {
        return [self.dataSource numOfArrangeExcelView:self];
    }else
    {
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(numOfRowExcelView:)]) {
        return [self.dataSource numOfRowExcelView:self];
    }else
    {
        return 0;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.dataSource respondsToSelector:@selector(excelViewCell:indexPath:)]) {
        LHExcelViewUnitCell *cell = [self.dataSource excelViewCell:self indexPath:indexPath];
        if ([self.dataSource respondsToSelector:@selector(excelUnitDataAtIndexPath:excelView:)]) {
            cell.item = [self.dataSource excelUnitDataAtIndexPath:indexPath excelView:self];
        }
        return cell;
    }else
    {
        LHExcelViewUnitCell *cell  =[collectionView dequeueReusableCellWithReuseIdentifier:[LHExcelUnitItem identifier] forIndexPath:indexPath];
        if ([self.dataSource respondsToSelector:@selector(excelUnitDataAtIndexPath:excelView:)]) {
            cell.item = [self.dataSource excelUnitDataAtIndexPath:indexPath excelView:self];
        }
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(arrangeWidth:excelView:)]&&[self.delegate respondsToSelector:@selector(rowHeight:excelView:)]) {
        CGFloat height = [self.dataSource rowHeight:indexPath.row excelView:self];
        CGFloat width = [self.dataSource arrangeWidth:indexPath.section excelView:self];
        return CGSizeMake(width, height);
    }else
    {
        return CGSizeZero;
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(excelView:didSelectAtIndexPath:)]) {
        [self.delegate excelView:self didSelectAtIndexPath:indexPath];
    }
}


#pragma mark -------属性声明
- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 1.0f;
        _layout.minimumInteritemSpacing = 0.1f;
    }
    return _layout;
}
- (BaseCollectionViewCell*)dequeueReusableCellWithReuseIdentifier:(NSString*)identifier forIndexPath:indexPath
{
    return [self.collectioView dequeueReusableCellWithReuseIdentifier:indexPath forIndexPath:indexPath];
}
- (void) registerClass:(Class)class forCellWithReuseIdentifier:(NSString*)identifier
{
    return [self.collectioView registerClass:class forCellWithReuseIdentifier:identifier];
}
- (void)reloadData
{
    [self.collectioView reloadData];
}
@end
