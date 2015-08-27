//
//  ViewController.m
//  Drawer
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    //定义tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 20000;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    //侧边view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-100, 200, 100, 200)];
    view.tag = 10000;
    [self.view addSubview:view];
    
    //view上的按钮
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 50 * i, 100, 30);
        button.backgroundColor = [UIColor greenColor];
        [view addSubview:button];
    }
    
    //用来控制的按钮，在顶上
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"出来吧" forState:UIControlStateNormal];
    [button1 setTitle:@"收起来" forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(100, 20, 100, 30);
    // Do any additional setup after loading the view, typically from a nib.
}

//控制按钮点击后的效果
- (void)buttonClicked:(UIButton *)sender
{
    UIView *view = (UIView *)[self.view viewWithTag:10000];
    UITableView *tableView = (UITableView *)[self.view viewWithTag:20000];
    if (sender.selected) {
        [UIView animateWithDuration:1.0f animations:^{
            view.frame = CGRectMake(-100, 200, 100, 200);
            tableView.frame = CGRectMake(0, 64, tableView.frame.size.width, self.view.frame.size.height - 64);
        }];
        sender.selected = NO;
        
        
    } else {
        [UIView animateWithDuration:1.0f animations:^{
            view.frame = CGRectMake(0, 200, 100, 200);
            tableView.frame = CGRectMake(100, 200, tableView.frame.size.width, self.view.frame.size.height - 464);
        }];
        sender.selected = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
