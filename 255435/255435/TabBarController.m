//
//  TabBarController.m
//  255435
//
//  Created by 肖强 on 16/8/24.
//  Copyright © 2016年 xiaoqiang. All rights reserved.
//

#import "TabBarController.h"
#import "WBTabBar.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface TabBarController ()
@property(nonatomic,strong)WBTabBar*wbTabBar;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加自定义TabBar
    [self addCustomTabBar];
    // 添加viewControllers
    [self addViewControlers];
    
}
/** 添加视图控制器*/
- (void)addViewControlers{
    NSArray *vcNameArray = @[@"HomeTableViewController",
                             @"MessageTableViewController",
                             @"DiscoveryTableViewController",
                             @"PersonalTableViewController"];
    NSArray *vcTitleArray = @[@"首页",@"消息",@"发现",@"我"];
    
    //普通状态图片
    NSArray *norImageArray = @[@"tabbar_home",
                               @"tabbar_message_center",
                               @"tabbar_discover",
                               @"tabbar_profile"];
    //选中状态图片
    NSArray *selImageArray = @[@"tabbar_home_selected",
                               @"tabbar_message_center_selected",
                               @"tabbar_discover_selected",
                               @"tabbar_profile_selected"];
    for (NSString*title2 in vcNameArray) {
        Class className=NSClassFromString(title2);
        UITableViewController*tableViewController=[[className alloc]init];
        [tableViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [tableViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
        NSInteger index =[vcNameArray indexOfObject:title2];
        tableViewController.title=vcTitleArray[index];
        [tableViewController.tabBarItem setImage:[[UIImage imageNamed:norImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tableViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:selImageArray[index]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tableViewController.tabBarItem setTitle:vcTitleArray[index]];
        UINavigationController*navi=[[UINavigationController alloc]initWithRootViewController:tableViewController];
        self.wbTabBar.tabBarItem=tableViewController.tabBarItem;
        [self addChildViewController:navi];
        if (index==3) {
            for (UIView*view in self.tabBar.subviews) {
                Class uiTabbarButton=NSClassFromString(@"UITabBarButton");
                if ([view isKindOfClass:[uiTabbarButton class]]) {
                    [view removeFromSuperview];
                }
            }
        }
    }
}
- (void)addCustomTabBar{

    self.wbTabBar=[[WBTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
   
    [self.tabBar addSubview:self.wbTabBar];
     self.wbTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
