//
//  XYZDiaryPassword.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/3.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZDiaryPassword.h"
@interface XYZDiaryPassword()
@property (nonatomic,) UILabel *lable_title;







@property (nonatomic,) UIView *view_box1;
@property (nonatomic,) UIView *view_box2;
@property (nonatomic,) UIView *view_box3;
@property (nonatomic,) UIView *view_box4;
@property (nonatomic,) UIView *view_box5;
@property (nonatomic,) UIView *view_box6;



@property (nonatomic,) UILabel *lable_point1;
@property (nonatomic,) UILabel *lable_point2;
@property (nonatomic,) UILabel *lable_point3;
@property (nonatomic,) UILabel *lable_point4;
@property (nonatomic,) UILabel *lable_point5;
@property (nonatomic,) UILabel *lable_point6;



@property (nonatomic,strong) NSArray* arrayViewBox;
@property (nonatomic,strong) NSArray* arrayPoint;

@end;



@implementation XYZDiaryPassword



- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
        
    if (self = [super initWithFrame:frame])
    {
        
        
        
        _arrayViewBox = [NSArray new];
        _arrayPoint = [NSArray new];
        ///标题
        _lable_title = [[UILabel alloc]init];
        _lable_title.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
        _lable_title.text = title;
        _lable_title.textAlignment=1;
        _lable_title.textColor = [UIColor grayColor];
        [self addSubview:_lable_title];
        
        
        ///  TF
        _TF = [[UITextField alloc]init];
        _TF.frame = CGRectMake(0, 0, 0, 0);
        _TF.delegate = self;
        _TF.keyboardType=UIKeyboardTypeNumberPad;
        [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_TF];
        
        //_save = [NSString new];
        
        self.view_box1 = [UIView new];
        self.view_box2 = [UIView new];
        self.view_box3 = [UIView new];
        self.view_box4 = [UIView new];
        self.view_box5 = [UIView new];
        self.view_box6 = [UIView new];
        
        
        
        
        self.lable_point1 = [UILabel new];
        self.lable_point2 = [UILabel new];
        self.lable_point3 = [UILabel new];
        self.lable_point4 = [UILabel new];
        self.lable_point5 = [UILabel new];
        self.lable_point6 = [UILabel new];
        
        
        self.arrayViewBox = @[_view_box1,_view_box2,_view_box3,_view_box4,_view_box5,_view_box6];
        
        self.arrayPoint = @[_lable_point1,_lable_point2,_lable_point3,_lable_point4,_lable_point5,_lable_point6];
        
        
        
        for (int i = 1; i<7; i++) {
            
            UIView *view_box = self.arrayViewBox[i-1];
            view_box = [[UIView alloc]initWithFrame:CGRectMake(10*i + boxWidth*(i-1), 60, boxWidth , boxWidth )];
            [view_box.layer setBorderWidth:1.0];
            view_box.layer.borderColor = [[UIColor blackColor ]CGColor];
            
            
            
            [self addSubview:view_box];
            
            
            
            UILabel *label_point = self.arrayPoint[i-1];
            //label_point = [[UILabel alloc]init];
            label_point.frame = CGRectMake(boxWidth/2-4,boxWidth/2-4, 10, 10);
            [label_point.layer setCornerRadius:5];
            [label_point.layer setMasksToBounds:YES];
            label_point.backgroundColor = [UIColor blackColor];
            [view_box addSubview:label_point];
            
            label_point.hidden = YES;
            
            //NSLog(@"%@",label_point);
            
            
        }
        
        
        
 
        
        
        
        
        
        
        
}
    return self;
}

- (void)textFieldDidChange:(id) sender
{
    
    
//    
//    NSArray *Directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *directory = [Directorys firstObject];
//
//    NSLog(@"di%@",directory);
    
    
    UITextField *_field = (UITextField *)sender;
    
    switch (_field.text.length) {
        case 0:
        {
            
            _lable_point1.hidden=YES;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 1:
        {
            
            _lable_point1.hidden=NO;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 2:
        {
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 3:
        {
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=YES;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 4:
        {
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=YES;
            _lable_point6.hidden=YES;
        }
            break;
        case 5:
        {
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=YES;
        }
            break;
        case 6:
        {
            _lable_point1.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            _lable_point5.hidden=NO;
            _lable_point6.hidden=NO;
        }
            break;
            
        default:
            break;
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(XYZDiaryPassword:WithPasswordString:)]) {
        
        if (_field.text.length==6)
        {
            
            
            
            [self.delegate XYZDiaryPassword:self WithPasswordString:_field.text];
            
            
            
            
        }

    }
    
    

}

//限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >=6) {
        return NO;
    }else{
        
        return YES;
    
    }


}





@end
