//
//  UIColor+XYColor.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/22.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYColor)
+ (UIColor *)colorWithRed: (NSInteger)red green :(NSInteger)green blue :(NSInteger)blue;


/**
 *  16进制转UIColor
 *   @param color @"#FFFFFF",@"OXFFFFFF",@"FFFFFF"
 *
 *   @return UIColor
 */

+ (UIColor *)colorWithHexString :(NSString *)color;



@end
