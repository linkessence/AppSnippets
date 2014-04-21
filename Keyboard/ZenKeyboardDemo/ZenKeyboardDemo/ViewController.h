//
//  ViewController.h
//  ZenKeyboardDemo
//
//  Created by Mac on 13-7-8.
//  Copyright (c) 2013年 iiii1314iiii@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenKeyboard.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *VoiceSwitch;
@property (weak, nonatomic) IBOutlet UITextField *ZenKeyTexField;
@property(nonatomic,strong)ZenKeyboard*keyboardView;
@end
