//
//  DrawViewCollectionViewController.m
//  Achieve
//
//  Created by LingXi on 14-1-17.
//  Copyright (c) 2014年 LingXi. All rights reserved.
//

#import "DrawViewCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ACEDrawingView.h"
#import "SPUserResizableView.h"

@interface DrawViewCollectionViewController () <UIActionSheetDelegate, ACEDrawingViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SPUserResizableViewDelegate>
{
    UIImagePickerController * imagePicker;  // 图片选择器
    NSMutableArray * allDrawingView; //存放所有界面
    
    
    SPUserResizableView * currentlyResizableView;
    SPUserResizableView * lastResizableView;

}

@end

#define kActionSheetColor       100
#define kActionSheetTool        101

@implementation DrawViewCollectionViewController

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
    
    self.drawView.delegate = self;
    
    
    // init the preview image
    self.drawView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.drawView.layer.borderWidth = 1.0f;
    
    //add BarButtonItem on navigation
    UIBarButtonItem * addNewItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRight:)];
    addNewItem.tag = 0;
    
    UIBarButtonItem * cameraItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickRight:)];
    cameraItem.tag = 1;
    
    NSArray * items = @[cameraItem,addNewItem];
    self.navigationItem.rightBarButtonItems = items;

    
//    UIBarStyleDefault          = 0,
//    UIBarStyleBlack            = 1,
//    
//    UIBarStyleBlackOpaque      = 1, // Deprecated. Use UIBarStyleBlack
//    UIBarStyleBlackTranslucent = 2, // Deprecated. Use UIBarStyleBlack and set the translucent property to YES

    
    self.myToolBar.barStyle = UIBarStyleDefault;
    
    
    //添加一个点击空白处的点击事件 为了拖拽控件点击空白处时取消选中状态
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditingHandles)];
    //gestureRecognizer.delegate = self;
    [self.drawView addGestureRecognizer:gestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickRight:(UIBarButtonItem*)sender
{
    if (sender.tag == 0) {
        
    }else{
    
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"照片库",@"拍照", nil];
        
        actionSheet.actionSheetStyle = 1;
        [actionSheet showInView:self.view];
        
    }

}
- (IBAction)revocation:(id)sender {
    //撤销
    [self.drawView undoLatestStep];
    //[self updateButtonStatus];
}

#pragma mark Tap
- (void)hideEditingHandles {
    // We only want the gesture recognizer to end the editing session on the last
    // edited view. We wouldn't want to dismiss an editing session in progress.
   // [lastEditedView hideEditingHandles];
}


#pragma mark Gesticulation
- (IBAction)gesticulation:(id)sender {
    UIBarButtonItem * barButtonItem = sender;
    switch (barButtonItem.tag) {
        case 0:
        {
            CGRect frame = CGRectMake(100, 100, 50, 50);
            SPUserResizableView * spView = [[SPUserResizableView alloc]initWithFrame:frame];
            
            UIButton * tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tapBtn.frame = frame;
            tapBtn.backgroundColor = [UIColor orangeColor];
            tapBtn.alpha = 0.7;
            [tapBtn addTarget:self action:@selector(clickBtnOfDraw:) forControlEvents:UIControlEventTouchUpOutside];
            
            spView.contentView = tapBtn;
            spView.delegate = self;
            
            [self.drawView addSubview:spView];
        
        }
            break;
            
        default:
            break;
    }
    
}
-(void)clickBtnOfDraw:(UIButton*)sender
{
    NSLog(@"tapBtn!!");
}


