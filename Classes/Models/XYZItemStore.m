//
//  XYZItemStore.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZItemStore.h"
#import "XYZItem.h"
#import "XYZImageStore.h"
@interface XYZItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end


@implementation XYZItemStore

+ (instancetype)sharedStore
{
    static XYZItemStore *sharedStore;
    
    if (sharedStore == nil) {
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;

}

- (instancetype)init
{

    @throw  [NSException exceptionWithName:@"Singleton" reason:@"Use + [XYZItemStore + sharedStore]" userInfo:nil];
    return nil;


}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        
        
        
        NSString *Path = [self itemArchivePath];
        
//decode With file
        
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:Path];
        
        
       
        if (_privateItems == nil ) {
            
            _privateItems = [[NSMutableArray alloc]init];
            
        }
        
        
    }

    return self;


}

- (NSArray *)allItems
{
    
    return [self.privateItems copy];

}


- (XYZItem *)createdItem
{

    XYZItem *item = [XYZItem Item];
    
    [self.privateItems addObject:item];
    
    return item;




}

- (void)removeItem:(XYZItem *)item
{

    NSString *key = item.itemKey;
    
    if (key) {
        [[XYZImageStore sharedStore]deleteImageForKey:key];
    }
//根据地址删除对象
    [self.privateItems removeObjectIdenticalTo:item];

}


- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSInteger)toIndex
{

    if (fromIndex == toIndex) {
        return;
    }
    
    XYZItem *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];


}


//获取路径（最终保存文件路径）
- (NSString *)itemArchivePath
{

    NSArray *Directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [Directories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"Item.archive"];

}

//保存，并确认是否成功

- (BOOL)saveItem
{

    NSString *itemPath = [self itemArchivePath];
    
//将编码对象存入制定路径（文件）
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:itemPath];
    


}


@end
