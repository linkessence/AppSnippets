//
//  NearFriendsController.m
//  WebImagesLazyLoadDemo
//
//  Created by Reese on 13-4-5.
//  Copyright (c) 2013年 Himalayas Technology Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import "NearFriendsController.h"
#import "NearCollectionCell.h"
#define MAX_USER 2000

@interface NearFriendsController ()

@end

@implementation NearFriendsController

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
    
    [_myNotes setCenter:CGPointMake(160, CGRectGetHeight(self.view.bounds)/2)];
    
    
    currentUsers=[[NSMutableArray alloc]init];
    cachedPics =[[NSMutableDictionary alloc]init];
    twoKUsers=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"2000用户测试数据NearMeFriend" ofType:@"plist"]];
    [twoKUsers retain];
    //先读96条
    for ( flag=0; flag<96; flag++) {
        [currentUsers addObject:[twoKUsers objectAtIndex:flag]];
    }
    
    [_friendsTable reloadData];
    
    NSLog(@" ");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)regetList
{
    if (flag+96<MAX_USER) {
        for (int i=flag; i<flag+96; i++) {
            [currentUsers addObject:[twoKUsers objectAtIndex:i]];
        }
        flag+=96;
    [_friendsTable reloadData];
    }
    return;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [currentUsers count]/4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (currentUsers.count!=0) {
        return 45;
    }
    else return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"collectCell";
    static BOOL nibregister = NO;
    if (!nibregister) {
        [tableView registerNib:[UINib nibWithNibName:@"NearCollectionCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        
        //nibregister=YES;
    }
    NearCollectionCell *cell = (NearCollectionCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell=[[[NearCollectionCell alloc]init]autorelease];
    }
    
    
    NSDictionary *user1=[currentUsers objectAtIndex:indexPath.row*4];
    NSDictionary *user2=[currentUsers objectAtIndex:indexPath.row*4+1];
    NSDictionary *user3=[currentUsers objectAtIndex:indexPath.row*4+2];
    NSDictionary *user4=[currentUsers objectAtIndex:indexPath.row*4+3];
    
    NSURL *headUrl=[NSURL URLWithString:[user1 objectForKey:@"head"]];
    if (hasCachedImage(headUrl)) {
        if ([cachedPics objectForKey:hashCodeForURL(headUrl)]!=nil) {
            [cell.aHead setImage:[cachedPics objectForKey:hashCodeForURL(headUrl)]];
        }else{
            [cell.aHead setImage:[UIImage imageWithContentsOfFile:pathForURL(headUrl)]];
            [cachedPics setObject:[UIImage imageWithContentsOfFile:pathForURL(headUrl)] forKey:hashCodeForURL(headUrl)];
        }
        
        
    }else
    {
        
        [cell.aHead  setImage:[UIImage imageNamed:@"defaultPerson"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:headUrl,@"url",cell.aHead ,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    headUrl=[NSURL URLWithString:[user2 objectForKey:@"head"]];
    if (hasCachedImage(headUrl)) {
        
        if ([cachedPics objectForKey:hashCodeForURL(headUrl)]!=nil) {
            [cell.bHead setImage:[cachedPics objectForKey:hashCodeForURL(headUrl)]];
        }else
        {
            [cell.bHead setImage:[UIImage imageWithContentsOfFile:pathForURL(headUrl)]];
            [cachedPics setObject:[UIImage imageWithContentsOfFile:pathForURL(headUrl)] forKey:hashCodeForURL(headUrl)];
        }
        
        
    }else
    {
        
        [cell.bHead  setImage:[UIImage imageNamed:@"defaultPerson"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:headUrl,@"url",cell.bHead ,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    headUrl=[NSURL URLWithString:[user3 objectForKey:@"head"]];
    if (hasCachedImage(headUrl)) {
        if ([cachedPics objectForKey:hashCodeForURL(headUrl)]!=nil) {
            [cell.cHead setImage:[cachedPics objectForKey:hashCodeForURL(headUrl)]];
        }else
        {
            [cell.cHead setImage:[UIImage imageWithContentsOfFile:pathForURL(headUrl)]];
            [cachedPics setObject:[UIImage imageWithContentsOfFile:pathForURL(headUrl)] forKey:hashCodeForURL(headUrl)];
        }
        
    }else
    {
        
        [cell.cHead  setImage:[UIImage imageNamed:@"defaultPerson"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:headUrl,@"url",cell.cHead ,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    headUrl=[NSURL URLWithString:[user4 objectForKey:@"head"]];
    if (hasCachedImage(headUrl)) {
        if ([cachedPics objectForKey:hashCodeForURL(headUrl)]!=nil) {
            [cell.dHead setImage:[cachedPics objectForKey:hashCodeForURL(headUrl)] ];
        }else
        {
            [cell.dHead setImage:[UIImage imageWithContentsOfFile:pathForURL(headUrl)]];
            [cachedPics setObject:[UIImage imageWithContentsOfFile:pathForURL(headUrl)] forKey:hashCodeForURL(headUrl)];
        }
        
    }else
    {
        
        [cell.dHead  setImage:[UIImage imageNamed:@"defaultPerson"]];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:headUrl,@"url",cell.dHead ,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
        
    }
    
    NSLog(@"目前内存中的头像数：%d",[cachedPics.allValues count]);
    return cell;
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}



- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (currentUsers.count!=0) {
        UIButton *loadBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [loadBut setImage:[UIImage imageNamed:@"LoadMoreBG"] forState:UIControlStateNormal];
        [loadBut addTarget:self action:@selector(regetList) forControlEvents:UIControlEventTouchUpInside];
        UILabel *text=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,45)];
        text.text=@"加载更多";
        [text setTextColor:[UIColor whiteColor]];
        [text setShadowColor:[UIColor blackColor]];
        [text setShadowOffset:CGSizeMake(1, 1)];
        text.font=[UIFont boldSystemFontOfSize:20];
        //text.textAlignment=UITextAlignmentCenter;
        [text setContentMode:UIViewContentModeCenter];
        text.backgroundColor=[UIColor clearColor];
        [loadBut addSubview:text];
        [text release];
        
        return loadBut;
    }
    else return nil;
}



- (void)dealloc {
    [twoKUsers release];
    [cachedPics release];
    [currentUsers release];
    [_friendsTable release];
    [_myNotes release];
    [_toggle release];
    [super dealloc];
}
- (IBAction)goTop:(id)sender {
    [_friendsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (IBAction)goBottom:(id)sender {
    [_friendsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[currentUsers count]/4-1  inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (IBAction)toggleButton:(id)sender {
    if (_myNotes.superview==nil) {
        [self.view addSubview:_myNotes];
        [_toggle setTitle:@"关闭" forState:UIControlStateNormal];
    }else
    {
        [_myNotes removeFromSuperview];
        [_toggle setTitle:@"作者的备注" forState:UIControlStateNormal];
    }
}
@end
