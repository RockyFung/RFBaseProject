//
//  BaseTableViewCell.m
//  XJAfenshi
//
//  Created by 冯剑 on 2018/11/28.
//  Copyright © 2018年 XJA. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeParameter];
        [self createUI];
    }
    return self;
}

- (void)initializeParameter{
    self.backgroundColor = Color_clear;
    self.contentView.backgroundColor = Color_clear;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)createUI{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
