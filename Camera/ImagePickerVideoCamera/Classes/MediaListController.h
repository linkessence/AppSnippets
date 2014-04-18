//
//  MediaListController.h
//  VideoCamera2
//
//  Created by  on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subView.h"
#import "MediaPlayerSubView.h"

@interface MediaListController : UITableViewController <UIWebViewDelegate>
{
    NSDictionary *source;
    UIWebView *myWeb;
    
}

@property(nonatomic, retain) NSDictionary *source;
@property(nonatomic, retain) UIWebView *myWeb;

@end
