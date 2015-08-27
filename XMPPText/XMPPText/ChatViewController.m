//
//  ChatViewController.m
//  XMPPText
//
//  Created by Craig Liao on 15/8/18.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITableViewDataSource, UITableViewDelegate, XMPPStreamDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButton)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    [[XMPPManager shareXMPPManager].XMPPStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    self.title = @"聊天界面";
    self.dataArray = [NSMutableArray array];
    [self reloadMessage];
    
  
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (void)reloadMessage{
    
    NSManagedObjectContext *context = [XMPPManager shareXMPPManager].context;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bareJidStr = %@ AND streamBareJidStr = %@", self.myJid.bare, [XMPPManager shareXMPPManager].XMPPStream.myJID.bare];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (self.dataArray.count != 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray setArray:fetchedObjects];
    [self.tableView reloadData];
    
    if (self.dataArray.count) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"%@",message);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XMPPMessageArchiving_Message_CoreDataObject *message = self.dataArray[indexPath.row];
    if ([message isOutgoing]) {
        cell.textLabel.text = message.body;
        cell.textLabel.textColor = [UIColor grayColor];
    } else {
        cell.textLabel.text = message.body;
    }
    return cell;
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    [self reloadMessage];
}

- (void)addBarButton{
    XMPPMessage *message = [[XMPPMessage alloc] initWithType:@"chat" to:self.myJid];
    [[XMPPManager shareXMPPManager].XMPPStream sendElement:message];
    [message addBody:@"呵呵"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
