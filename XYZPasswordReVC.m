//
//  XYZPasswordReVC.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/6/5.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZPasswordReVC.h"
#import "XYZDiaryPassword.h"
#import "XYZItemsViewController.h"
#import "XYZPasswordStore.h"
#import "XYZCalendarViewController.h"

@interface XYZPasswordReVC ()<XYZDiaryPasswordDelegate>


@property (nonatomic,strong) XYZDiaryPassword *PasswordView;
@property (nonatomic,unsafe_unretained) int index;
@property (nonatomic,assign) BOOL shawNavigationBar;

@end

@implementation XYZPasswordReVC


- (void)viewDidLoad {
    [super viewDidLoad];
    //    XYZDairyPassword *PasswordView = [[XYZDairyPassword alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) andTitle:@"相信我你能猜对密码"];
    
    
    self.shawNavigationBar = YES;
    
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    
    NSString *passwordPath = [self PassWordPath];
    
    if (![fileManger fileExistsAtPath:passwordPath]) {
        
        self.PasswordView = [[XYZDiaryPassword alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) andTitle:@"输入新密码"];
    }else {
        
        self.PasswordView = [[XYZDiaryPassword alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) andTitle:@"请输入密码"];
        
        
        
    }
    
    
    
    
    _PasswordView.delegate = self;
    
    if (![_PasswordView.TF becomeFirstResponder]) {
        [_PasswordView.TF becomeFirstResponder];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_PasswordView
     ];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)XYZDiaryPassword: (XYZDiaryPassword *)view WithPasswordString: (NSString *)Password
{
    
    //判断并记录密码
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    
    NSString *passwordPath = [self PassWordPath];
    
    if (![fileManger fileExistsAtPath:passwordPath]) {
        
        [[XYZPasswordStore sharedStore]setPassword:Password];
    }
    
    
    
    
    
    
    
    
    if ([Password isEqualToString:[[XYZPasswordStore sharedStore]password]] ) {
        self.index ++;
        
        
        
        
        [self performSelector:@selector(push) withObject:nil afterDelay:0.0];
        
        
        
    }else if(self.index == 1) {
        
        [self showMessage:@"密码好像是6个1" duration:3];
        
        self.index ++;
        
        
    }else if (self.index == 2){
        
        self.index ++;
        [self showMessage:@"不逗你了其实密码是6个8" duration:3];
    }
    
    else if (self.index == 3){
        
        self.index ++;
        [self showMessage:@"😄哈哈你还真信了？" duration:3];
        
        
    }else if (self.index == 4){
        
        self.index ++;
        
        [self showMessage:@"我不告诉你我也不知道密码" duration:3];
        
        
    }
    else if (self.index == 5){
        
        [self showMessage:@"<(￣3￣)>!老实点输入密码吧！" duration:3];
    }
    
    else{
        self.index ++;
        [self showMessage:@"密码好像是6个0" duration:3];
    }
    
    
    
    
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    
    
    
}

- (void)push
{
    
    
    XYZPasswordReVC *ReVC = [XYZPasswordReVC new];
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    
    NSString *passwordPath = [self PassWordPath];
    
    
    
    if ([fileManger fileExistsAtPath:passwordPath]) {
        
        
        if (self.navigationController.viewControllers.count == 3) {
            [fileManger removeItemAtPath:passwordPath error:nil];
        
        [self.navigationController pushViewController:ReVC animated:YES];
        }else if(self.navigationController.viewControllers.count >= 4) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
            
        }

        
        
        
        
    }
    
   
    
    
    
    
}

#pragma mark  提示条
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor grayColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;
    
    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
                                screenSize.height - 300,
                                labelSize.width+40,
                                labelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
    
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    if (![_PasswordView.TF becomeFirstResponder]) {
        [_PasswordView.TF becomeFirstResponder];
    }
    
    
    
}






- (NSString *)PassWordPath
{
    NSArray *Directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directory = [Directorys firstObject];
    
    return [directory  stringByAppendingPathComponent:@"password.file"];
    
    
    
    
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
