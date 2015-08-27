//
//  ViewController.m
//  XMPPText
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import "XMPPManager.h"

@interface ViewController ()<XMPPRosterDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *friendArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
    
    [[XMPPManager shareXMPPManager].XMPPRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [[XMPPManager shareXMPPManager] loginWithUserName:@"userName" passWord:@"passWord"];
    

    
    self.friendArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc ]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];

}

- (void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender{
    //一条一条拿出来
    NSLog(@"开始检索好友花名册");
}

- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(DDXMLElement *)item{
    NSString *jidStr = [[item attributeForName:@"jid"] stringValue];
    XMPPJID *jid = [XMPPJID jidWithString:jidStr];
    if ([self.friendArray containsObject:jid]) {
        return;
    }
    [self.friendArray addObject:jid];


    
//    [self.friendArray removeObject:jid];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.friendArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    NSLog(@"检索到%@", item);
}

- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender{
    NSLog(@"结束检索好友花名册");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.friendArray[indexPath.row] user];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.myJid = self.friendArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}


#pragma mark -- xmppRosterDelegate
//- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
//    
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
