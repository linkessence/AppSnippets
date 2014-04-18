//
//  OneViewController.m
//  YzdHUD
//
//  Created by ShineYang on 13-12-6.
//  Copyright (c) 2013年 YangZhiDa. All rights reserved.
//

#import "OneViewController.h"
#import "UIWindow+YzdHUD.h"

@interface OneViewController ()

@end

@implementation OneViewController

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
    
    NSArray *btnTextArray = [NSArray arrayWithObjects:@"---加载中---",@"---成功---",@"---失败---",@"---取消---", nil];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        btn.tag = i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.frame = CGRectMake(10, 100 + 50 * i, 100, 40);
        [btn setTitle:[btnTextArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btn:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self.view.window showHUDWithText:@"加载中" Type:ShowLoading Enabled:YES];
            break;
        case 1:
            [self.view.window showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
            break;
        case 2:
            [self.view.window showHUDWithText:@"加载失败" Type:ShowPhotoNo Enabled:YES];
            break;
        case 3:
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
