//
//  XYZCalendarPicker.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/22.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZCalendarCell;
@class XYZCalendarPicker;
@protocol XYZCalendarPickerDelegate <NSObject>

@required

- (void)XYZCalendarPicker:(XYZCalendarPicker *)view WithCell :(XYZCalendarCell *)cell;

@end
@interface XYZCalendarPicker : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSDate *today;
@property (nonatomic,)  XYZCalendarCell *cell;
@property (nonatomic,weak)id <XYZCalendarPickerDelegate> delegate;


@property (nonatomic,copy) void(^calendarBlock)(NSInteger day,NSInteger month,NSInteger year);
@property (nonatomic,copy) void(^calendarBlockPoint)(NSInteger day,NSInteger month,NSInteger year,XYZCalendarCell *cell);






+ (instancetype)showOnView :(UIView *)view;

@end
