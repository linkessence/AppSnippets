//
//  RootViewController.h
//  pictureProcess
//
//  Created by Ibokan on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImageView *rootImageView;
    UIToolbar *toolBar;
    UISegmentedControl *seg;    
    UIImage *currentImage;
    UIImagePickerController *imagePicker;
    NSData *data;
    UIScrollView *scrollerView;
    
    UIImage *rootImage;
    UIImageView *imageView;
    
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
