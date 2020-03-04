//
//  XYZItemStore.h
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XYZItem;

@interface XYZItemStore : NSObject

@property (nonatomic,readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (XYZItem *)createdItem;

- (void)removeItem :(XYZItem *)item;

- (void)moveItemAtIndex :(NSUInteger)fromIndex toIndex :(NSInteger)toIndex;

- (BOOL)saveItem;





@end