#pragma mark SettingLineWidth
- (IBAction)changeNo1_Line:(id)sender {
    self.drawView.lineWidth = 2.0f;
}
- (IBAction)changeNo2_Line:(id)sender {
    self.drawView.lineWidth = 4.0f;
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
    self.iv.image = image;
    self.iv.userInteractionEnabled = NO;
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ResizableviewDelegate
// Called when the resizable view receives touchesBegan: and activates the editing handles.
- (void)userResizableViewDidBeginEditing:(SPUserResizableView *)userResizableView{


}

// Called when the resizable view receives touchesEnded: or touchesCancelled:
- (void)userResizableViewDidEndEditing:(SPUserResizableView *)userResizableView{


}


#pragma mark - Actions
- (void)updateButtonStatus
{
//    self.undoButton.enabled = [self.drawingView canUndo];
//    self.redoButton.enabled = [self.drawingView canRedo];
}
//
//- (IBAction)takeScreenshot:(id)sender
//{
//    // show the preview image
//    self.previewImageView.image = self.drawingView.image;
//    self.previewImageView.hidden = NO;
//    
//    // close it after 3 seconds
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
//        self.previewImageView.hidden = YES;
//    });
//}
//
//- (IBAction)undo:(id)sender
//{
//    //撤销
//    
//    [self.drawingView undoLatestStep];
//    [self updateButtonStatus];
//}
//
//- (IBAction)redo:(id)sender
//{
//    //恢复撤销掉的
//    
//    [self.drawingView redoLatestStep];
//    [self updateButtonStatus];
//}
//
//- (IBAction)clear:(id)sender
//{
//    [self.drawingView clear];
//    [self updateButtonStatus];
//}

#pragma mark - ACEDrawing View Delegate

- (void)drawingView:(ACEDrawingView *)view didEndDrawUsingTool:(id<ACEDrawingTool>)tool;
{
    [self updateButtonStatus];
}
//#pragma mark - Action Sheet Delegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet.cancelButtonIndex != buttonIndex) {
//        if (actionSheet.tag == kActionSheetColor) {
//            switch (buttonIndex) {
//                case 0:
//                   // self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.lineColor = [UIColor darkGrayColor];
//                    break;
//                    
//                case 1:
//                   // self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.lineColor = [UIColor redColor];
//                    break;
//                    
//                case 2:
//                  //  self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.lineColor = [UIColor greenColor];
//                    break;
//                    
//                case 3:
//                   // self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.lineColor = [UIColor blueColor];
//                    break;
//            }
//            
//        } else {
//            switch (buttonIndex) {
//                case 0:
//                   // self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypePen;
//                    break;
//                    
//                case 1:
//                   // self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypeLine;
//                    break;
//                    
//                case 2:
//                   // self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypeRectagleStroke;
//                    break;
//                    
//                case 3:
//                   // self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypeRectagleFill;
//                    break;
//                    
//                case 4:
//                  //  self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypeEllipseStroke;
//                    break;
//                    
//                case 5:
//                   // self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
//                    self.drawView.drawTool = ACEDrawingToolTypeEllipseFill;
//                    break;
//            }
//        }
//    }
//}

#pragma mark - Settings
//
//- (IBAction)colorChange:(id)sender
//{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selet a color"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"Black", @"Red", @"Green", @"Blue", nil];
//    
//    [actionSheet setTag:kActionSheetColor];
//    [actionSheet showInView:self.view];
//}
//
//- (IBAction)toolChange:(id)sender
//{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selet a tool"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"Pen", @"Line",
//                                  @"Rect (Stroke)", @"Rect (Fill)",
//                                  @"Ellipse (Stroke)", @"Ellipse (Fill)",
//                                  nil];
//    
//    [actionSheet setTag:kActionSheetTool];
//    [actionSheet showInView:self.view];
//}
//
//- (IBAction)toggleWidthSlider:(id)sender
//{
//    // toggle the slider
//    self.lineWidthSlider.hidden = !self.lineWidthSlider.hidden;
//    self.lineAlphaSlider.hidden = YES;
//}
//
//
//- (IBAction)widthChange:(UISlider *)sender
//{
//    self.drawingView.lineWidth = sender.value;
//}
//
//- (IBAction)toggleAlphaSlider:(id)sender
//{
//    // toggle the slider
//    self.lineAlphaSlider.hidden = !self.lineAlphaSlider.hidden;
//    self.lineWidthSlider.hidden = YES;
//}
//
//- (IBAction)alphaChange:(UISlider *)sender
//{
//    self.drawingView.lineAlpha = sender.value;
//}


@end
