//
//  ViewController.h
//  XHFaceRecognizerSDKSimple
//
//  Created by 曾 宪华 on 13-12-26.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import <UIKit/UIKit.h>
// 如果提示错误，运行不了，那就把XHFaceRecognizerFramework.framework文件删除了，记得是选择remove reference，而是选择move to trash，然后在文件里面找回这个XHFaceRecognizerFramework.framework文件，重新拖进来
#import <XHFaceRecognizerFramework/XHFaceRecognizerView.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) XHFaceRecognizerView *simpleImageView;

- (IBAction)recognizer:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)cropped:(id)sender;
@end
