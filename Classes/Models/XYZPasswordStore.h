//
//  XYZPasswordStore.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/10.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZPasswordStore : NSObject

+ (instancetype)sharedStore;

- (void)setPassword:(NSString *)password;
- (NSString *)password;

@end
