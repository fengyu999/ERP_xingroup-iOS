//
//  TopViewTableViewCell.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/30.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "TopViewTableViewCell.h"

@implementation TopViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _smalltitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width-10, CGFLOAT_MAX)];
        _smalltitleLabel.textColor=[UIColor blackColor];
        _smalltitleLabel.textAlignment=NSTextAlignmentLeft;
        _smalltitleLabel.font=[UIFont systemFontOfSize:15.0f];
        _smalltitleLabel.userInteractionEnabled=YES;
        _smalltitleLabel.numberOfLines=0;
        [self addSubview:_smalltitleLabel];
    }
    return self;
}

- (void)loadEntity:(NSString *)entity{
    
    _smalltitleLabel.text = entity;
    NSDictionary *attributes = @{NSFontAttributeName:_smalltitleLabel.font};
    CGRect rect = [entity boundingRectWithSize:CGSizeMake(self.frame.size.width-10, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    _smalltitleLabel.frame=CGRectMake(10, 10, self.frame.size.width-10, rect.size.height);

}

// If you are not using auto layout, override this method, enable it by setting
// "fd_enforceFrameLayout" to YES.
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [_smalltitleLabel sizeThatFits:size].height+6;
    totalHeight += 20; // margins
    return CGSizeMake(size.width, totalHeight);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
