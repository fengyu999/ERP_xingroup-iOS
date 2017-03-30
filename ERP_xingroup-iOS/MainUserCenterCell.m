//
//  MainUserCenterCell.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/29.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "MainUserCenterCell.h"

@implementation MainUserCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
