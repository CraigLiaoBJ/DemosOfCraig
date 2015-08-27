//
//  ViewController.m
//  Animation
//
//  Created by Craig Liao on 15/7/21.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *animationView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.animationView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.animationView];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //最简单的view层动画，第一个参数代表的是动画的执行时间，下一个block代表的是动画执行的内容。

//    [UIView animateWithDuration:2.0f animations:^{
//        self.animationView.frame = CGRectMake(200, 200, 200, 200);
//        self.animationView.backgroundColor = [UIColor redColor];
//    }];
    
    //实现一个简单动画的第二种方法，第一个参数代表的是动画执行的时间
    //第一个block代表的是动画执行的内容。
    //第二个block代表的是在动画结束之后会执行。
//    [UIView animateWithDuration:2.0f animations:^{
//        [UIView animateWithDuration:2.0f animations:^{
//            self.animationView.frame = CGRectMake(200, 200, 200, 200);
//            self.animationView.backgroundColor = [UIColor redColor];
//        }];
//    } completion:^(BOOL finished) {
//        self.animationView.frame = CGRectMake(100, 100, 100, 100);
//        self.animationView.backgroundColor = [UIColor blackColor];
//    }];
    
    
    //复杂方式实现动画
    //开始一个动画
    //参数可以不填
    [UIView beginAnimations:nil context:nil];
    //设置动画延迟
//    [UIView setAnimationDelay:2.0f];
    //设置动画的执行时间
    [UIView setAnimationDuration:3.0f];
    //设置动画的回复路径
    [UIView setAnimationRepeatAutoreverses:NO];
    //重复次数

    [UIView setAnimationRepeatCount:20000];
    

    //第一个参数，填写一个View的Transform属性
    //第二个参数，旋转的角度
    //此方法设置view的transform的属性的时候，如果使用make的方法，则不会携带view的transform属性，会重复的从原始的状态执行，反之，会从transform改变之后的状态执行
//    _animationView.transform = CGAffineTransformRotate(_animationView.transform, M_PI_4);
    
    _animationView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    //动画实现内容
//    _animationView.frame = CGRectMake(200, 200, 200, 200);
    _animationView.backgroundColor = [UIColor redColor];
    
    //在写完动画之后 再提交动画
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
