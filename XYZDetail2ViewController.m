//
//  XYZDetail2ViewController.m
//  DiaryBox
//
//  Created by ～^～^～ on 16/5/2.
//  Copyright © 2016年 ～^～^～. All rights reserved.
//

#import "XYZDetail2ViewController.h"
#import "XYZItem.h"
#import "XYZImageStore.h"
@interface XYZDetail2ViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@property (weak,nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UILabel *pictureDate;
@property (nonatomic,assign) BOOL showNavigationBar;

- (IBAction)tekePicture: (id)sender;

@end


@interface XYZDetail2ViewController ()

@end

@implementation XYZDetail2ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.tabBarItem.title = @"Camera";
        
        self.tabBarItem.image = [[UIImage imageNamed:@"Camera"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:0.60 green:0.49 blue:0.56 alpha:1];
        
    }


    return self;


}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    XYZItem *item = self.item;
    
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        
        dateFormatter.twoDigitStartDate = NSDateFormatterNoStyle;
        
    }

    self.pictureDate.text = [dateFormatter stringFromDate:item.dateCreated];
    
    
    NSString *itemKey = self.item.itemKey;
    
    if (itemKey) {
        UIImage *imageToDisplay = [[XYZImageStore sharedStore]imageForKey:itemKey];
        
        
        self.imageView.image = imageToDisplay;
        
        
    } else{
    
        self.imageView.image = nil;
    
    
    }
    


}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    
    
    [self.view endEditing:YES];
    
    //XYZItem *item = self.item;
    
    //[self.tabBarController.navigationController popToViewController:self animated:YES];

}
- (IBAction)tekePicture: (id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];





}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    NSString *oldKey = self.item.itemKey;
    
    
    if (oldKey) {
        [[XYZImageStore sharedStore]deleteImageForKey:oldKey];
    
    }
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.item setThubnailFromImage:image];
    
    
    [[XYZImageStore sharedStore]setImage:image forKey:self.item.itemKey];

    self.imageView.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];

}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//
//
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
        
    
    
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
