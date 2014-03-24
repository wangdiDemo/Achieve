//
//  DrawView.h
//  Achieve
//
//  Created by lingxi on 14-2-27.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property(nonatomic,strong)NSMutableArray *lines;
@property(nonatomic,strong)UIColor *currentColor;
@property(nonatomic,assign)float currentWidth;
 
@end
