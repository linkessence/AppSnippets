//
//  ViewController.m
//  ImageWithWaterMark
//
//  Created by Melo on 13-5-2.
//  Copyright (c) 2013年 Melo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
	加载视图
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 140)];
    
    UIImage *useImage = [[UIImage alloc] init];
    useImage = [UIImage imageNamed:@"useImage.png"];
    
//加文字
//    [imgView setImage:[self addText:useImage text:@"code4app.com"]];

//加图片
//    [imgView setImage:[self addImageLogo:useImage text:[UIImage imageNamed:@"logo.png"]]];

//加半透明水印
    [imgView setImage:[self addImage:useImage addMsakImage:[UIImage imageNamed:@"logo.png"]]];
    
    [self.view addSubview:imgView];
    [useImage release];
    [imgView release];
}

/**
	加文字随意
	@param img 需要加文字的图片
	@param text1 文字描述
	@returns 加好文字的图片
 */
-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
    
    int w = 300;
    int h = 140;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 15, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 255, 255, 0.8);
    
    //位置调整
    CGContextShowTextAtPoint(context, w/2-strlen(text)*4.5 , h - 135, text, strlen(text));
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

/**
	加图片水印
	@param img 需要加logo图片的图片
	@param logo logo图片
	@returns 加好logo的图片  
 */
-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth, 0, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}

/**
	加半透明水印
	@param useImage 需要加水印的图片
	@param addImage1 水印
	@returns 加好水印的图片
 */
- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
//    [addImage1 drawInRect:CGRectMake(0, useImage.size.height-addImage1.size.height, addImage1.size.width, addImage1.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:CGRectMake(useImage.size.width - 110, useImage.size.height-25, 100, 25)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
