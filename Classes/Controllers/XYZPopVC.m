//
//  XYZPopVC.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/6/5.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZPopVC.h"
#import "XYZItemStore.h"

NSString *const Recell = @"ReCell";
@interface XYZPopVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *itemName;
@property (nonatomic,strong) NSArray *picName;


@end

@implementation XYZPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _table = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    _table.dataSource = self;
    _table.delegate = self;
    _table.scrollEnabled = NO;
    
    [self.view addSubview:self.table];
    
    _itemName = @[@"写日记",@"个人中心"];
       
    
    
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _itemName.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Recell];
    
        if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Recell];
    }

    cell.textLabel.text = _itemName[indexPath.row];
    cell.selectionStyle = UITableViewCellStyleDefault;
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
        if (self.didSelectCell) {
            self.didSelectCell (indexPath);
        }
        
        
    







}


- (CGSize)preferredContentSize
{

    if (self.popoverPresentationController) {
        CGSize MySize;
    //预设
        MySize.height = self.view.frame.size.height;
        MySize.width = 158;
    //自适应
        CGSize size = [_table sizeThatFits:MySize];
        return size;
        
        
        
    }else
        
        return [super preferredContentSize];









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
