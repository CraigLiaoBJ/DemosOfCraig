//
//  XMPPManager.m
//  XMPPText
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "XMPPManager.h"

typedef NS_ENUM(NSInteger, connectToServerType) {
    connectToServerTypeLogin,
    connectToServerTypeRegister,
};

@interface XMPPManager ()<XMPPStreamDelegate, XMPPRosterDelegate, UIAlertViewDelegate>

@property (nonatomic) connectToServerType connectToServerType;

@property (nonatomic, copy) NSString *loginPassWord;
@property (nonatomic, copy) NSString *registerPassWord;

@property (nonatomic, strong) XMPPJID *myJid;


@end

static  XMPPManager *manager = nil;

@implementation XMPPManager

+ (instancetype)shareXMPPManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XMPPManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.XMPPStream = [[XMPPStream alloc] init];
        //连接主机地址
        self.XMPPStream.hostName = @"catkingcraig.local";
        //设置端口号，默认的是5222
        self.XMPPStream.hostPort = 5222;
        
        [self.XMPPStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //XMPPRoster的助手类，主要作用是从CoreData里面读取用户的数据
        XMPPRosterCoreDataStorage *roster = [XMPPRosterCoreDataStorage sharedInstance];
        
        self.XMPPRoster = [[XMPPRoster alloc] initWithRosterStorage:roster dispatchQueue:dispatch_get_main_queue()];
       
        //将用户类放到通道里
        [self.XMPPRoster activate:self.XMPPStream];
        
        [self.XMPPRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        XMPPMessageArchivingCoreDataStorage *coreData = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        self.messageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:coreData dispatchQueue:dispatch_get_main_queue()];
        [self.messageArchiving  activate:self.XMPPStream];
        self.context = coreData.mainThreadManagedObjectContext;
    }
    return self;
}

//向服务器发起连接
- (void)connectToServer{
    //判断通道是否在连接上 如果连接了 则断开
    if ([self.XMPPStream isConnected]) {
        [self disConnectToServer];
    }
    
    NSError *error = nil;
    //通道类 去链接服务器， 如果30秒内没有连接成功，则抛出error.
    [self.XMPPStream connectWithTimeout:30.0f error:&error];
    if (error != nil) {
        NSLog(@"连接失败");
    }
}

//跟服务器断开连接
- (void)disConnectToServer{
    //XMPPPresence 是通道向服务器发送消息的类
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    //XMPPSTREAM 通过sendElement 方法 发送消息
    [self.XMPPStream sendElement:presence];
    //在发送消息之后， 需要主动断开连接
    [self.XMPPStream disconnect];
}

- (void)connectToServerWithUserName:(NSString *)userName{
    //用户的信息类 存储的hi 用户名、用户来源等用户信息
    NSLog(@"连接成功");
    XMPPJID *jid = [XMPPJID jidWithUser:userName domain:@"catkingcraig.local" resource:@"iOS"];
    self.XMPPStream.myJID = jid;
    
    [self connectToServer];
    
}
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord{
    NSLog(@"登录成功");
    self.connectToServerType = connectToServerTypeLogin;
    self.loginPassWord = passWord;
    [self connectToServerWithUserName:userName];

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:userName forKey:@"userName"];
    [user setObject:passWord forKey:@"passWord"];
    [user setBool:YES forKey:@"isLogin"];
}

- (void)registerWithUserName:(NSString *)userName passWord:(NSString *)passWord{
    self.connectToServerType = connectToServerTypeRegister;
    self.registerPassWord = passWord;
    [self connectToServerWithUserName:userName];
}


#pragma mark -- 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
}

#pragma mark -- 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"注册失败%@", error);
}

#pragma mark -- XMPPStream的代理
#pragma mark -- 与主机连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    switch (self.connectToServerType) {
        case connectToServerTypeLogin:
            //登录的时候， 通知密码进行身份验证
            [sender authenticateWithPassword:self.loginPassWord error:nil];
            break;
        case connectToServerTypeRegister:
            //注册的时候，把密码发给服务器
            [sender registerWithPassword:self.registerPassWord error:nil];
            break;
        default:
            break;
    }
}

#pragma mark -- 连接失败
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    NSLog(@"连接超时");
}

#pragma mark -- 授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.XMPPStream sendElement:presence];
}

#pragma mark -- 授权失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    
}


- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    
    NSLog(@"收到好友请求");

    self.myJid = presence.from;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到好友请求" message:presence.from.user delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"接受", nil];
    [alert show];

//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alert dismissWithClickedButtonIndex:0 animated:YES];
//
//    });
//    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.XMPPRoster revokePresencePermissionFromUser:self.myJid];
            break;
        case 1:
            [self.XMPPRoster acceptPresenceSubscriptionRequestFrom:self.myJid andAddToRoster:YES];
            break;

        default:
            break;
    }
}

@end
