//
//  XYZItem.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZItem.h"

@interface XYZItem () <NSCoding>

@property (nonatomic,strong)NSDate *dateCreated;




@end




@implementation XYZItem


//encode
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemTitle forKey:@"itemTitle"];
    [aCoder encodeObject:self.itemText forKey:@"itemText"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeObject:self.thubnail forKey:@"thubnail"];
    
    [aCoder encodeObject:self.yue forKey:@"yue"];
    [aCoder encodeObject:self.ri forKey:@"ri"];
}

//decode
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    if (self = [super init]) {
        self.itemTitle = [aDecoder decodeObjectForKey:@"itemTitle"];
        self.itemText = [aDecoder decodeObjectForKey:@"itemText"];
        self.dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        self.itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        self.thubnail = [aDecoder decodeObjectForKey:@"thubnail"];
        
        self.yue = [aDecoder decodeObjectForKey:@"yue"];
        self.ri = [aDecoder decodeObjectForKey:@"ri"];
    }

    return self;

}



+ (instancetype)Item
{

    return [[self alloc]initWithItemText:@""];
    


}



- (instancetype)initWithItemText:(NSString *)itemText
{
    if (self = [super init]) {
        _itemText = itemText;
        _dateCreated = [[NSDate alloc]init];
        
        NSUUID *uuid = [[NSUUID alloc]init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }

    return self;
}

- (instancetype)init
{
    return [self initWithItemText:@""];

}

- (void)setThubnailFromImage:(UIImage *)image
{

    CGSize origImageSize = image.size;
    
    CGRect newRect = CGRectMake(0, 0, 71, 71);
    
    float ratio = MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    [path addClip];
    
    
    CGRect projectRect;
    projectRect.size.width = ratio *origImageSize.width;
    projectRect.size.height = ratio *origImageSize.height;
    
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2.0;
    
    projectRect.origin.y = (newRect.size.height - projectRect.size.height)/2.0;
    
    
    [image drawInRect:projectRect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.thubnail = smallImage;
    
    UIGraphicsEndImageContext();

}


- (UIImage *)imageIcon{


    UIImage *imageIcon = [UIImage imageNamed:@"icon2"];

    
    CGSize origImageSize = imageIcon.size;
    
    CGRect newRect = CGRectMake(0, 0, 71, 71);
    
    float ratio = MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    [path addClip];
    
    
    CGRect projectRect;
    projectRect.size.width = ratio *origImageSize.width;
    projectRect.size.height = ratio *origImageSize.height;
    
    projectRect.origin.x = (newRect.size.width - projectRect.size.width)/2.0;
    
    projectRect.origin.y = (newRect.size.height - projectRect.size.height)/2.0;
    
    
    [imageIcon drawInRect:projectRect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //self.thubnail = smallImage;
    
    UIGraphicsEndImageContext();
    
    
    return smallImage;
}


    
    

@end
