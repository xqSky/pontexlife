//
//  WBTabBarButton.m
//  255435
//
//  Created by 肖强 on 16/8/24.
//  Copyright © 2016年 xiaoqiang. All rights reserved.
//

#import "WBTabBarButton.h"

@implementation WBTabBarButton

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
        _ratio=0.6;
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    
    // 将自己添加成观察者，监听_tabBarItem的角标值(badgeValue)的改变
    [_tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];

    [self setTitle:tabBarItem.title forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
    
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetHeight(contentRect) * _ratio;
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect) * (1- _ratio);
    return CGRectMake(titleX, titleY, titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(contentRect);
    CGFloat imgH = CGRectGetHeight(contentRect) * _ratio;
    return CGRectMake(imgX, imgY, imgW, imgH);
}
@end
