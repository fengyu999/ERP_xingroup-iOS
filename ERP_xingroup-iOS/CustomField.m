//
//  CustomField.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/31.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "CustomField.h"

@implementation CustomField

//占位符缩进offset
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+offset, bounds.origin.y, bounds.size.width, bounds.size.height);
    return inset;
}

//编辑输入符缩进offset
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x +offset, bounds.origin.y, bounds.size.width , bounds.size.height);
    return inset;
}

//控制显示文本的位置 缩进offset
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+offset, bounds.origin.y, bounds.size.width , bounds.size.height);
    return inset;
}

-(void)setOffsetX:(CGFloat)offsetX{
    offset =offsetX;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
