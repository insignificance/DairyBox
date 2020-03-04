//
//  XYZItemCell.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/29.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *UIImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ItemTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *yueLab;
@property (weak, nonatomic) IBOutlet UILabel *riLab;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end
