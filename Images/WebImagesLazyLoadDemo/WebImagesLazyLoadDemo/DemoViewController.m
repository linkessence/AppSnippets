//
//  DemoViewController.m
//  WebImagesLazyLoadDemo
//
//  Created by Reese on 13-4-4.
//  Copyright (c) 2013年 Himalayas Technology Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import "DemoViewController.h"
#define CAR_BRANDS_API [NSURL URLWithString:@"http://www.aapinche.cn:8080/aapinche/route/car_brands"]


@interface DemoViewController ()

@end

@implementation DemoViewController

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
    brandsList =[[NSMutableArray alloc]init];
    ASIFormDataRequest *asi=[[ASIFormDataRequest alloc]initWithURL:CAR_BRANDS_API];
    [asi setStringEncoding:NSUTF8StringEncoding];
    [asi setTimeOutSeconds:100];
    [asi setDelegate:self];
    [asi startAsynchronous];
    [asi release];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *jsonString=[request responseString];
    SBJsonParser *parser=[[[SBJsonParser alloc]init]autorelease];
    NSError *err=nil;
    NSMutableDictionary *rootDic=[parser objectWithString:jsonString error:&err];
    if (err) {
        NSLog(@"%@",[err localizedDescription]) ;
    }
    brandsList=[rootDic objectForKey:@"cars"];
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [brandsList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"Cell";
    
    static BOOL nibregister = NO;
    
    if (!nibregister) {
        [tableView registerNib:[UINib nibWithNibName:@"CarBrandsCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    
    CarBrandsCell *cell =(CarBrandsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[CarBrandsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier]autorelease];
    }
    NSDictionary *brand = [brandsList objectAtIndex:[indexPath row]];
    
    NSString *carString=[brand objectForKey:@"image"];
    carString=[carString stringByReplacingOccurrencesOfString:@" " withString:@""];;
    carString=[carString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *imgUrl=[NSURL URLWithString:carString];
    if (hasCachedImage(imgUrl)) {
        
        [cell.brandImage setImage:[UIImage imageWithContentsOfFile:pathForURL(imgUrl)]];
        
    }else
    {
        
        [cell.brandImage setImage:[UIImage imageNamed:@"icon"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:imgUrl,@"url",cell.brandImage,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    
    NSString *brandName = [brand objectForKey:@"name"];
    cell.brandLabel.text=brandName;
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    return cell;
}



- (void)dealloc {
    [brandsList release];
    [_mainTable release];
    [super dealloc];
}
- (IBAction)clearAllCaches:(id)sender {
    [[NSFileManager defaultManager] removeItemAtPath:pathInCacheDirectory(@"com.xmly") error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:pathInCacheDirectory(@"com.xmly") withIntermediateDirectories:YES attributes:nil error:nil];
}

- (IBAction)setFlip:(id)sender {
    [[ImageCacher defaultCacher]setFlip];
}

- (IBAction)setFade:(id)sender {
    [[ImageCacher defaultCacher]setFade];
}

- (IBAction)setCube:(id)sender {
    [[ImageCacher defaultCacher]setCube];
}
@end
