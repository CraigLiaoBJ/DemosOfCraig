//
//  ViewController.m
//  SegChangeData
//
//  Created by Craig Liao on 15/8/27.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = [NSMutableArray array];
    //设置一个数组
    for (int i = 0; i < 200; i ++) {
        int index = arc4random() % 2000;
        
        NSString *string = [NSString stringWithFormat:@"%d", index];
        
        [self.arr addObject:string];
    }
    
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    //创建分段控制器
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"蹲坑", @"坐坑"]];
    segment.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    //添加点击事件
    [segment addTarget:self action:@selector(dunkengClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
}

//设置点击事件
- (void)dunkengClicked:(UISegmentedControl *)seg
{
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.tableView reloadData];
            break;
        case 1:
            
            [self.arr removeAllObjects];
            for (int i = 0; i < 200; i ++) {
                int index = arc4random() % 2000;
                
                NSString *string = [NSString stringWithFormat:@"%d", index];
                
                [self.arr addObject:string];
            }
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
