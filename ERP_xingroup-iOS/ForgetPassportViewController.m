//
//  ForgetPassportViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/31.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "ForgetPassportViewController.h"
#import "CustomField.h"

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kMainLinegrayColor  [UIColor colorWithRed:223.0f / 255.0f green:223.0f / 255.0f blue:223.0f / 255.0f alpha:1.0f]

@interface ForgetPassportViewController ()

@property (nonatomic ,strong) CustomField *textFieldMobile;
@property (nonatomic ,strong) CustomField *textFieldVerifCode;
@property (nonatomic ,strong) CustomField *textFieldPassNew;
@property (nonatomic ,strong) UIScrollView *scrollview;
@property (nonatomic ,strong) UIButton *btn_virify;
@property (nonatomic ,strong) UIButton *btn_login;

@end

@implementation ForgetPassportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"找回密码";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setContantLayouts];
}

#pragma mark -
#pragma mark UI
- (void)setContantLayouts{
    
    [self.view addSubview:self.scrollview];
    [_scrollview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_scrollview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_scrollview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_scrollview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    UIImageView *icon_1 = [UIImageView newAutoLayoutView];
    UIImageView *icon_2 = [UIImageView newAutoLayoutView];
    UIImageView *icon_3 = [UIImageView newAutoLayoutView];
    
    [self.scrollview addSubview:icon_1];
    [self.scrollview addSubview:icon_2];
    [self.scrollview addSubview:icon_3];

    icon_1.image = [UIImage imageNamed:@"shouji"];
    icon_2.image = [UIImage imageNamed:@"yanzhengma"];
    icon_3.image = [UIImage imageNamed:@"mima"];
    
    [self.scrollview addSubview:self.textFieldMobile];
    [self.scrollview addSubview:self.textFieldVerifCode];
    [self.scrollview addSubview:self.textFieldPassNew];
    [self.scrollview addSubview:self.btn_virify];
    [self.scrollview addSubview:self.btn_login];
    
    [icon_1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:19];
    [icon_1 autoSetDimensionsToSize:CGSizeMake(12, 15)];
    [_textFieldMobile autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_textFieldMobile autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldMobile autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[icon_1,_btn_virify,_textFieldMobile] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_textFieldVerifCode autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [icon_2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:19];
    [icon_2 autoSetDimensionsToSize:CGSizeMake(12, 15)];
    [_textFieldVerifCode autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldVerifCode autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[icon_2,_textFieldVerifCode] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_textFieldPassNew autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50+40];
    [icon_3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:19];
    [icon_3 autoSetDimensionsToSize:CGSizeMake(12, 15)];
    [_textFieldPassNew autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldPassNew autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[icon_3,_textFieldPassNew] autoAlignViewsToAxis:ALAxisHorizontal];
    
    _textFieldPassNew.secureTextEntry = YES;
    
    [_btn_virify autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kScreen_width- 92];
    [_btn_virify autoSetDimensionsToSize:CGSizeMake(75, 28)];
    
    [_btn_login autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
    [_btn_login autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [_btn_login autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 35)];
    
    _textFieldMobile.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldVerifCode.keyboardType = UIKeyboardTypeNumberPad;
}

- (CustomField *)textFieldMobile{
    if (!_textFieldMobile) {
        _textFieldMobile = [CustomField newAutoLayoutView];
        _textFieldMobile.textAlignment = NSTextAlignmentLeft;
        _textFieldMobile.borderStyle = UITextBorderStyleNone;
        _textFieldMobile.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldMobile.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldMobile.placeholder = @"请填写手机号码";
        _textFieldMobile.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldMobile.layer.borderWidth = 0.5;
        [_textFieldMobile setOffsetX:10];
    }
    return _textFieldMobile;
}

- (CustomField *)textFieldVerifCode{
    if (!_textFieldVerifCode) {
        _textFieldVerifCode = [CustomField newAutoLayoutView];
        _textFieldVerifCode.textAlignment = NSTextAlignmentLeft;
        _textFieldVerifCode.borderStyle = UITextBorderStyleNone;
        _textFieldVerifCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldVerifCode.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldVerifCode.placeholder = @"请输入短信验证码";
        _textFieldVerifCode.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldVerifCode.layer.borderWidth = 0.5;
        [_textFieldVerifCode setOffsetX:10];
    }
    return _textFieldVerifCode;
}

- (CustomField *)textFieldPassNew{
    if (!_textFieldPassNew) {
        _textFieldPassNew = [CustomField newAutoLayoutView];
        _textFieldPassNew.textAlignment = NSTextAlignmentLeft;
        _textFieldPassNew.borderStyle = UITextBorderStyleNone;
        _textFieldPassNew.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldPassNew.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldPassNew.placeholder = @"请输入6-20位新密码";
        _textFieldPassNew.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldPassNew.layer.borderWidth = 0.5;
        [ _textFieldPassNew setOffsetX:10];
    }
    return _textFieldPassNew;
}

- (UIButton *)btn_login{
    if (!_btn_login) {
        _btn_login = [UIButton newAutoLayoutView];
        _btn_login.layer.cornerRadius = 8;
        _btn_login.backgroundColor = [UIColor colorWithRed:0.945 green:0.310 blue:0.110 alpha:1.000];
        _btn_login.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        [_btn_login setTitle:@"设置并登录" forState:UIControlStateNormal];
        [_btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_login addTarget:self action:@selector(sendPass) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_login;
}

- (UIButton *)btn_virify{
    if (!_btn_virify) {
        
        _btn_virify = [UIButton newAutoLayoutView];
        _btn_virify.backgroundColor = [UIColor colorWithRed:0.945 green:0.310 blue:0.110 alpha:1.000];
        [_btn_virify setTitle:@"获取验证码" forState:UIControlStateNormal];
        _btn_virify.userInteractionEnabled = YES;
        _btn_virify.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btn_virify addTarget:self action:@selector(virifyEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_virify;
}

- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [UIScrollView newAutoLayoutView];
        _scrollview.backgroundColor = [UIColor whiteColor];
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
    }
    return _scrollview;
}

- (void)sendPass{

}

- (void)virifyEvent:(UIButton *)sender{

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
