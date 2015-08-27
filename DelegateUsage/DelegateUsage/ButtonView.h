//
//  ButtonView.h
//  DelegateUsage
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

//写一个代理咯
@protocol ButtonClickDelegate <NSObject>

//声明一个代理方法
- (void)btnClicked:(UIButton *)btn;

@end

@interface ButtonView : UIView

//声明一个代理的属性
@property (nonatomic, assign) id<ButtonClickDelegate> buttonClickDelegate;


@end
