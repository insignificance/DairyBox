//
//  XYZCalendarPicker.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/22.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZCalendarPicker.h"
#import "UIColor+XYColor.h"
#import "XYZCalendarCell.h"




NSString *const XYZCalendarCellIdentifier = @"Cell";



@interface XYZCalendarPicker ()

@property (nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic,weak) IBOutlet UILabel *monthLabel;
@property (nonatomic,weak) IBOutlet UIButton *previousButton;
@property (nonatomic,weak) IBOutlet UIButton *nextButton;
@property (nonatomic,strong) NSArray *weekDayArray;




@property (nonatomic,strong) UIView *mask;



@end

@implementation XYZCalendarPicker


- (void)drawRect:(CGRect)rect {
    
    [self addTap];
    [self addSwipe];
    [self show];
    
    
 }

- (void)awakeFromNib
{

    
    [super awakeFromNib];
     
    [_collectionView registerClass:[XYZCalendarCell class] forCellWithReuseIdentifier:XYZCalendarCellIdentifier];
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    

}

- (void)customInterface
{
    //CGFloat itemWidth = self.collectionView.frame.size.width/7;
    
    //CGFloat itemHeight = self.collectionView.frame.size.height/7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //google一下
    //layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    
    //layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    //layout.minimumLineSpacing = 0 ;//行距
    //layout.minimumInteritemSpacing = 0 ;//项目间距
    
    [self.collectionView setCollectionViewLayout:layout animated:YES];

}

- (void)setDate: (NSDate *)date
{
    _date = date;
    
    [self.monthLabel setText:[NSString stringWithFormat:@"%.2ld - %ld",(long)[self month:date],(long)[self year:date]]];
    
    [self.collectionView reloadData];
    





}

#pragma mark ==== date

- (NSInteger)day :(NSDate *)date
{
    
    NSDateComponents *componnents = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    
    return [componnents day];


}

- (NSInteger)month :(NSDate *)date
{
   
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    
    
    return [components month];


}

- (NSInteger)year :(NSDate *)date
{
    
    
    
    NSDateComponents *componments = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date
                                     ];
    
    return [componments year];

}

- (NSInteger)firstWeekInThisMonth :(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置规定标准中的每周第一天星期几
    
    
    [calendar setFirstWeekday:1];//7123456
    
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    //初始化当月
    
    [components setDay:1];
    
    //转
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:components];
    
    
    //初始化第一周序列号
    
    NSUInteger firstWeek = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeek - 1;
    

}

//ThisMonth
- (NSInteger)totalDaysInThisMonth :(NSDate *)date
{

    NSRange totaldaysInThisMonth = [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];

    return totaldaysInThisMonth.length;



}
//Month
- (NSInteger)totalDaysInMonth :(NSDate *)date
{
    NSRange daysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInMonth.length;

}


- (NSDate *)lastMonth: (NSDate *)date
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    
    // = -1;
    dateComponents.month = -1;

    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;

}

- (NSDate *)nextMonth: (NSDate *)date
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    // = +1
    dateComponents.month = +1;
    
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;


}
#pragma mark === collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;


}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    }else{
        
        return 42;
        
    }


}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYZCalendarCellIdentifier forIndexPath:indexPath];
    
    
    
 
    //NSInteger firstWeek = [self firstWeekInThisMonth:self.date];

    
