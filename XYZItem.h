//
//  XYZItem.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XYZItem : NSObject 

+ (instancetype)Item;

- (instancetype)initWithItemText :(NSString *)itemText;


@property(nonatomic,copy)NSString *itemTitle;

@property (nonatomic,copy) NSString *itemText;

@property (nonatomic,strong,readonly) NSDate *dateCreated;

@property (nonatomic,copy) NSString *itemKey;

@property (nonatomic,strong) UIImage *thubnail;

@property (nonatomic,copy) NSString *yue;
@property (nonatomic,copy) NSString *ri;


- (void)setThubnailFromImage:(UIImage *)image;

- (UIImage *)imageIcon;


@end
