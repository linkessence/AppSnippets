//
//  ShowAllImageViewController.m
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-28.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import "ShowAllImageViewController.h"

// 展示 帖子 图片1 图片2 图片3 图片4
// 展示 图片
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


@interface ShowAllImageViewController ()<UIGestureRecognizerDelegate>
{
    NSMutableArray * myImageUrlArr;
}

@end

@implementation ShowAllImageViewController

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
    
    UIScrollView * myScrollView = [[UIScrollView alloc] init];
    myScrollView.frame = self.view.bounds;
    
    [self.view addSubview: myScrollView];
    
    myImageUrlArr = [[NSMutableArray alloc] init];
    
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334281.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334156.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//11fe460ffcb14399_1395945336218.JPG" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941257796.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//d03ca12a6525e008_1395940809640.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334281.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334156.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//11fe460ffcb14399_1395945336218.JPG" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941257796.jpg" ];
    
    [myImageUrlArr addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//d03ca12a6525e008_1395940809640.jpg" ];
    
    for ( int j = 0; j < 5; j++ ) {
        [myImageUrlArr addObjectsFromArray: myImageUrlArr ];
    }
    
    
    
    int BtnW = 70;
    int BtnWS = 10;
    int BtnX = 10;
    
    int BtnH = 70;
    int BtnHS = 10;
    int BtnY = 40;
    
    int i = 0;
    for (i = 0; i < [myImageUrlArr count]; i++ ) {
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        [imageview setImageWithURL: [NSURL URLWithString: [myImageUrlArr objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"] ];
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
        [myScrollView addSubview: imageview];
    }
    
    
    
    
    int getEndImageYH = (BtnH+BtnHS) *(i/4) + BtnY ;
    
    if ( getEndImageYH > myScrollView.frame.size.height ) {
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , getEndImageYH );
    }else{
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , myScrollView.frame.size.height + 1 );
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    if ( [self.view window] == nil ) {
        self.view = nil;
    }
    
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

-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [myImageUrlArr count] ];
    for (int i = 0; i < [myImageUrlArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [myImageUrlArr objectAtIndex:i] ];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}


@end
