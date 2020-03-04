//
//  XYZTvc.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/28.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZTvc.h"
#import "XYZItem.h"
#import "XYZItemStore.h"
#import "XYZDetailViewController.h"
#import "XYZDetail2ViewController.h"
#import "XYZItemCell.h"
@interface XYZTvc ()

@end

@implementation XYZTvc


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    


}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UINib *nib = [UINib nibWithNibName:@"XYZItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XYZItemCell"];
    self.tableView.backgroundColor = [UIColor grayColor];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
   
  
    //加了这个会有bug～～～～～
    //[self.navigationController popViewControllerAnimated:YES];


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dateClick count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        
    
    return 1;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYZItemCell" forIndexPath:indexPath];
    if (cell == nil){
        
        cell = [[XYZItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYZItemCell"];
        
    }
    NSArray *items = self.dateClick;
    XYZItem *item = items[indexPath.section];
    
    
    if (item.itemTitle == nil && [item.itemText isEqualToString:@""] && item.thubnail == nil) {
        
        cell.nameLabel.text = @"创建你的专属日记";
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
       cell.UIImageView.image = [item imageIcon];
        
        
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
    
    
    cell.yueLab.text = item.yue;
    
    cell.riLab.text = item.ri;
//    if (item.itemTitle == nil && [item.itemText isEqualToString:@""] && item.thubnail == nil) {
//        
//        cell.nameLabel.text = @"创建你的专属日记";
//        cell.imageView.image = [UIImage imageNamed:@"Snip20160529_1副本"];
//        cell.ItemTextLabel.text = @"";
//        
//        
//    }else if ([item.itemTitle isEqualToString:@""] && [item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
//        
//        cell.nameLabel.text = @"写点啥吧~~";
//        cell.imageView.image = item.thubnail;
//        cell.ItemTextLabel.text = @"";
//        
//    }else if ([item.itemTitle isEqualToString:@""] &&![item.itemText isEqualToString:@""] && (item.thubnail == nil)){
//        cell.nameLabel.text = @"亲！给起个名吧~~";
//        cell.ItemTextLabel.text = item.itemText;
//        cell.imageView.image = [UIImage imageNamed:@"Snip20160529_1副本"];
//        
//        
//    }else if (![item.itemTitle isEqualToString:@""] && [item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
//        
//        cell.nameLabel.text = @"亲！给起个名吧~~";
//        cell.ItemTextLabel.text = item.itemText;
//        cell.imageView.image = item.thubnail;
//        
//        
//    }else if (![item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && (item.thubnail == nil)){
//        
//        cell.nameLabel.text = item.itemTitle;
//        cell.ItemTextLabel.text = @"写点啥吧~~";
//        cell.imageView.image = [UIImage imageNamed:@"Snip20160529_1副本"];
//        
//        
//        
//    }else if (![item.itemTitle isEqualToString:@""] &&![item.itemText isEqualToString:@""] && (item.thubnail == nil)){
//        
//        cell.nameLabel.text = item.itemTitle;
//        cell.ItemTextLabel.text = item.itemText;
//        cell.imageView.image = [UIImage imageNamed:@"Snip20160529_1副本"];
//        
//        
//        
//    }else if (![item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && !(item.thubnail == nil)){
//        cell.nameLabel.text = item.itemText;
//        cell.ItemTextLabel.text = @"写点啥吧~~";
//        cell.imageView.image = item.thubnail;
//        
//        
//        
//    }else if ([item.itemTitle isEqualToString:@""] &&[item.itemText isEqualToString:@""] && (item.thubnail == nil)){
//        cell.nameLabel.text = @"创建你的专属日记";
//        cell.imageView.image = [UIImage imageNamed:@"Snip20160529_1副本"];
//        cell.ItemTextLabel.text = @"";
//        
//    }
//    
//    else{
//        
//        
//        cell.nameLabel.text = item.itemTitle;
//        cell.ItemTextLabel.text = item.itemText;
//        cell.imageView.image = item.thubnail;
//        
//        
//        
//    }
//
//    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    XYZDetailViewController *detail1 = [[XYZDetailViewController alloc]init];
    XYZDetail2ViewController *detail2 = [[XYZDetail2ViewController alloc]init];
    UINavigationController *d1 = [[UINavigationController alloc]initWithRootViewController:detail1];
    UINavigationController *d2 = [[UINavigationController alloc]initWithRootViewController:detail2];
    tab.viewControllers = @[d1,d2];
    
    NSArray *items = self.dateClick;
    XYZItem *selectedItem = items[indexPath.section];
    
    detail1.item = selectedItem;
    detail2.item = selectedItem;
    
    //patient
    [self.tabBarController.navigationController pushViewController:tab animated:YES];
    


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
