//
//  BaseFormViewController.h
//  BaseProject
//
//  Created by 刘航宇 on 16/9/13.
//  Copyright © 2016年 15fen. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewCell.h"
#import "BaseTableView.h"
/**
 *  自带tableView的控制器 适用于使用BaseFormViewModel
 */
@interface BaseFormViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BaseTableViewCellDelegate,BaseFormViewModelDelegate,UISearchBarDelegate>
@property (nonatomic, strong) BaseTableView * tableView;// 默认的tableView
@property (nonatomic, strong) BaseFormViewModel * viewModel;// 默认的viewModel
@property(nonatomic,copy)void(^didSelectIndex)(NSIndexPath*indexPath);//选中的行
@property (nonatomic, strong) UISearchBar * searchBar;// 搜索栏

 /*使用cell 和Item进行注册*/
- (void)stupeCells:(NSArray*)cells forItems:(NSArray*)items;

- (void)showTableViewHeader:(void(^)(void))refreshingBlock;// 下拉刷新

- (void)showTableViewFooter:(void(^)(void))refreshingBlock;// 上啦加载


@end
