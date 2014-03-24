//
//  DrawViewController.h
//  Achieve
//
//  Created by lingxi on 14-2-27.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bottomIV;
@end
