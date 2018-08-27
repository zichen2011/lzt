//
//  MyTabbarController.m
//  lzt
//
//  Created by hwq on 2017/12/1.
//  Copyright © 2017年 hwq. All rights reserved.
//

#import "MyTabbarController.h"
#import "WToast.h"
#import "LoginViewController.h"
#import "NavigationController.h"

@interface MyTabbarController ()<UITabBarControllerDelegate>

@end
@implementation MyTabbarController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    self.selectedIndex = 0;
    self.tabBar.barTintColor = [UIColor whiteColor];
	self.tabBar.tintColor = UIColorFromRGB(0x3f77f1);
	self.tabBar.unselectedItemTintColor = UIColorFromRGB(0x7e7e7e);
    self.tabBar.backgroundColor = [UIColor whiteColor];
   // self.title = @"首页";
    //网络监听
    [self AFNetworkStatus];
    [self hideBackButtonText];
}
- (void)hideBackButtonText{
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
}
- (void)setupSubviews {
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
	
	UIColor *tintColor = UIColorFromRGB(0x3f77f1);
    
   _homePage = [s instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    _homePage.tabBarItem.tag = 0;
	UIImage *zhuye = [UIImage imageNamed:@"主页"];
    _homePage.tabBarItem= [[UITabBarItem alloc]initWithTitle:@"首页" image:zhuye selectedImage:zhuye];
     [_homePage.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
    
    s = [UIStoryboard storyboardWithName:@"Project" bundle:nil];
    _project = [s instantiateViewControllerWithIdentifier:@"ProjectController"];
    _project.tabBarItem.tag = 1;
	UIImage *chuxuguan = [UIImage imageNamed:@"储蓄罐"];
    _project.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"投资" image:chuxuguan selectedImage:chuxuguan];
     [_project.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
    
//    s = [UIStoryboard storyboardWithName:@"Foundation" bundle:nil];
//    _found = [s instantiateViewControllerWithIdentifier:@"FoundationController"];
//    _found.tabBarItem.tag = 2;
//    _found.tabBarItem= [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"发现.png"]selectedImage:[self originalImageName:@"发现2.png"]];
//     [_found.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
    
    s = [UIStoryboard storyboardWithName:@"Foundation" bundle:nil];
    _nfound = [s instantiateViewControllerWithIdentifier:@"NewFoundationViewController"];
    _nfound.tabBarItem.tag = 2;
	UIImage *faxian = [UIImage imageNamed:@"发现"];
    _nfound.tabBarItem= [[UITabBarItem alloc]initWithTitle:@"发现" image:faxian selectedImage:faxian];
	
    [_nfound.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
    
    s = [UIStoryboard storyboardWithName:@"MyInfo" bundle:nil];
    _myinfo = [s instantiateViewControllerWithIdentifier:@"MyInfoViewController"];
    _myinfo.tabBarItem.tag = 3;
	UIImage *wode = [UIImage imageNamed:@"个人中心"];
    _myinfo.tabBarItem= [[UITabBarItem alloc]initWithTitle:@"我的" image:wode selectedImage:wode];
     [_myinfo.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
    //NavigationController *nav = [[NavigationController alloc]initWithRootViewController:_myinfo];
    
    self.viewControllers =@[_homePage,_project,_nfound,_myinfo];
}
- (UIImage*)originalImageName:(NSString*)imageName
{
    UIImage *img = [UIImage imageNamed:imageName];
    
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
    
    }else if (item.tag == 1){
        self.title = @"投资";
    
    }else if (item.tag == 2){
        self.title = @"发现";
       
    }else if (item.tag == 3){
        self.title = @"我的资料";
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"设置.png"] style:UIBarButtonItemStylePlain target:self action:@selector(set)];
        self.navigationItem.rightBarButtonItem = right;
    }
    
}

//监听网络状态
-(void)AFNetworkStatus {
    
    [NetManager NetworkStatus:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //[WToast showWithText: @"未知网络状态"];
                [self showHint:@"未知网络状态" yOffset:0];
                break;
            case AFNetworkReachabilityStatusNotReachable:
               // [WToast showWithText: @"没有网络，请检查网络连接。"];
                [self showHint:@"网络连接失败，请检查网络状态。" yOffset:0];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // [WToast showWithText: @"蜂窝数据网"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //  [WToast showWithText: @"wifi"];
                NSLog(@"Wi-Fi");
                break;
            default:
                break;
        }
    }];
}

@end
