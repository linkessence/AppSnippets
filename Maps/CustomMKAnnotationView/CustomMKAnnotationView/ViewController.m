//
//  ViewController.m
//  CustomMKAnnotationView
//
//  Created by Jian-Ye on 12-11-22.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    MapViewController *_mapViewController;
}
@end

@implementation ViewController

- (void)dealloc
{
    [_mapViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"30.281843",@"latitude",@"120.102193",@"longitude",nil];
    
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"30.290144",@"latitude",@"120.146696‎",@"longitude",nil];
    
    NSDictionary *dic3=[NSDictionary dictionaryWithObjectsAndKeys:@"30.248076",@"latitude",@"120.164162‎",@"longitude",nil];
    
    NSDictionary *dic4=[NSDictionary dictionaryWithObjectsAndKeys:@"30.425622",@"latitude",@"120.299605",@"longitude",nil];
    
    NSArray *array = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4, nil];
    
	_mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    _mapViewController.delegate = self;
    [self.view addSubview:_mapViewController.view];
    [_mapViewController.view setFrame:self.view.bounds];
    [_mapViewController resetAnnitations:array];
}

- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
