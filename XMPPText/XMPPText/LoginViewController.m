//
//  LoginViewController.m
//  XMPPText
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface LoginViewController ()<XMPPStreamDelegate>

@property (nonatomic, strong) UITextField *userField;

@property (nonatomic, strong) UITextField *pwdField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[XMPPManager shareXMPPManager].XMPPStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
      [[XMPPManager shareXMPPManager] loginWithUserName:@"userName" passWord:@"passWord"];
    
    [self setupLogin];


}

- (void)setupLogin{
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(10, 40 + 64, 100, 20)];
    userName.backgroundColor = [ UIColor cyanColor];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.text = @"用户名";
    [self.view addSubview:userName];
    
    self.userField = [[UITextField alloc] initWithFrame:CGRectMake(150, 40+ 64, 200, 20)];
    self.userField.placeholder = @"请输入用户名";
    self.userField.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.userField];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70+ 64, 100, 20)];
    pwdLabel.backgroundColor = [ UIColor cyanColor];
    pwdLabel.textAlignment = NSTextAlignmentCenter;
    pwdLabel.text = @"密码";
    [self.view addSubview:pwdLabel];
    
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(150, 70+ 64, 200, 20)];
    self.pwdField.placeholder = @"请输入密码";
    self.pwdField.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pwdField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(50, 110+ 64, 50, 20);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor cyanColor];

    [registerBtn addTarget:self action:@selector(didClickRigster:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(120, 110+ 64, 50, 20);
    loginBtn.backgroundColor = [UIColor cyanColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(didClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)didClickRigster:(UIButton *)btn{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)didClickLogin:(UIButton *)btn{
    [[XMPPManager shareXMPPManager] loginWithUserName:self.userField.text passWord:self.pwdField.text];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [[XMPPManager shareXMPPManager].XMPPStream sendElement:presence];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ViewController *viewVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewVC];
    app.window.rootViewController = nav;
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
