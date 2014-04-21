//
//  DemoViewController.h
//  WebImagesLazyLoadDemo
//
//  Created by Reese on 13-4-4.
//  Copyright (c) 2013年 Himalayas Technology Company CO.,LTD-重庆喜玛拉雅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "CarBrandsCell.h"

@interface DemoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>
{
    NSMutableArray *brandsList;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
- (IBAction)clearAllCaches:(id)sender;
- (IBAction)setFlip:(id)sender;
- (IBAction)setFade:(id)sender;
- (IBAction)setCube:(id)sender;

@end
