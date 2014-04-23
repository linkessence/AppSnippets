//
//  ViewController.h
//  SY_NavMenu
//
//  Created by 孙悦 on 14-2-11.
//  Copyright (c) 2014年 孙悦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIButton * navRightButton;
    UIImageView* _clearImg;
    bool _clearFlag;
    
    UIButton* _lcksBtn;
    UIButton* _wjxxBtn;
    UIButton* _jkpgBtn;
    UIButton* _jkjhBtn;
    UIButton* _jhssBtn;
    UIButton* _sszjBtn;
    UIButton* _khssBtn;
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
}

@end
