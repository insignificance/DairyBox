//
//  XYZTableViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/6/5.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZTableViewController.h"
#import "XYZPasswordReVC.h"

@interface XYZTableViewController ()

@property (nonatomic,assign) BOOL showTabBar ;

@end

@implementation XYZTableViewController




- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
        
    return self;


}


- (void)viewWillAppear:(BOOL)animated
{


    [self.tabBarController.tabBar setHidden:self.showTabBar];



}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showTabBar = YES;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        
        return 3;
        
    }else
    
        return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        if (indexPath.section == 0) {
            
            
            
            cell.imageView.clipsToBounds = YES;
            cell.imageView.layer.cornerRadius = 45;
            
            cell.imageView.image = [UIImage imageNamed:@"icon"];
            
            cell.imageView.layer.borderWidth = 1.5f;
            cell.imageView.layer.borderColor = [UIColor grayColor].CGColor
            ;
           
            cell.textLabel.text = @"DiaryBox";
            
            
            
            
        }else if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"用户名";
                cell.detailTextLabel.text = @"无名氏";
                
            }else if (indexPath.row == 1){
                
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = @"未知";
                
                
            }else if (indexPath.row == 2){
                
                cell.textLabel.text = @"重置密码";
                
                
            }
            
            
            
            
        }else if (indexPath.section == 2){
            if (indexPath.row == 0) {
                cell.textLabel.text = @"帮助";
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"关于";
            }
        }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
   
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 90;
    }

    return 44;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            
            XYZPasswordReVC *ReVC = [XYZPasswordReVC new];
            
            [self.navigationController pushViewController:ReVC animated:YES];
            
        }
    }

    



}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
