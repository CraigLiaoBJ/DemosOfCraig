//
//  ViewController.m
//  DelegateUsage
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"
#import "ButtonView.h"
@interface ViewController ()<ButtonClickDelegate>



#pragma mark -- 怎么使用代理咯
//1. 在view里面设置代理，设置按钮，设置点击事件；
//2. 在controller 里面遵循代理，指定代理，实现代理方法

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //把封装好的view放到controller中
    ButtonView *btnView = [[ButtonView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    btnView.buttonClickDelegate = self;
    btnView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:btnView];
}

//实现代理方法
- (void)btnClicked:(UIButton *)btn{
    UIViewController *view = [[UIViewController alloc] init];
    view.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
