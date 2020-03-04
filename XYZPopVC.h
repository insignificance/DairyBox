//
//  XYZPopVC.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/6/5.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZPopVC : UINavigationController
@property (nonatomic,strong) UITableView *table;

@property (nonatomic,copy) void(^didSelectCell)(NSIndexPath *indexPath);

@end
