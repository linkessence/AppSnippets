//
//  EditPhotoViewController.h
//  macaics
//
//  Created by gao dong  qq7693517 on 13-7-4.
//  Copyright (c) 2013年 com.hairbobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class STScratchView;
@interface EditPhotoViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (nonatomic, strong) IBOutlet STScratchView *scratchView;
@property (weak, nonatomic) UIImage *sourseImg;
@property (weak, nonatomic) IBOutlet UIImageView *endImg;

@end
