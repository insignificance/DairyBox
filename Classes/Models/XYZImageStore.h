//
//  XYZImageStore.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYZImageStore : NSObject


+(instancetype)sharedStore;

- (void)setImage :(UIImage *)image forKey :(NSString *)key;

- (UIImage *)imageForKey :(NSString *)key;

- (void)deleteImageForKey :(NSString *)key;
@end
