//
//  WBTabBar.m
//  255435
//
//  Created by 肖强 on 16/8/24.
//  Copyright © 2016年 xiaoqiang. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"
@interface WBTabBar ()

/** 按钮数组*/
@property (nonatomic,strong) NSMutableArray *buttonArray;

/** 当前选中按钮*/
@property (nonatomic, strong) WBTabBarButton *selecteBtn;

/** 中间加号按钮*/
@property (nonatomic, strong) UIButton *plusBtn;

@end
@implementation WBTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusBtn];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        self.plusBtn = plusBtn;
        [plusBtn addTarget:self action:@selector(plusBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}
-(void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    WBTabBarButton*tabBarButton=[WBTabBarButton buttonWithType:UIButtonTypeCustom];
    tabBarButton.tabBarItem=tabBarItem;
    [self addSubview:tabBarButton];
    [self.buttonArray addObject:tabBarButton];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 布局子视图
    // 循环按钮数组，做相应的布局
    
    CGFloat btnW = CGRectGetWidth(self.frame)/(CGFloat)(self.buttonArray.count + 1);
    CGFloat plusW = self.plusBtn.currentBackgroundImage.size.width;
    CGFloat plusH = self.plusBtn.currentBackgroundImage.size.height;
    
    self.plusBtn.frame = CGRectMake(0, 0, plusW, plusH);
    self.plusBtn.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        WBTabBarButton *btn = self.buttonArray[i];
        CGFloat bX = btnW * i;
        if (i > 1) {
            bX += btnW;
        }
        CGFloat bY = 0;
        CGFloat bW = btnW;
        CGFloat bH = CGRectGetHeight(self.frame);
        
        
        btn.frame = CGRectMake(bX, bY, bW, bH);
    }
    
}
@end
