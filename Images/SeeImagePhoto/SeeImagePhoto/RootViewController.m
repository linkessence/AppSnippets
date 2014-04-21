//
//  RootViewController.m
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-27.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


@synthesize sv;

@synthesize iv;



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
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.sv = [[UIScrollView alloc] init];
    self.sv.frame = CGRectMake( 0, 0, SelfViewWidth, SelfViewHeight );
    self.sv.delegate = self;
    
    self.iv = [[UIImageView alloc] init];
    [self.sv addSubview: self.iv];
    
    [self.view addSubview: self.sv ];
    
    
    [self loadImage:@"http://app.ijianren.com:9898/jr/upload//avatar/m/a65f8274f7872baca618a72d2d2a1094ed955a7e_1395897151078.jpg"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// 加载图片
- (void)loadImage:(NSString *)imageURL
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        if([data length] > 0 && error==nil){
            UIImage * image = [UIImage imageWithData:data];
            // 重置UIImageView的Frame，让图片居中显示
            
            CGFloat origin_x = abs(sv.frame.size.width - image.size.width)/2.0;
            CGFloat origin_y = abs(sv.frame.size.height - image.size.height)/2.0;
//            self.iv.frame = CGRectMake(origin_x, origin_y, sv.frame.size.width, sv.frame.size.width*image.size.height/image.size.width);
            self.iv.frame = CGRectMake(origin_x, origin_y, image.size.width,image.size.height);
            [self.iv setImage:image];
            
            
            CGSize maxSize = sv.frame.size;
            CGFloat widthRatio = maxSize.width/image.size.width;
            CGFloat heightRatio = maxSize.height/image.size.height;
            CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
            /*
             
             ** 设置UIScrollView的最大和最小放大级别（注意如果MinimumZoomScale == MaximumZoomScale，
             
             ** 那么UIScrllView就缩放不了了
             
             */
            [sv setMinimumZoomScale:initialZoom];
            [sv setMaximumZoomScale:5];
            // 设置UIScrollView初始化缩放级别
            
            [sv setZoomScale:initialZoom];
            
            // 动态隐藏加载界面，从而显示图片
            
//            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationCurveLinear animations:^{
//
//            } completion:^(BOOL finished){
//            }];
        }
    }];
}

// 设置UIScrollView中要缩放的视图

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.iv;
    
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    iv.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            scrollView.contentSize.height * 0.5 + offsetY);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
