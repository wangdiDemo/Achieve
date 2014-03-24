//
//  RootCollectionViewController.m
//  Achieve
//
//  Created by LingXi on 14-1-17.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import "RootCollectionViewController.h"
#import "RootCell.h"

@interface RootCollectionViewController ()


@end

NSString * cellId = @"cell";
@implementation RootCollectionViewController

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
    
    
    
    UINib * cellNib = [UINib nibWithNibName:@"cell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    
//    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    [flowLayout setItemSize:CGSizeMake(100, 100)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
//    
//    [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionDelegate 


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //有多少个Section
    return 1;

}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    //section里面有多少个Item
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    RootCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.myLabel.text = [NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
    //cell.image.image = [UIImage imageNamed:imageToLoad];
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

@end
