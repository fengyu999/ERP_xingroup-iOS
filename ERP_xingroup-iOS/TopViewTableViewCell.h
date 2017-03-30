//
//  TopViewTableViewCell.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/30.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *smalltitleLabel;
- (void)loadEntity:(NSString *)entity;

@end
