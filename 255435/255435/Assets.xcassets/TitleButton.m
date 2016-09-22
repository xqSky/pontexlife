//
//  TitleButton.m
//  255435
//
//  Created by 肖强 on 16/8/25.
//  Copyright © 2016年 xiaoqiang. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

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
        _radio=0.9;
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX=0;
    CGFloat titleY=0;
    CGFloat titleW=CGRectGetWidth(contentRect)*_radio;
    CGFloat titleH=CGRectGetHeight(contentRect);
    CGRect rect =CGRectMake(titleX, titleY, titleW, titleH);
    return  rect;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imgX = _radio * CGRectGetWidth(contentRect);
    CGFloat imgY = 0;
    CGFloat imgW = (1-_radio) * CGRectGetWidth(contentRect);
    CGFloat imgH = CGRectGetHeight(contentRect);
    return CGRectMake(imgX, imgY, imgW, imgH);
}
@end
