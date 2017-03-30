//
//  LoginViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/31.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPassportViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong) UITextField *mobileField;
@property (nonatomic,strong) UITextField *passworldField;
@property (nonatomic,strong) UIButton    *btn_login;
@property (nonatomic,strong) UIButton    *btn_forgetPass;
@property (nonatomic,strong) RegisterViewController *controller_regist;
@property (nonatomic,strong) ForgetPassportViewController *controller_forget;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setRightItem];
    [self loadMainView];
}

- (void)setRightItem{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, 0.0f, 26.0f, 20.0f);
    [leftButton setTitle:@"注册" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:0.949 green:0.353 blue:0.157 alpha:1.000] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [leftButton addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = leftButtonItem;
}

-(void)loadMainView{
    
    UIView  *mobile = [UIView newAutoLayoutView];
    [self.view addSubview:mobile];
    mobile.layer.borderColor = [UIColor colorWithRed:223.0f / 255.0f green:223.0f / 255.0f blue:223.0f / 255.0f alpha:1.0f].CGColor;
    mobile.layer.borderWidth = 0.5;
    [mobile autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [mobile autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [mobile autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [mobile autoSetDimension:ALDimensionHeight toSize:40];
    
    _mobileField = [UITextField newAutoLayoutView];
    [mobile addSubview:_mobileField];
    _mobileField.placeholder = @"手机号";
    _mobileField.font = [UIFont systemFontOfSize:12];
    _mobileField.keyboardType =  UIKeyboardTypeNumberPad;
    _mobileField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [ _mobileField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [ _mobileField  autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [ _mobileField  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [ _mobileField  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    UIView  *mobile1 = [UIView newAutoLayoutView];
    [self.view addSubview:mobile1];
    mobile1.layer.borderColor = [UIColor colorWithRed:223.0f / 255.0f green:223.0f / 255.0f blue:223.0f / 255.0f alpha:1.0f].CGColor;
    mobile1.layer.borderWidth = 0.5;
    [mobile1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mobile withOffset:0];
    [mobile1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [mobile1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [mobile1 autoSetDimension:ALDimensionHeight toSize:40];
    
    _passworldField = [UITextField newAutoLayoutView];
    [mobile1 addSubview: _passworldField];
    _passworldField.secureTextEntry = YES;
    _passworldField.placeholder = @"请输入密码";
    _passworldField.font = [UIFont systemFontOfSize:12];
    _passworldField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_passworldField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_passworldField  autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_passworldField  autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_passworldField  autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    UIButton  *loginBtn = [UIButton newAutoLayoutView];
    [self.view addSubview:loginBtn];
    loginBtn.layer.cornerRadius = 3;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.backgroundColor = [UIColor colorWithRed:0.945 green:0.310 blue:0.110 alpha:1.000];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mobile1 withOffset:20];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton  *registerBtn1 = [UIButton newAutoLayoutView];
    [self.view addSubview:registerBtn1];
    [registerBtn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:10];
    [registerBtn1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [registerBtn1 autoSetDimensionsToSize:CGSizeMake(60, 20)];
    registerBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn1 setTitle:@"忘记密码" forState:UIControlStateNormal];
    [registerBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerBtn1 addTarget:self action:@selector(forgetPassClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)btn_login{
    if (!_btn_login) {
        _btn_login = [UIButton newAutoLayoutView];
        _btn_login.layer.cornerRadius = 8;
        _btn_login.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        [_btn_login setTitle:@"登录" forState:UIControlStateNormal];
        [_btn_login setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btn_login addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_login;
}

- (UIButton *)btn_forgetPass{
    if (!_btn_forgetPass) {
        _btn_forgetPass = [UIButton newAutoLayoutView];
        _btn_forgetPass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btn_forgetPass setBackgroundColor:[UIColor whiteColor]];
        _btn_forgetPass.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn_forgetPass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_btn_forgetPass addTarget:self action:@selector(forgetPassClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_forgetPass;
}

- (void)loginClick:(UIButton *)sender{
    
}

- (void)registClick:(UIButton *)sender{
    _controller_regist=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:_controller_regist animated:YES];
}

- (void)forgetPassClick:(UIButton *)sender{
    _controller_forget=[[ForgetPassportViewController alloc] init];
    [self.navigationController pushViewController:_controller_forget animated:YES];
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
