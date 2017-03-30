//
//  ClientApi.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

//DEVELOPMENT 0表示正式服务器，1表示测试服务器

#if (DEVELOPMENT == 0)
//正式
//#define kBaseURL                        @"http://swagger.xin-group.com"
//#define kBase_Share_URL                 @"http://web.xin-group.com"

#define MAINTITLE @"新闻_Release"

#define kBaseURL                        @"http://211.152.60.227:11080"
#define kBase_Share_URL                 @"http://211.152.60.227:11080/web"
#define kBase_Image_URL                 @""
#define kPostImageBaseURL               @"http://112.124.15.82:10090/imageServer/imageServer/saveMultiFile"
#define kBaseActivityWeiboShareLink     @"http://211.152.60.227:11080/web/acvitity/shareActivityHtm?id="
#define kDetailActivityWebLink          @"http://web.xin-group.com/acvitity/activityCountentHtm?id="

#else

#define MAINTITLE @"新闻_Dev"
#define kBaseURL                        @"http://192.168.50.100:8080"
#define kBase_Share_URL                 @""
#define kBase_Image_URL                 @""
#define kPostImageBaseURL               @"http://112.124.15.82:10090/imageServer/imageServer/saveMultiFile"
#define kBaseActivityWeiboShareLink     @"http://192.168.50.100:8080/web/acvitity/shareActivityHtm?id="
#define kDetailActivityWebLink          @"http://web.xin-group.com/acvitity/activityCountentHtm?id="
#endif

//path
#pragma mark -

#define kAppDelegate    ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define kUser_login                     @"/user/login"      //登录
#define kthirdPartLogin                 @""                 //第三方登录
#define kUser_updatePassWordVerify      @""                 //发送验证码
#define kSendVerifyCode                 @"/sms/sendVerifyCode"                 //发送验证码
#define kRegist                         @"/user/regist"
#define kResetPassword                  @"/user/resetPassword"
#define kappVersion                     [[UIDevice currentDevice] systemVersion]          //当前版本
#define kphoneType                      [[UIDevice currentDevice] model]          //手机型号
#define kappstoreType                     @"appstore"          //渠道

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

