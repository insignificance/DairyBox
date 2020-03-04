//
//  XYZImageStore.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZImageStore.h"
@interface XYZImageStore ()

@property (nonatomic,strong) NSMutableDictionary *dictionary;

@end

@implementation XYZImageStore


+ (instancetype)sharedStore
{

    static XYZImageStore *sharedStore;
    if (sharedStore == nil) {
        sharedStore = [[self alloc]initPrivate];
    }

    return sharedStore;

}

- (instancetype)init
{

    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [XYZImageStore sharedStore]" userInfo:nil];
    return nil;

}
- (instancetype)initPrivate
{

    if (self = [super init]) {
        _dictionary = [[NSMutableDictionary alloc]init];
    }


    return self;


}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{

    self.dictionary[key] = image;
    
    NSString *imagePath = [self imagePathforKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    [data writeToFile:imagePath atomically:YES];

}

- (UIImage *)imageForKey:(NSString *)key
{

    
    
    //尝试先从字典读取图片
    UIImage *image = self.dictionary[key];
    
    if (image == nil) {
        
        NSString *imagePath = [self imagePathforKey:key];
        
        image = [UIImage imageWithContentsOfFile:imagePath];
        
        if (image) {
            //存入缓存
            self.dictionary[key] = image;
            
            NSLog(@"successed!");
            
            
        }
//        else{
//        
//            NSLog(@"can't find %@ ",[self imagePathforKey:key]);
//            
//        
//        }
        
        
    }
    
    return image;

}

- (void)deleteImageForKey:(NSString *)key
{

    if (key == nil) {
        return;
    }

    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathforKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    
    
}




- (NSString *)imagePathforKey: (NSString *)key
{

    NSArray *Directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [Directories lastObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];




}
@end
