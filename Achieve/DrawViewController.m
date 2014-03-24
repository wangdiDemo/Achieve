//
//  DrawViewController.m
//  Achieve
//
//  Created by lingxi on 14-2-27.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()
{
    UIImagePickerController * imagePicker;  // 图片选择器
}

@end

@implementation DrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Go:(id)sender {
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"照片库",@"拍照", nil];
    
    actionSheet.actionSheetStyle = 1;
    [actionSheet showInView:self.view];
    
}
#pragma mark actionDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (imagePicker == nil) {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical; //设置动画
        imagePicker.allowsEditing = YES;
    }
    
    switch (buttonIndex) {
        case 0:
        {
            //照片库
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            //拍照
            //imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //[self.parentViewController presentViewController: imagePicker animated:YES completion:nil];
            
        }
            break;
    }
}
#pragma imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image  = [info objectForKey:UIImagePickerControllerEditedImage];
    
//    //赋值给draw界面的底层
//    self.drawView.image = image;
//    [self.drawView setNeedsDisplay];
//    
//    //在这里强制调用一下刷新图片方法 不然图片显示没有按照比例缩放 原因待研究。
//    [self.drawView updateCacheImage:NO];
    
    self.bottomIV.image = image;
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
