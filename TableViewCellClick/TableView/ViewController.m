//
//  ViewController.m
//  TableView
//
//  Created by Craig Liao on 15/7/13.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

/**
 *  声明tableView属性
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  声明一个BOOL值的属性，用于判定是否增加cell的高度
 */
@property (nonatomic, assign) BOOL needAddHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /**
     * 初始化tableView
     */
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    /**
     *  添加代理
     */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    /**
     *  注册tableViewCell
     */
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"CELL"];

}

#pragma mark --- 代理方法
/**
 *  行高
 *
 *  @param tableView 表视图
 *  @param indexPath 下标路径
 *
 *  @return CGFloat
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   //行下标为1时，进行相应操作
    if (indexPath.row == 1) {
        //当添加高度BOOL值为YES的时候，进行赋值，改变cell的高度。
        if (self.needAddHeight) {
            return 60;
        } else {
            return 44;
        }
    } else {
        return 44;
    }
}

/**
 *  行数
 *
 *  @param tableView 表视图
 *  @param section   分区
 *
 *  @return NSInteger
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

/**
 *  重用机制
 *
 *  @param tableView 表视图
 *  @param indexPath 下标路径
 *
 *  @return cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    return cell;
}

/**
 *  行被选中后的操作
 *
 *  @param tableView 表视图
 *  @param indexPath 下标路径
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        //取反,点击后会跑到上面那儿走
        self.needAddHeight = !self.needAddHeight;
        //刷新数据
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
