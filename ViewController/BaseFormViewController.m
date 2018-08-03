//
//  BaseFormViewController.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/13.
//  Copyright © 2016年 15fen. All rights reserved.
//

#import "BaseFormViewController.h"
#import "BaseItem.h"
#import "CollcetionViewTableViewCell.h"
#import "TextInputTableViewCell.h"
#import "CheckDataTool.h"
@interface BaseFormViewController() 

@end
@implementation BaseFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.tableFooterView = [UIView new];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [ self.tableView addGestureRecognizer:tableViewGesture];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark ---------tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSection];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numOfRowsInSection:section];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseItem * item = [self.viewModel dataSourceAtRow:indexPath.row Section:indexPath.section];
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[[item class]identifier] forIndexPath:indexPath];
    cell.item = item;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{// 选中回调
    if (self.didSelectIndex) {
        self.didSelectIndex(indexPath);
    }else{
       
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseItem * item = [self.viewModel dataSourceAtRow:indexPath.row Section:indexPath.section];
    return MAX( 50, item.cellHeight);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.sectionHeaderHeight > 0) {
        return tableView.sectionHeaderHeight;
    }
    return GLOBLE_MARGIN;
}

- (void)buttonClickAtIndex:(NSInteger)index cell:(BaseTableViewCell *)cell
{
    if ([cell isKindOfClass:[CollcetionViewTableViewCell class]])
    { // 点击删除图片时
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }else if ([cell isKindOfClass:[TextInputTableViewCell class]])
    {
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    
}

// 关闭键盘的手势，点击tableview
- (void)closeKeyBoard{
   [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)reloadTableViewData {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)stupeCells:(NSArray*)cells forItems:(NSArray*)items
{
    NSAssert(cells != nil, @"cells 不能为空");
    NSAssert(items != nil, @"items 不能为空");
    NSAssert(cells.count == items.count, @"cells 和items数量必须相同");
    for (int i = 0; i < cells.count; i++) {
        NSString * cell = cells[i];
        NSString * item = items[i];
        // 注册cell......
        [self.tableView registerClass:NSClassFromString(cell) forCellReuseIdentifier:item];
    }
}
- (void)showTableViewHeader:(void(^)(void))refreshingBlock
{
    
     self.tableView.mj_header = [CheckDataTool showTableViewHeader:refreshingBlock];
}

- (void)showTableViewFooter:(void(^)(void))refreshingBlock
{
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:refreshingBlock];
}
#pragma mark --------属性声明
-(BaseTableView*)tableView
{
    if (!_tableView) {
        self.automaticallyAdjustsScrollViewInsets = YES;// scrollView自动布局
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.backgroundColor = CLEARCOLOR;
        //声明tableView的位置 添加下面代码
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)setViewModel:(BaseFormViewModel *)viewModel
{
    if (_viewModel != viewModel) _viewModel = viewModel;
    [self.tableView reloadData];
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.translucent = YES;
        _searchBar.barTintColor = BACKGROUND_COLOR;
        _searchBar.tintColor = BACKGROUND_COLOR;
        _searchBar.placeholder = LHSTRING(@"搜索");
        _searchBar.showsCancelButton = YES;
        [_searchBar setBackgroundImage:[UIImage new]];
        UIButton *cancleBtn = [_searchBar valueForKey:@"cancelButton"];
        
        //修改标题和标题颜色
        [cancleBtn setTitle:LHSTRING(@"取消") forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[LHThemeManager shared].naviColor forState:UIControlStateNormal];
        _searchBar.delegate = self;
        CGRect rect = _searchBar.frame;
        rect.size.height = 30;
        _searchBar.frame = rect;
        
    }
    
    
    return _searchBar;
    
}
@end
