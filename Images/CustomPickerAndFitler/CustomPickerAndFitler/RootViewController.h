//
//  RootViewController.h
//  CustomPickerAndFitler
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"
@interface RootViewController : UIViewController
<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate>
{
    IBOutlet UIImageView *imageView;
}
@end
