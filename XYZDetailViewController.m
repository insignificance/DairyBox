//
//  XYZDetailViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZDetailViewController.h"
#import "XYZItem.h"
#import "XYZItemsViewController.h"

@interface XYZDetailViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak,nonatomic) IBOutlet UITextField *titleField;
@property (weak,nonatomic)IBOutlet UITextView *contentField;
@property (nonatomic,assign) BOOL showNavigationBar;



@end

@implementation XYZDetailViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
      self.tabBarItem.title = @"Diary";
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Diary";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
    
        //navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = bbi;
        
        
        
        
        
        
        
        self.tabBarItem.image = [[UIImage imageNamed:@"Note"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
//        backView.backgroundColor = [UIColor redColor];
//        [self.tabBarController.tabBar insertSubview:backView atIndex:0];
//        self.tabBarController.tabBar.opaque = YES;        
        self.tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:0.24 green:0.18 blue:0.22 alpha:1];
        
        
        
        
    }


    return self;

}



- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    XYZItem *item = self.item;
    
    self.titleField.text = item.itemTitle;
    self.contentField.text = item.itemText;
    
    [self.navigationController setNavigationBarHidden:self.showNavigationBar animated:YES];

    

}


- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    XYZItem *item = self.item;
    item.itemTitle = self.titleField.text;
    
    item.itemText = self.contentField.text;

    item.yue = self.yue;
    
    item.ri = self.ri;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
   [self.view endEditing:YES];

//pay attention
    
//此处提前
//    XYZItem *item = self.item;
//    item.itemTitle = self.titleField.text;
//    
//    item.itemText = self.contentField.text;
    
    self.showNavigationBar = NO;
    
    

}
//- (void)setItem:(XYZItem *)item
//{
//
//    _item = item;
//    //self.navigationItem.title = _item.ItemTitle;
//
//
//
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//    
//    
//    
//}

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    
//    [textView resignFirstResponder];
//    return YES;
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.showNavigationBar = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back
{
    
    //NSLog(@"%@",self.navigationController);
    
    //NSLog(@"%@",self.navigationController.navigationController);
    
    [self.navigationController.navigationController popViewControllerAnimated:YES];
    
}




@end
