//
//  HCPictureViewController.m
//  FMDBDemo
//
//  Created by Reese on 13-10-29.
//  Copyright (c) 2013年 Reese@objcoder.com. All rights reserved.
//

#import "HCPictureViewController.h"
#import "UIImageView+RZWebImage.h"
#import "HCFirendCell.h"


@interface HCPictureViewController ()

@end

@implementation HCPictureViewController

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
    userList=[NSArray array];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadPic:(id)sender {

    [self beginDownLoad];
    
    
}
UIImage *headImage;
-(void)beginDownLoad
{
    NSString *plistPath=[[NSBundle mainBundle]pathForResource:@"2000用户测试数据NearMeFriend" ofType:@"plist"];
    
    userList=[NSArray arrayWithContentsOfFile:plistPath];
    [_userTable reloadData];


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden=@"headCell";
    HCFirendCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell=[[HCFirendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    NSDictionary *dic=userList[indexPath.row];
    NSURL *url=[NSURL URLWithString:[dic objectForKey:@"head"]];
    [cell.headImage setWebImage:url placeHolder:[UIImage imageNamed:@"墨半成霜.jpg"] downloadFlag:indexPath.row];
    [cell.headImage setTag:indexPath.row];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
