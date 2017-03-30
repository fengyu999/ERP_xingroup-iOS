//
//  RegisterViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/31.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "RegisterViewController.h"
#import "CustomField.h"

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kMainLinegrayColor  [UIColor colorWithRed:223.0f / 255.0f green:223.0f / 255.0f blue:223.0f / 255.0f alpha:1.0f]
#define kOffsetX 10

@interface RegisterViewController ()

@property (nonatomic ,strong) UIScrollView *scrollview;

@property (nonatomic ,strong) CustomField *textFieldMobile;
@property (nonatomic ,strong) CustomField *textFieldVerifCode;
@property (nonatomic ,strong) CustomField *textFieldNickName;
@property (nonatomic ,strong) CustomField *textFieldPass;
@property (nonatomic ,strong) CustomField *textFieldInvitation;

@property (nonatomic ,strong) UIButton *btn_virify;
@property (nonatomic ,strong) UIButton *btn_regist;
@property (nonatomic ,strong) UIButton *btn_agreement;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"注册";
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
    
    UIImageView *image_bk_1 = [UIImageView newAutoLayoutView];
    UIImageView *image_bk_2 = [UIImageView newAutoLayoutView];
    UIImageView *image_bk_3 = [UIImageView newAutoLayoutView];
    UIImageView *image_bk_4 = [UIImageView newAutoLayoutView];
    UIImageView *image_bk_5 = [UIImageView newAutoLayoutView];
    
    [self.scrollview addSubview:image_bk_1];
    [self.scrollview addSubview:image_bk_2];
    [self.scrollview addSubview:image_bk_3];
    [self.scrollview addSubview:image_bk_4];
    [self.scrollview addSubview:image_bk_5];
    
    [self.scrollview addSubview:self.textFieldMobile];
    [self.scrollview addSubview:self.textFieldVerifCode];
    [self.scrollview addSubview:self.textFieldNickName];
    [self.scrollview addSubview:self.textFieldPass];
    [self.scrollview addSubview:self.textFieldInvitation];
    
    [self.scrollview addSubview:self.btn_virify];
    [self.scrollview addSubview:self.btn_regist];
    [self.scrollview addSubview:self.btn_agreement];
    
    [image_bk_1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [image_bk_1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [image_bk_1 autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 40)];
    
    [image_bk_2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    [image_bk_2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [image_bk_2 autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 40)];
    
    [image_bk_3 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:90];
    [image_bk_3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [image_bk_3 autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 40)];
    
    [image_bk_4 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:130];
    [image_bk_4 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [image_bk_4 autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 40)];
    
    [image_bk_5 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:170];
    [image_bk_5 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [image_bk_5 autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 40)];
    
    [_textFieldMobile autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldMobile autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[image_bk_1,_btn_virify,_textFieldMobile] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_textFieldVerifCode autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldVerifCode autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[image_bk_2,_textFieldVerifCode] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_textFieldNickName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldNickName autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[image_bk_3,_textFieldNickName] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_textFieldPass autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldPass autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[image_bk_4,_textFieldPass] autoAlignViewsToAxis:ALAxisHorizontal];
    _textFieldPass.secureTextEntry = YES;
    
    [_textFieldInvitation autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:9];
    [_textFieldInvitation autoSetDimensionsToSize:CGSizeMake(kScreen_width - 18, 40)];
    [@[image_bk_5,_textFieldInvitation] autoAlignViewsToAxis:ALAxisHorizontal];
    
    [_btn_virify autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kScreen_width- 92];
    [_btn_virify autoSetDimensionsToSize:CGSizeMake(75, 28)];
    
    [_btn_regist autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:226];
    [_btn_regist autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [_btn_regist autoSetDimensionsToSize:CGSizeMake(kScreen_width- 16, 35)];
    
    NSArray *array = @[_textFieldVerifCode,_textFieldInvitation,_textFieldMobile,_textFieldNickName,_textFieldPass];
    for(UITextField *fild in array){
        fild.font = [UIFont systemFontOfSize:12];
        fild.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    }
    
    [_btn_agreement autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_btn_regist withOffset:10];
    [_btn_agreement autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_btn_agreement autoSetDimensionsToSize:CGSizeMake(140, 20)];
    _btn_agreement.titleLabel.font = [UIFont systemFontOfSize:12];
    [_btn_agreement autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_scrollview withOffset:0];
}

- (CustomField *)textFieldMobile{
    if (!_textFieldMobile) {
        _textFieldMobile = [CustomField newAutoLayoutView];
        _textFieldMobile.textAlignment = NSTextAlignmentLeft;
        _textFieldMobile.borderStyle = UITextBorderStyleNone;
        _textFieldMobile.clearButtonMode = UITextFieldViewModeNever;
        _textFieldMobile.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldMobile.placeholder = @"请填写手机号";
        _textFieldMobile.keyboardType =  UIKeyboardTypeNumberPad;
        _textFieldMobile.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldMobile.layer.borderWidth = 0.5;
        [_textFieldMobile setOffsetX:kOffsetX];
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
        _textFieldVerifCode.placeholder = @"请填写验证码";
        _textFieldVerifCode.keyboardType =  UIKeyboardTypeNumberPad;
        _textFieldVerifCode.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldVerifCode.layer.borderWidth = 0.5;
        [_textFieldVerifCode setOffsetX:kOffsetX];
    }
    return _textFieldVerifCode;
}

- (CustomField *)textFieldNickName{
    if (!_textFieldNickName) {
        _textFieldNickName = [CustomField newAutoLayoutView];
        _textFieldNickName.textAlignment = NSTextAlignmentLeft;
        _textFieldNickName.borderStyle = UITextBorderStyleNone;
        _textFieldNickName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldNickName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldNickName.placeholder = @"2-8位昵称，报名时用到哦";
        _textFieldNickName.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldNickName.layer.borderWidth = 0.5;
        [_textFieldNickName setOffsetX:kOffsetX];
    }
    return _textFieldNickName;
}

- (CustomField *)textFieldPass{
    if (!_textFieldPass) {
        _textFieldPass = [CustomField newAutoLayoutView];
        _textFieldPass.textAlignment = NSTextAlignmentLeft;
        _textFieldPass.borderStyle = UITextBorderStyleNone;
        _textFieldPass.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldPass.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldPass.placeholder = @"请填写6-20位密码";
        _textFieldPass.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldPass.layer.borderWidth = 0.5;
        [_textFieldPass setOffsetX:kOffsetX];
    }
    return _textFieldPass;
}

- (CustomField *)textFieldInvitation{
    if (!_textFieldInvitation) {
        _textFieldInvitation = [CustomField newAutoLayoutView];
        _textFieldInvitation.textAlignment = NSTextAlignmentLeft;
        _textFieldInvitation.borderStyle = UITextBorderStyleNone;
        _textFieldInvitation.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldInvitation.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        _textFieldInvitation.placeholder = @"输入邀请码（非必填）";
        _textFieldInvitation.layer.borderColor = kMainLinegrayColor.CGColor;
        _textFieldInvitation.keyboardType =  UIKeyboardTypeNumberPad;
        _textFieldInvitation.layer.borderWidth = 0.5;
        [_textFieldInvitation setOffsetX:kOffsetX];
    }
    return _textFieldInvitation;
}

- (UIButton *)btn_regist{
    if (!_btn_regist) {
        _btn_regist = [UIButton newAutoLayoutView];
        _btn_regist.layer.cornerRadius = 8;
        _btn_regist.backgroundColor = [UIColor colorWithRed:0.945 green:0.310 blue:0.110 alpha:1.000];
        _btn_regist.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        [_btn_regist setTitle:@"同意协议并注册" forState:UIControlStateNormal];
        [_btn_regist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn_regist addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_regist;
}

- (UIButton *)btn_virify{
    if (!_btn_virify) {
        
        _btn_virify = [UIButton newAutoLayoutView];
        _btn_virify.backgroundColor = [UIColor colorWithRed:0.945 green:0.310 blue:0.110 alpha:1.000];
        [_btn_virify setTitle:@"获取验证码" forState:UIControlStateNormal];
        _btn_virify.userInteractionEnabled = YES;
        _btn_virify.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn_virify.layer.cornerRadius = 3;
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

- (UIButton *)btn_agreement{
    if (!_btn_agreement) {
        _btn_agreement = [UIButton newAutoLayoutView];
        _btn_agreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btn_agreement setBackgroundColor:[UIColor clearColor]];
        [_btn_agreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_agreement setTitle:@"服务协议>>"  forState:UIControlStateNormal];
        [_btn_agreement addTarget:self action:@selector(agreementClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_agreement;
}

- (void)registerClick:(UIButton *)sender{

    
}

- (void)virifyEvent:(UIButton *)sender{

    
}

- (void)agreementClick:(UIButton *)sender{

    
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
