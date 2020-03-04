//
//  XYZItemsViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZItemsViewController.h"
#import "XYZDetailViewController.h"
#import "XYZDetail2ViewController.h"
#import "XYZTableViewController.h"
#import "XYZItemStore.h"
#import "XYZItem.h"
#import "XYZItemCell.h"
#import "XYZPopVC.h"

@interface XYZItemsViewController () <UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate>{
    NSString * yue;
    NSString * ri;
}
@property (nonatomic,assign) BOOL showNavigationBar ;
@property (nonatomic,assign) BOOL showTabBar;
@property (nonatomic,strong) XYZPopVC *pop;





@end

@implementation XYZItemsViewController





- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
    
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"MyDiaryBox";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self  action:@selector(rightBtn:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    
    
    self.tabBarItem.image = [[UIImage imageNamed:@"diary"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tableView.backgroundColor = [UIColor grayColor];
    
    return self;
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    
    [super viewWillAppear: animated];
        
    [self getTime];

    
    [self.tableView reloadData];
    
    

    
    
    
    [self.navigationController setNavigationBarHidden:self.showNavigationBar animated:YES];
    
    [self.tabBarController.tabBar setHidden:self.showTabBar];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"XYZItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XYZItemCell"];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    self.showNavigationBar  = NO;
    self.showTabBar = NO;
    
    
    
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        
    {
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }

    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {//判断系统是否支持本地通知
        
        //本次开启立即执行的周期
        notification.fireDate = [NSDate dateWithTimeIntervalSince1970: 12*60*60];
        //循环通知的周期
        notification.repeatInterval=kCFCalendarUnitWeekday;
        notification.timeZone=[NSTimeZone defaultTimeZone];
        //弹出的提示信息
        notification.alertBody=@"How was your day?";
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        //notification.applicationIconBadgeNumber=1; //应用程序的右上角小数字
        
        //本地化通知的声音
        notification.soundName= UILocalNotificationDefaultSoundName;
        //弹出的提示框按钮
        //notification.alertAction = NSLocalizedString(@"????????", nil);
        notification.hasAction = NO;
        
        ;
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
    
        
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
 

}


- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
        
    
    
    [[XYZItemStore sharedStore] saveItem];
    
   



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[XYZItemStore sharedStore] allItems]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    XYZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYZItemCell" forIndexPath:indexPath];
    if (cell == nil){
        
        cell = [[XYZItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYZItemCell"];
    }
    NSArray *items = [[XYZItemStore sharedStore]allItems];
    XYZItem *item = items[indexPath.section];
    

    //NSLog(@"itemTitle :%@ItemText:===%@",item.itemTitle,item.itemText);

    
    
//    //cell.textLabel.text = [NSString stringWithFormat:@"%@",item.dateCreated];
 
    if (item.itemTitle == nil && [item.itemText isEqualToString:@""] && item.thubnail == nil) {
        
        cell.nameLabel.text = @"创建你的专属日记";
        cell.UIImageView.image = [UIImage imageNamed:@"icon"];
        
        cell.UIImageView.image = [item imageIcon];
        
        
        cell.ItemTextLabel.text = @"";
      
        
    }else if ([item.itemTitle isEqualToString:@""] && [item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
        
        cell.nameLabel.text = @"写点啥吧~~";
        cell.UIImageView.image = item.thubnail;
        cell.ItemTextLabel.text = @"";
        
    
    }else if ([item.itemTitle isEqualToString:@""] &&![item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
        cell.nameLabel.text = @"亲！给起个名吧~~";
        cell.ItemTextLabel.text = item.itemText;
        cell.UIImageView.image = item.thubnail;
    }
    
    else if ([item.itemTitle isEqualToString:@""] &&![item.itemText isEqualToString:@""] && (item.thubnail == nil)){
        cell.nameLabel.text = @"亲！给起个名吧~~";
        cell.ItemTextLabel.text = item.itemText;
        cell.UIImageView.image = [UIImage imageNamed:@"icon"];
        

    }else if (![item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
        cell.nameLabel.text = item.itemTitle;
        cell.ItemTextLabel.text = @"写点啥吧~~";
        cell.UIImageView.image = item.thubnail;
    }
    
    
    
    
    else if (![item.itemTitle isEqualToString:@""] && [item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
        
        cell.nameLabel.text = @"亲！给起个名吧~~";
        cell.ItemTextLabel.text = item.itemText;
        cell.UIImageView.image = item.thubnail;
        
    
    }else if (![item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && (item.thubnail == nil)){
        
        cell.nameLabel.text = item.itemTitle;
        cell.ItemTextLabel.text = @"写点啥吧~~";
        cell.UIImageView.image = [item imageIcon];
       
        
    
    }else if (![item.itemTitle isEqualToString:@""] &&![item.itemText isEqualToString:@""] && (item.thubnail == nil)){
        
        cell.nameLabel.text = item.itemTitle;
        cell.ItemTextLabel.text = item.itemText;
       cell.UIImageView.image = [item imageIcon];
        
        
    
    }else if (![item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
        cell.nameLabel.text = item.itemText;
        cell.ItemTextLabel.text = @"写点啥吧~~";
        cell.UIImageView.image = item.thubnail;
        
        
    
    }else if ([item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && (item.thubnail == nil)){
        cell.nameLabel.text = @"创建你的专属日记";
        cell.UIImageView.image = [item imageIcon];
        cell.ItemTextLabel.text = @"";
    
    }
    
    else{
        
    
        cell.nameLabel.text = item.itemTitle;
        cell.ItemTextLabel.text = item.itemText;
        cell.UIImageView.image = item.thubnail;
        
    
    
    }
    
    if (item.yue == nil || [item.yue isEqualToString:@""]) {
        cell.yueLab.text = yue;
        item.yue = yue;
        
    }else{
        cell.yueLab.text = item.yue;

    }
    
    if (item.ri == nil || [item.ri isEqualToString:@""]) {
        cell.riLab.text = ri;
        item.ri = ri;

    }else{
        cell.riLab.text = item.ri;
        
    }

//    UIView *aView = [[UIView alloc]initWithFrame:cell.contentView.frame];
//    aView.backgroundColor = [UIColor redColor];
//    
//    cell.selectedBackgroundView = aView;
    
   
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //cell.textLabel.text = (NSString *)item.dateCreated;
    
    
    return cell;
}
#pragma mark=======


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *tab = [[UITabBarController alloc]init];
    XYZDetailViewController *detail1 = [[XYZDetailViewController alloc]init];
    detail1.yue = yue;
    detail1.ri = ri;
    XYZDetail2ViewController *detail2 = [[XYZDetail2ViewController alloc]init];
    UINavigationController *d1 = [[UINavigationController alloc]initWithRootViewController:detail1];
    UINavigationController *d2 = [[UINavigationController alloc]initWithRootViewController:detail2];
    tab.viewControllers = @[d1,d2];
    
    NSArray *items = [[XYZItemStore sharedStore]allItems];
    XYZItem *selectedItem = items[indexPath.section];
    
    detail1.item = selectedItem;
    detail2.item = selectedItem;
    
    //patient
    [self.tabBarController.navigationController pushViewController:tab animated:YES];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *items = [[XYZItemStore sharedStore]allItems];
        
        XYZItem *item = items[indexPath.section];
            
        NSString *title = NSLocalizedString(@" Are you sure?", nil);
        NSString *message = NSLocalizedString(@"Delete the diary", nil);
       
        NSString *otherButtonTitle = NSLocalizedString(@"NO", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"YES", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            
            [[XYZItemStore sharedStore]removeItem:item];
            
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
                        //NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
        }];
        
        // Add the actions.
        [alertController addAction:otherAction];
        [alertController addAction:cancelAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }


}
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

    [[XYZItemStore sharedStore] moveItemAtIndex:sourceIndexPath.section toIndex:destinationIndexPath.section];


}

- (void)rightBtn: (UIButton *)btn
{
    
    
    
    XYZPopVC *pop = [XYZPopVC new];
    
    XYZTableViewController *vc = [XYZTableViewController new];
    
    
    
    pop.modalPresentationStyle = UIModalPresentationPopover;

    pop.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    pop.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    pop.popoverPresentationController.delegate = self;
    
    
    
    [self.navigationController presentViewController:pop animated:YES completion:nil];
    
    __block XYZItemsViewController *blockSelf = self;
    pop.didSelectCell = ^(NSIndexPath *indexPath){
    
        
       
        if (indexPath.row == 0) {
            
            
            [self dismissViewControllerAnimated:blockSelf-> _pop completion:nil];
            [self addNewItem];
        }else if (indexPath.row == 1){
            [self dismissViewControllerAnimated:blockSelf-> _pop completion:nil];
            [self.navigationController pushViewController:vc animated:YES];
        
        }
        
        
        
    
    };
    
}


//  dismiss popover
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}





- (void)addNewItem
{

    XYZItem *newItem = [[XYZItemStore sharedStore]createdItem];
    
    
    NSInteger lastSection = [[[XYZItemStore sharedStore]allItems]indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:lastSection];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    
    

    
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];


    
}

- (void)getTime{
    NSDate *nowDate = [NSDate date];

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM"];
    
    yue = [formatter stringFromDate:nowDate];
    
    [formatter setDateFormat:@"dd"];
    
    ri = [formatter stringFromDate:nowDate];
}

    








//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//
//
//    
//    UINavigationItem *navItem = self.navigationItem;
//    navItem.title = @"MyDairyBox";
//    
//    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem :)];
//    navItem.rightBarButtonItem = bbi;
//    navItem.leftBarButtonItem = self.editButtonItem;
//
//
//
//
//}
//
//
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//
//
//
//    
//    UINavigationItem *navItem = self.navigationItem;
//    navItem.title = @"MyDairyBox";
//    
//    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem :)];
//    navItem.rightBarButtonItem = bbi;
//    navItem.leftBarButtonItem = self.editButtonItem;
//
//
//}

@end
