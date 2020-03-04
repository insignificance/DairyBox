//
//  XYZDiaryPassword.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/3.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HIGHT ([UIScreen mianScreen].bounds.size.width)
#define boxWidth (SCREEN_WIDTH - 70)/6


@class XYZDiaryPassword;

@protocol XYZDiaryPasswordDelegate <NSObject>

@required
- (void)XYZDiaryPassword: (XYZDiaryPassword *)view WithPasswordString: (NSString *)Password;

@end
@interface XYZDiaryPassword : UIView <UITextFieldDelegate>




@property (nonatomic,) UITextField *TF;


@property (nonatomic,assign)id <XYZDiaryPasswordDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;






@end
