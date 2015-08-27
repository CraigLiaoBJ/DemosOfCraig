//
//  ButtonView.m
//  DelegateUsage
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加按钮
        [self  setupButton];
    }
    return self;
}

//按钮
- (void)setupButton{
    //创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 100);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"点击我" forState:UIControlStateNormal];
    
    [self addSubview:button];
    //按钮的点击事件
    [button addTarget:self action:@selector(didClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
}

//点击事件
- (void)didClickedBtn:(UIButton *)btn{
    //判定是否是这个代理，是否响应了这个它的代理方法
    if (self.buttonClickDelegate && [self.buttonClickDelegate respondsToSelector:@selector(btnClicked:)]) {
        //如果是的话就直接执行代理方法
        [self.buttonClickDelegate btnClicked:btn];
    }
}


@end
