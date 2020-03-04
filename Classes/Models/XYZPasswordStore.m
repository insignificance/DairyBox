//
//  XYZPasswordStore.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/10.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZPasswordStore.h"
@interface XYZPasswordStore ()

@property (nonatomic,copy) NSString *password;

@end



@implementation XYZPasswordStore

@synthesize password = _password;


+ (instancetype)sharedStore
{
    static XYZPasswordStore *sharedStore;
    if (sharedStore == nil) {
        sharedStore = [[self alloc]initPrivate];
    }
        
    return sharedStore;
}

- (instancetype)init
{

    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [XYZPasswordStore sharedStore]" userInfo:nil];
    
    return nil;


}

- (instancetype)initPrivate
{
    if (self = [super init]) {
        _password = [[NSString alloc]init];

    }
   
    return self;

}

- (void)setPassword:(NSString *)password
{
    _password = password;
    
    NSString *passwordPath = [self passWordPath];
    //NSString --> NSData
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    [data writeToFile:passwordPath atomically:YES];
    
    NSLog(@"存入成功");

}

- (NSString *)password
{
    
    NSString *passwordPath = [self passWordPath];
    //获取路径文件数据
    NSData *data = [NSData dataWithContentsOfFile:passwordPath];
    //将数据转换成NSString对象
    _password = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return _password;
    

}


- (NSString *)passWordPath
{
    NSArray *Directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directory = [Directorys firstObject];
    
    
    
    
    
    return [directory  stringByAppendingPathComponent:@"password.file"];




}



@end
