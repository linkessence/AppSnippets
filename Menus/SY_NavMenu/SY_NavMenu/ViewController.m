//
//  ViewController.m
//  SY_NavMenu
//
//  Created by 孙悦 on 14-2-11.
//  Copyright (c) 2014年 孙悦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor grayColor];
    
    _mmMainFX = self.view.bounds.origin.x;
    _mmMainFY = 20 + 44;
//    _mmMainFY = [[UIBaseClass shareInstance] getViewFramOY];
    _clearFlag = YES;
    
    [self initNavBtn];
    [self initView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBtn
{
//    UIButton * navLeftButton= [UIButton buttonWithType:UIButtonTypeCustom];
//    [navLeftButton setFrame:CGRectMake(0, 0, 13, 22)];
//    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navBack-26X44"] forState:UIControlStateNormal];
//    [navLeftButton addTarget:self action:@selector(leftNavBtn) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem* leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
//    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    
    navRightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightButton setFrame:CGRectMake(281, 7, 30, 30)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"c_nav-60-60"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:navRightButton];
    
    //    UIBarButtonItem* rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
    //    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}
-(void)rightNavBtn
{
    if (_clearFlag)
    {
        _clearImg.hidden = NO;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(M_PI/-3);//先顺时钟旋转90
        navRound =CGAffineTransformTranslate(navRound,0,0);
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*1);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*2);
                             _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*3);
                             _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,45*4);
                             _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,45*5);
                             _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,45*6);
                             _lcksBtn.alpha = 1;
                             _wjxxBtn.alpha = 1;
                             _jkpgBtn.alpha = 1;
                             _jkjhBtn.alpha = 1;
                             _jhssBtn.alpha = 1;
                             _sszjBtn.alpha = 1;
                             _khssBtn.alpha = 1;
                             
                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                 
                                 _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,40.0*0);
                                 _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,40.0*1);
                                 _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,40.0*2);
                                 _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,40.0*3);
                                 _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,40.0*4);
                                 _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,40.0*5);
                                 _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,40.0*6);
                                 
                             } completion:NULL];
                         }];
    }
    else
    {
        _clearImg.hidden = YES;
        
        CGAffineTransform navRound =CGAffineTransformMakeRotation(0);//先顺时钟旋转90
        navRound =CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.35f
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction|
                                     UIViewAnimationOptionBeginFromCurrentState)
                         animations:^(void) {
                             
                             _lcksBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0*-10,45*0);
                             _wjxxBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,1*-10,45*0);
                             _jkpgBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,2*-10,45*0);
                             _jkjhBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,3*-10,45*0);
                             _jhssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,4*-10,45*0);
                             _sszjBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,5*-10,45*0);
                             _khssBtn.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,6*-10,45*0);
                             _lcksBtn.alpha = 0;
                             _wjxxBtn.alpha = 0;
                             _jkpgBtn.alpha = 0;
                             _jkjhBtn.alpha = 0;
                             _jhssBtn.alpha = 0;
                             _sszjBtn.alpha = 0;
                             _khssBtn.alpha = 0;
                             
                             [navRightButton setTransform:navRound];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
    }
    
    _clearFlag = !_clearFlag;
    
    NSLog(@"navRightButton = %f,%f",navRightButton.frame.size.width, navRightButton.frame.size.height);
}

-(void)initView
{
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    
//    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 460+(iPhone5?88:0)-44)];
    _clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 460+88-44)];
    _clearImg.backgroundColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:0.9];
    _clearImg.hidden = YES;
    
    _vFX = _mmMainFX;
    _vFY = _mmMainFY;
    _lcksBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lcksBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_lcksBtn setTitle:@"My_Menu_1" forState:UIControlStateNormal];
    
    _wjxxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wjxxBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_wjxxBtn setTitle:@"My_Menu_2" forState:UIControlStateNormal];
    
    _jkpgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jkpgBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_jkpgBtn setTitle:@"My_Menu_3" forState:UIControlStateNormal];
    
    _jkjhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jkjhBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_jkjhBtn setTitle:@"My_Menu_4" forState:UIControlStateNormal];
    
    _jhssBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jhssBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_jhssBtn setTitle:@"My_Menu_5" forState:UIControlStateNormal];
    
    _sszjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sszjBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_sszjBtn setTitle:@"My_Menu_6" forState:UIControlStateNormal];
    
    _khssBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_khssBtn setFrame:CGRectMake(202, _vFY, 100, 40)];
    [_khssBtn setTitle:@"My_Menu_7" forState:UIControlStateNormal];
    
    _lcksBtn.alpha = 0;
    _wjxxBtn.alpha = 0;
    _jkpgBtn.alpha = 0;
    _jkjhBtn.alpha = 0;
    _jhssBtn.alpha = 0;
    _sszjBtn.alpha = 0;
    _khssBtn.alpha = 0;
    
    [_lcksBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_wjxxBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_jkpgBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_jkjhBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_jhssBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_sszjBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_khssBtn addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_clearImg];
    [self.view addSubview:_lcksBtn];
    [self.view addSubview:_wjxxBtn];
    [self.view addSubview:_jkpgBtn];
    [self.view addSubview:_jkjhBtn];
    [self.view addSubview:_jhssBtn];
    [self.view addSubview:_sszjBtn];
    [self.view addSubview:_khssBtn];
}
//疗程开始 hmStatus=1
//问卷信息 hmStatus=2
//健康评估 hmStatus=4
//健康计划 hmStatus=6
//计划实施 hmStatus=7
//实施总结 hmStatus=9
//全部用户 hmStatus=0

-(void)btnSelect
{
    _clearFlag = NO;
    [self rightNavBtn];
//    [navRightButton removeFromSuperview];
}

@end
