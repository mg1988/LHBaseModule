//
//  BaseViewController.m
//  BaseProject
//
//  Created by 刘航宇 on 16/9/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "BaseViewController.h"
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LHVoiceToolViewController.h"
#define NAVIRIGHTBTTUON @"call"
@interface BaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSDate * time;

@end
@implementation BaseViewController

#pragma mark --------生命周期
- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme:) name:(NSString*)themeChangeNoti object:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 让导航栏不遮挡底部视图
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.bgImageView];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:ImageNamed(NAVIRIGHTBTTUON) style:UIBarButtonItemStyleDone target:self action:@selector(callPhone)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self golobelButton];
}
- (void)golobelButton{
    AppDelegate * delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isShowGLobleButton"] && ![self isKindOfClass:[LoginViewController class]]&&
        ![self isKindOfClass:[LHVoiceToolViewController class]] && self.navigationController) {
        [delegate.globelWindow showWindow];
        MJWeakSelf
        delegate.globelWindow.callService = ^{
            [weakSelf.navigationController pushViewController:[LHVoiceToolViewController new] animated:YES];
        };
    }else{
         [delegate.globelWindow dissmissWindow];
    }
}
- (void)callPhone{
    [HUDManager showBriefAlert:LHSTRING(@"未授权")];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    DDLogDebug(@"%@:::内存溢出", NSStringFromClass([self class]));
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}
- (void)viewDidUnload
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
    
    [super viewDidUnload];
}
- (void)changeTheme:(NSNotification*)noti
{
    LHThemeManager * manager = [LHThemeManager shared];
    [manager getDatas];
    if (self.navigationController) {
        if ([LHThemeManager shared].naviBgImage) {
            [[UINavigationBar appearance]setBackgroundImage:manager.naviBgImage forBarMetrics:UIBarMetricsDefault];
        }else
        {
             [[UINavigationBar appearance]setBarTintColor:manager.naviColor];
             [[UINavigationBar appearance]setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        }
        if (manager.bgImage) {
            [self.bgImageView setImage:manager.bgImage];
        }
    }
}
#pragma mark -------懒加载
-(UIImageView *)bgImageView {
	if(_bgImageView == nil) {
		_bgImageView = [[UIImageView alloc] init];
	}
	return _bgImageView;
}
// 移除观察
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:(NSString*)themeChangeNoti object:nil];
}
@end
