//
//  ViewController.m
//  CloudLabel
//
//  Created by PowerAuras on 13-8-28.
//  qq120971999  http://www.cnblogs.com/powerauras/
//  Copyright (c) 2013年 PowerAuras. All rights reserved.
//

#import "ViewController.h"
#import "CloudView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *labelARy =[NSArray arrayWithObjects:@"吃惊威龙",@"摧残人僧",@"赏金杀手",@"疯狂原始人",@"神偷奶爸",@"致命黑兰",@"冥界警局",@"狂鲨之灾",@"北海巨妖",@"海扁王2",@"变形金刚3",@"史前一亿年",@"大片",@"双煞",@"百万爱情宝贝",@"太郎的幸福生活",@"别跟我谈高富帅",@"致我们将死得清楚",@"一路狂奔",@"甜蜜十八岁",@"艳遇",@"后宫:帝王之妾",@"金钱的味道",@"痛症",@"宝贝和我",@"夺宝联盟",@"危险关系",@"甜心巧克力",@"101次求婚",@"今天",@"恐怖故事",@"富春山居图",@"嘻哈四重奏之陈可",@"爱爱囧事",@"盲探",@"小时代",@"嘻哈四重奏至台北",@"肖申克的救赎",@"特种部队2:全面反击",nil];
   
    CloudView *cv=[[CloudView alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
    [cv reloadData:labelARy];
    cv.layer.borderColor=[UIColor yellowColor].CGColor;
    cv.layer.borderWidth=2;
    [self.view addSubview:cv];
    [cv release];
    [self.view setBackgroundColor:[UIColor darkTextColor]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
