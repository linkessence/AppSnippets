//
//  NearFriendsController.h
//  WebImagesLazyLoadDemo
//
//  Created by Reese on 13-4-5.
//  Copyright (c) 2013年 Himalayas Technology Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearFriendsController : UIViewController
{
    NSMutableArray *currentUsers;
    NSMutableDictionary *cachedPics;
    NSArray *twoKUsers;
    int flag;
}
@property (retain, nonatomic) IBOutlet UITableView *friendsTable;
@property (retain, nonatomic) IBOutlet UIView *myNotes;
- (IBAction)goTop:(id)sender;
- (IBAction)goBottom:(id)sender;
- (IBAction)toggleButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *toggle;

@end
