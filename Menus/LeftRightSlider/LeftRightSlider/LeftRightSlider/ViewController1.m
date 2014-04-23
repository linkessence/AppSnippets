//
//  ViewController1.m
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-29.
//  Copyright (c) 2013年 heroims. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

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
    
    self.view.backgroundColor=[UIColor redColor];
    
    UIButton *btnNext=[UIButton buttonWithType:UIButtonTypeCustom];
    btnNext.layer.borderColor=[[UIColor whiteColor] CGColor];
    btnNext.layer.borderWidth=2;
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [btnNext setFrame:CGRectMake(0, 0, 100, 50)];
    btnNext.center=CGPointMake(self.view.center.x, self.view.center.y-60);
    [btnNext addTarget:self action:@selector(btnNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNext];

    UIButton *btnPop=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPop.layer.borderColor=[[UIColor whiteColor] CGColor];
    btnPop.layer.borderWidth=2;
    [btnPop setTitle:@"Pop" forState:UIControlStateNormal];
    [btnPop setFrame:CGRectMake(0, 0, 100, 50)];
    btnPop.center=self.view.center;
    [btnPop addTarget:self action:@selector(btnPopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPop];

	// Do any additional setup after loading the view.
}

-(void)btnPopClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnNextClick:(id)sender{
    [self.navigationController pushViewController:[[ViewController2 alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
