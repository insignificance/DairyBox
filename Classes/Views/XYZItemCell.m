//
//  XYZItemCell.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/29.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZItemCell.h"

@implementation XYZItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.contentV.layer.cornerRadius=5;
    self.contentV.layer.masksToBounds=YES;
    //self.nameLabel.adjustsFontSizeToFitWidth = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
