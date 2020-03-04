//
//  XYZDetailViewController.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  XYZItem;
@interface XYZDetailViewController : UIViewController

@property (nonatomic,strong) XYZItem *item;
@property (nonatomic, copy)NSString * yue;
@property (nonatomic, copy)NSString * ri;

@end
