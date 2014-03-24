//
//  DrawViewCollectionViewController.h
//  Achieve
//
//  Created by LingXi on 14-1-17.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACEDrawingView;

@interface DrawViewCollectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet ACEDrawingView *drawView;
@property (weak, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (weak, nonatomic) IBOutlet UIImageView *iv;


@end
