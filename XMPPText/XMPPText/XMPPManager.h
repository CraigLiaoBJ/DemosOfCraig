//
//  XMPPManager.h
//  XMPPText
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface XMPPManager : NSObject

//XMPPMANAGER的单例方法
+ (instancetype)shareXMPPManager;

//XMPP专门跟服务器连接的通道
@property (nonatomic, strong) XMPPStream *XMPPStream;

//XMPP好友类
@property (nonatomic, strong) XMPPRoster *XMPPRoster;

//信息缓存类
@property (nonatomic, strong) XMPPMessageArchiving *messageArchiving;

@property (nonatomic, strong) NSManagedObjectContext *context;

//登录方法
- (void)loginWithUserName:(NSString *)userName passWord:(NSString *)passWord;

//注册方法
- (void)registerWithUserName:(NSString *)userName passWord:(NSString *)passWord;


//向服务器发起连接
- (void)connectToServer;
//跟服务器断开连接
- (void)disConnectToServer;

- (void)connectToServerWithUserName:(NSString *)userName;


@end
