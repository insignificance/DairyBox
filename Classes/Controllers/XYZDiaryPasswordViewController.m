//
//  XYZDiaryPasswordViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/3.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZDiaryPasswordViewController.h"
#import "XYZDiaryPassword.h"
#import "XYZItemsViewController.h"
#import "XYZPasswordStore.h"
#import "XYZCalendarViewController.h"
#import "MBProgressHUD.h"

@interface XYZDiaryPasswordViewController ()<XYZDiaryPasswordDelegate,MBProgressHUDDelegate>
@property (nonatomic,strong) XYZDiaryPassword *PasswordView;
@property (nonatomic,unsafe_unretained) int index;
@property (nonatomic,assign) BOOL shawNavigationBar;
@property (nonatomic,weak)MBProgressHUD *hub;


@end

@implementation XYZDiaryPasswordViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [self.navigationController setNavigationBarHidden:self.shawNavigationBar animated:YES];
 
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;


}




- (void)viewDidLoad {
    [super viewDidLoad];
//    XYZDairyPassword *PasswordView = [[XYZDairyPassword alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) andTitle:@"相信我你能猜对密码"];
    
    
    self.shawNavigationBar = YES;
    
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    
    NSString *passwordPath = [self PassWordPath];
    
    if (![fileManger fileExistsAtPath:passwordPath]) {
        
        self.PasswordView = [[XYZDiaryPassword alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) andTitle:@"⚠️:此处生成唯一密码,务必牢记"];
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
    NSLog(@"%@",passwordPath);
    if (![fileManger fileExistsAtPath:passwordPath]) {
        
        [[XYZPasswordStore sharedStore]setPassword:Password];
    }
    
//    NSString *passwordPath = [self PassWordPath];
//    if (passwordPath == nil) {
//        [[XYZPasswordStore sharedStore]setPassword:Password];
//
//    }
    
    
    
    [[XYZPasswordStore sharedStore]password];
    NSLog(@"------%@",[[XYZPasswordStore sharedStore]password]);
    
    
    if ([Password isEqualToString:[[XYZPasswordStore sharedStore]password]] ) {
        self.index ++;
        
        //NSLog(@"%@",tab);
        
        
        [self performSelector:@selector(push) withObject:nil afterDelay:0.0];

        
        //[self.navigationController pushViewController:tab animated:NO];
        //NSLog(@"%@",self.navigationController);
        
    }else if(self.index == 1) {
    
        //[self showMessage:@"密码好像是6个1" duration:3];
        
        
        [self showHUb:_hub WithString:@"密码好像是6个1"];
        
        
        
        
        self.index ++;
    
    
    }else if (self.index == 2){
        
        self.index ++;
        //[self showMessage:@"不逗你了其实密码是6个8" duration:3];
        
        [self showHUb:_hub WithString:@"不逗你了其实密码是6个8"];
    }
    
    else if (self.index == 3){
        
        self.index ++;
        //[self showMessage:@"😄哈哈你还真信了？" duration:3];
        
         [self showHUb:_hub WithString:@"😄哈哈你还真信了？"];
        
        
    }else if (self.index == 4){
    
        self.index ++;
        
        //[self showMessage:@"我不告诉你我也不知道密码" duration:3];
        [self showHUb:_hub WithString:@"问问我家主人吧😉"];
    
    
    }
    else if (self.index == 5){
    
       // [self showMessage:@"<(￣3￣)>!老实点输入密码吧！" duration:3];
        [self showHUb:_hub WithString:@"(￣3￣)!老实点输入密码吧！"];
    }
    
    else{
        self.index ++;
        
        [self showHUb:_hub WithString:@"运气差你今天是开不了的"];
        //[self showMessage:@"密码好像是6个0" duration:3];
    }


    
    
    



}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    



}

- (void)push
{

    
    XYZItemsViewController *XYZViewController = [[XYZItemsViewController alloc]init];
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    
    
    XYZCalendarViewController *cv = [[XYZCalendarViewController alloc]init];
    
    
    UINavigationController *c = [[UINavigationController alloc]initWithRootViewController:cv];
    
    UINavigationController *i = [[UINavigationController alloc]initWithRootViewController:XYZViewController];
    
    tab.viewControllers = @[i,c];
    
    [self.navigationController pushViewController:tab animated:YES];

}

#pragma mark  提示条

- (void)hubWasHidden:(MBProgressHUD *)hub
{
    [hub reloadInputViews];
    
    hub = nil;


}

- (void)showHUb: (MBProgressHUD *)hub WithString: (NSString *)srt {


    hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.delegate = self;
    hub.mode = MBProgressHUDModeText;
    hub.label.text = srt;
    
    
    [UIView animateWithDuration:2.5 animations:^{
                hub.alpha = 0;
            } completion:^(BOOL finished) {
                [hub
                 removeFromSuperview];
            }];
    //[hub hideAnimated:YES afterDelay:3.0];

    
    
}


//-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
//{
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    UIView *showview =  [[UIView alloc]init];
//    showview.backgroundColor = [UIColor grayColor];
//    showview.frame = CGRectMake(1, 1, 1, 1);
//    showview.alpha = 1.0f;
//    showview.layer.cornerRadius = 5.0f;
//    showview.layer.masksToBounds = YES;
//    [window addSubview:showview];
//    
//    UILabel *label = [[UILabel alloc]init];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
//                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
//    
//    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
//                                             options:NSStringDrawingUsesLineFragmentOrigin
//                                          attributes:attributes context:nil].size;
//    
//    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
//    label.text = message;
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = 1;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:15];
//    [showview addSubview:label];
//    
//    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
//                                screenSize.height - 300,
//                                labelSize.width+40,
//                                labelSize.height+10);
//    [UIView animateWithDuration:time animations:^{
//        showview.alpha = 0;
//    } completion:^(BOOL finished) {
//        [showview removeFromSuperview];
//    }];
//    
//    
//    
//    
//}
//

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


@end
