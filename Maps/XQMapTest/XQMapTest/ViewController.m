//
//  ViewController.m
//  XQMapTest
//
//  Created by xf.lai on 13-7-15.
//  Copyright (c) 2013年 xf.lai. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import "BMapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)dealloc
{
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"地图覆盖层的研究";
    
      
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickBmapButton:(id)sender {
    MapViewController *controller = [[MapViewController alloc]init];
    controller.title = @"自带地图";
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)clickMapButton:(id)sender {
    BMapViewController *controller = [[BMapViewController alloc]init];
    controller.title = @"百度地图";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
