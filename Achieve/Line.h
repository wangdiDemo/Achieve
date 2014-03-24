//
//  Line.h
//  Achieve
//
//  Created by lingxi on 14-2-27.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject

@property(nonatomic,retain)UIColor* color;
@property(nonatomic,assign)float width;
@property(nonatomic,retain)NSMutableArray *points;

@end
