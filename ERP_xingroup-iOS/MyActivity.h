//
//  MyActivity.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/5/6.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActivity : UIActivity

//title是当前类型，shareImage是分享图标，URL是要分享的地址，getShareArray保存用户要分享的内容
@property (nonatomic,strong) UIImage *shareImage;
@property (nonatomic,copy)NSString *URL;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSArray *getShareArray;
-(instancetype)initWithImage:(UIImage *)shareImage atURL:(NSString *)URL atTitle:(NSString *)title atShareContentArray:(NSArray *)shareContentArray;

@end
