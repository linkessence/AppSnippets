//
//  HCPictureViewController.h
//  FMDBDemo
//
//  Created by Reese on 13-10-29.
//  Copyright (c) 2013年 Reese@objcoder.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCPictureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *userList;
}
- (IBAction)downloadPic:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *userTable;


@end
