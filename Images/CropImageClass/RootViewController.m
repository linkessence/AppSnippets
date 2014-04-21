//
//  RootViewController.m
//  CropImageClass
//
//  Created by FaceUI on 13-6-18.
//  Copyright (c) 2013年 faceUI_anyi. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.cropImage = [[YACropImage alloc]initWIthFrame:self.view.frame andImage:[UIImage imageNamed:@"pic2.jpg"] withCornerImage:[UIImage imageNamed:@"corner.png"]];
    [self.view addSubview:self.cropImage];
    NSLog(@"%@",NSStringFromCGRect(self.cropImage.frame));
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.cropImage addGestureRecognizer:tap];
    [self.cropImage setUserInteractionEnabled:YES];
    
    
}
//点击第一次开始裁剪，第二次裁剪结束
-(void)tap
{
    static int i =0;
    if (i == 0) {
        [self.cropImage startCropImageFrom:CGRectMake(20, 20, 100, 100)];
        i = 1;
    }else
    {
        [self.cropImage setImage:[self.cropImage getCroppedImage]];
        [self.cropImage stopCropImage];
        i = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
