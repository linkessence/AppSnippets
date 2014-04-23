//
//  ViewController.m
//  zzDaoHang
//
//  Created by zzzili on 13-12-14.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "ViewController.h"

////////服务接口网站 www.zdoz.net
////起点
double startLat = 34.7712;
double startLng = 113.7240;
////终点
double endLat = 34.7524;
double endLng = 113.6657;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
     www.zdoz.net 获取地理位置接口 http://www.zdoz.net/api/geo2loc.aspx
     */
    ///获取起点地理位置
    NSString *startName = [self GetHtmlFromUrl:[NSString stringWithFormat:@"http://www.zdoz.net/api/geo2loc.aspx?lat=%f&lng=%f",startLat,startLng]];
    ///获取终点地理位置
    NSString *endName = [self GetHtmlFromUrl:[NSString stringWithFormat:@"http://www.zdoz.net/api/geo2loc.aspx?lat=%f&lng=%f",endLat,endLng]];
    
    self.text.text = [NSString stringWithFormat:@"从：%@",startName];
    self.text2.text = [NSString stringWithFormat:@"到：%@",endName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_web release];
    [_text release];
    [_text2 release];
    [super dealloc];
}

/*
 www.zdoz.net 导航接口 http://www.zdoz.net/api/daohang.aspx
 */

- (IBAction)ZiJia:(id)sender {
    ///自驾
    NSString *travelType = @"driving";
    NSString *urlStr = [NSString stringWithFormat:@"http://www.zdoz.net/api/daohang.aspx?TravelType=%@&startLat=%f&startLng=%f&endLat=%f&endLng=%f",travelType,startLat,startLng,endLat,endLng];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
}

- (IBAction)TuBu:(id)sender {
    //徒步
    NSString *travelType = @"walking";
    NSString *urlStr = [NSString stringWithFormat:@"http://www.zdoz.net/api/daohang.aspx?TravelType=%@&startLat=%f&startLng=%f&endLat=%f&endLng=%f",travelType,startLat,startLng,endLat,endLng];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (IBAction)Gongjia:(id)sender {
    //公交
    NSString *travelType = @"transit";
    NSString *urlStr = [NSString stringWithFormat:@"http://www.zdoz.net/api/daohang.aspx?TravelType=%@&startLat=%f&startLng=%f&endLat=%f&endLng=%f",travelType,startLat,startLng,endLat,endLng];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}


-(NSString*)GetHtmlFromUrl:(NSString *)urlStr
{
    ///获取html数据
    return [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
}
@end