//
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#607D8B"]];
        
    }else{
        
        NSInteger daysInThisMonth = [self totalDaysInMonth:self.date];
        
        //第一周
        
        NSInteger firstWeek = [self firstWeekInThisMonth:self.date];
        
        NSInteger day = 0;
        
        NSInteger i = indexPath.row;
    
 //
        

        
//
        
       
        
        day = i - firstWeek + 1;
        
        NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
        
        
        if (self.calendarBlockPoint) {
            if (self.calendarBlockPoint) {
                self.calendarBlockPoint(day,[components month],[components year],cell);
            }
            
            
            
        }
        

        
 //
        if (i < firstWeek) {
            [cell.dateLabel setText:@""];
          
        }else if (i > firstWeek + daysInThisMonth - 1){
        
            [cell.dateLabel setText:@""];
        
        }else{
            day = i - firstWeek +1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#26A69A"]];
            
            
            
            if ([self.today isEqualToDate:self.date]) {
                if (day == [self day:self.date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#F43362"]];
                    
                    
                    
                    
                }else if (day > [self day:self.date]){
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#B2DFDB"]];
                
                }//The left operand is smaller than the right operand.
            }else if ([self.today compare:self.date] == NSOrderedAscending){
            
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#CBCBCB"]];
            
            }
            
        }
        
    
    }
    
    
    
    
    if ([self.delegate respondsToSelector:@selector(XYZCalendarPicker:WithCell:)]) {
        
        
            
            
            [self.delegate XYZCalendarPicker:self WithCell:cell];
            
        
            
            
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    
    return cell;


}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totalDaysInMonth:self.date];
        
        NSInteger firstWeek = [self firstWeekInThisMonth:self.date];
        
        NSInteger day = 0;
        
        NSInteger i = indexPath.row;
        
        if (i >= firstWeek && i<= firstWeek +daysInThisMonth - 1)
        {
            day = i - firstWeek + 1;
            
            //this month
            if ([self.today isEqualToDate:self.date]) {
                if (day <= [self day:self.date]) {
                    return YES;
                }
            }else if ([self.today compare:self.date] == NSOrderedDescending){
                return YES;
            }
            
        }
    
    }

    return NO;


}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    NSInteger firstWeek = [self firstWeekInThisMonth:self.date];
    
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeek + 1;
    
    
    //self.cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.cell.backgroundColor = [UIColor grayColor];
    
    
    
    
    if (self.calendarBlock) {
        self.calendarBlock(day,[components month],[components year]);
    }
    
    




}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    //self.cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.cell.backgroundColor = [UIColor clearColor];


}
#pragma mark===action

- (IBAction)previouseAction:(UIButton *)sender
{

    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.date = [self lastMonth:self.date];
    } completion:nil];

    self.cell.backgroundColor = [UIColor clearColor];

}

- (IBAction)nexAction:(UIButton *)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.date = [self nextMonth:self.date];
    } completion:nil];
    self.cell.backgroundColor = [UIColor clearColor];

}

+ (instancetype)showOnView:(UIView *)view
{
    XYZCalendarPicker *calendarPicker = [[[NSBundle mainBundle]loadNibNamed:@"XYZCalendarPicker" owner:self options:nil]firstObject];
    calendarPicker.mask = [[UIView alloc]initWithFrame:view.bounds];
    calendarPicker.mask.backgroundColor = [UIColor blackColor];
    
    calendarPicker.mask.alpha = 0.3;
    
    [view addSubview:calendarPicker.mask];
    [view addSubview:calendarPicker];
    
    return calendarPicker;


}

- (void)show
{
    self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);

    [UIView animateWithDuration:0.5 animations:^(void){
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL isfinished) {
        [self customInterface];
    }];


}

- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^(void){
        self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
        self.mask.alpha = 0;
    } completion:^(BOOL isfinished) {
        [self.mask removeFromSuperview];
        [self removeFromSuperview];
    }];


}

#pragma mark===GestureRecognizer
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nexAction:)];
    
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self addGestureRecognizer:swipLeft];
    
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(previouseAction:)];
    
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:swipRight];

    self.cell.backgroundColor = [UIColor clearColor];

}

- (void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.mask addGestureRecognizer:tap];

    self.cell.backgroundColor = [UIColor clearColor];

}
#pragma mark===UICollectionViewlayoutDelegate
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(self.collectionView.frame.size.width/7, (self.collectionView.frame.size.height - 113)/7);


}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);


}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.f;
}





#pragma mark===UICollectionViewDelegate


//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//
//        if (indexPath.section == 1) {
//        NSInteger daysInThisMonth = [self totalDaysInMonth:self.date];
//        
//        NSInteger firstWeek = [self firstWeekInThisMonth:self.date];
//        
//        NSInteger day = 0;
//        
//        NSInteger i = indexPath.row;
//        
//        if (i >= firstWeek && i<= firstWeek +daysInThisMonth - 1)
//        {
//            day = i - firstWeek + 1;
//            
//            //this month
//            if ([self.today isEqualToDate:self.date]) {
//                if (day <= [self day:self.date]) {
//                    return YES;
//                }
//            }else if ([self.today compare:self.date] == NSOrderedDescending){
//                return YES ;
//            }
//            
//        }
//        
//    }
//    
//    return NO;
//    
//
//
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor grayColor];
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath;
//{


//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor clearColor];

//}



@end
