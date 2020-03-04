//
//  XYZCalendarCell.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/22.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZCalendarCell.h"
#import "UIColor+XYColor.h"
@implementation XYZCalendarCell
- (UILabel *)dateLabel
{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc]initWithFrame:self.bounds];
        
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        
        
        
       
      
        
//        _dateLabel.backgroundColor = [UIColor grayColor];
        
        //[_dateLabel sizeToFit];
        //self.backgroundColor = [UIColor clearColor];
        [self addSubview:_dateLabel];
        
        
        
        
    
    }








    return _dateLabel;

}

- (void)prepareForReuse
{

    [super prepareForReuse];
    
    _label_point.hidden = YES;
    

}





@end
