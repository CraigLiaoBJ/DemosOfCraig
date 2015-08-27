//
//  RegisterViewController.m
//  XMPPText
//
//  Created by Craig Liao on 15/8/17.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (nonatomic, strong) UITextField *userField;

@property (nonatomic, strong) UITextField *pwdField;

@end

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupRegister];
}

- (void)setupRegister{
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
    
}

- (void)didClickRigster:(UIButton *)btn{
    [[XMPPManager shareXMPPManager] registerWithUserName:self.userField.text passWord:self.pwdField.text];
}

@end
