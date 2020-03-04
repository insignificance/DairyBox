//
//  XYZCalendarViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/22.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZCalendarViewController.h"
#import "XYZCalendarPicker.h"
#import "XYZItemStore.h"
#import "XYZItem.h"
#import "XYZTvc.h"
#import "UIColor+XYColor.h"

#import "XYZCalendarCell.h"


@interface XYZCalendarViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XYZCalendarPickerDelegate>
@property (nonatomic,weak)XYZCalendarPicker *calendarPicker;

@property (nonatomic,strong)NSMutableArray *dateArray;
@property (nonatomic,strong) XYZTvc *tvc;


@end

@implementation XYZCalendarViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{


    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
            UINavigationItem *navItem = self.navigationItem;
            navItem.title = @"MyDiaryBox";
        
        
        
        self.tabBarItem.image = [[UIImage imageNamed:@"calender"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
    



    return self;


}




- (void)viewWillAppear:(BOOL)animated
{
    
    

    [super viewWillAppear:animated];
    
    
    NSArray *array = [[NSArray alloc]initWithArray:[[XYZItemStore sharedStore]allItems]];
    
    self.dateArray = [[NSMutableArray alloc]init];
    
    NSDateFormatter *dateForematter = [[NSDateFormatter alloc]init];
    [dateForematter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (XYZItem *item in array) {
        
        if (![item isKindOfClass:[XYZItem class]]) {
            return;
        }
        
        //NSDate -->NSString
        
        
        NSString *dateStr = [dateForematter stringFromDate:item.dateCreated];
        //NSLog(@"%@",strDate);
        
        dateStr = [dateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSRange range = [dateStr rangeOfString:@" "];
        NSString *str = [dateStr substringToIndex:range.location];
        
        BOOL isContain  = NO;
        
        for (NSMutableArray *arrayItem in self.dateArray) {
            
            XYZItem *firstItem = [arrayItem firstObject];
            //NSLog(@"%@",firstItem.dateCreated);
            NSString *firstDateStr = [dateForematter stringFromDate:firstItem.dateCreated];
            firstDateStr = [firstDateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSRange range =[firstDateStr rangeOfString:@" "];
            NSString *firstStr = [firstDateStr substringToIndex:range.location];
            
            if ([firstStr isEqualToString:str]) {
                isContain = YES;
                [arrayItem addObject:item];
                
                
                
                break;
            }
            
            
            
        }
        
        if (!isContain) {
            
            [self.dateArray addObject:[NSMutableArray arrayWithObject:item]];
            
        }
        
        
    }
    
    
    
    
    
    
    //NSLog(@"dateArray :%@",self.dateArray);
    

    
    
    
    
    //self.calendarPicker.cell.backgroundColor = [UIColor clearColor];
    
    
    UIView *view = [UIView new];
    self.view = view;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _calendarPicker = [XYZCalendarPicker showOnView:self.view];
    
    _calendarPicker.delegate = self;
    
    _calendarPicker.today = [NSDate date];
    _calendarPicker.date = _calendarPicker.today;
    _calendarPicker.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);

//注意
    
    _calendarPicker.calendarBlock = ^(NSInteger day,NSInteger month,NSInteger year){
        //NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
        
        NSString *clickDate = [NSString stringWithFormat:@"%li-%.2li-%.2li",(long)year,(long)month,(long)day];
        
        
        
        
        for (NSMutableArray *TrueArray in self.dateArray) {
            
            XYZItem *item = [TrueArray firstObject];
            
            NSDateFormatter *dateForematter = [NSDateFormatter new];
            [dateForematter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [dateForematter stringFromDate:item.dateCreated];
            //NSLog(@"%@",strDate);
            
            dateStr = [dateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSRange range = [dateStr rangeOfString:@" "];
            NSString *str = [dateStr substringToIndex:range.location];
            //NSLog(@"str==%@:,clickDate==%@:",str,clickDate);
            
            if ([str isEqualToString:clickDate]) {
                
                self.tvc = [XYZTvc new];
                
                
                self.tvc.dateClick = TrueArray;
                
                [self.navigationController pushViewController:self.tvc animated:YES];
                break;
                
           }
            
            
            
            
        }
        
        
        if (self.navigationController.viewControllers.count == 1) {
            
            
            
            
            NSString *title = NSLocalizedString(@"No Diary.", nil);
            NSString *message = NSLocalizedString(@"There are no diaries on the day.", nil);
            NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                //NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        
        
        
        
    };

    
    _calendarPicker.calendarBlockPoint = ^(NSInteger day,NSInteger month,NSInteger year,XYZCalendarCell *cell){
    
       
        NSString *clickDate = [NSString stringWithFormat:@"%li-%.2li-%.2li",(long)year,(long)month,(long)day];
        
        
        
        
        for (NSMutableArray *TrueArray in self.dateArray) {
            
            XYZItem *item = [TrueArray firstObject];
            
            NSDateFormatter *dateForematter = [NSDateFormatter new];
            [dateForematter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateStr = [dateForematter stringFromDate:item.dateCreated];
            //NSLog(@"%@",strDate);
            
            dateStr = [dateStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSRange range = [dateStr rangeOfString:@" "];
            NSString *str = [dateStr substringToIndex:range.location];
            //NSLog(@"str==%@:,clickDate==%@:",str,clickDate);
            
            
            
//添加提示圆点
            if ([str isEqualToString:clickDate]) {
                
                
                
               cell.label_point  = [UILabel new];
               cell.label_point.frame = CGRectMake(cell.dateLabel.frame.size.width/2 -2,cell.dateLabel.frame.size.height - 2, 5 , 5);
                [cell.label_point.layer setCornerRadius:5];
                [cell.label_point.layer setMasksToBounds:YES];
                cell.label_point.backgroundColor = [UIColor colorWithHexString:@"#00ACC1"];
                [cell.dateLabel addSubview:cell.label_point];
                

                
                
                break;
                
            }
            
            
            
            
        }
        
        
        
        
    
    
    };
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
      
    
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)XYZCalendarPicker:(XYZCalendarPicker *)view WithCell:(XYZCalendarCell *)cell
{
   
       
    return;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
