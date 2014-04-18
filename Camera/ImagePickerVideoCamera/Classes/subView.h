//
//  subView.h
//  VideoCamera2
//
//  Created by  on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subView : UIViewController<UIWebViewDelegate>{
    UIWebView *myWeb;

}

@property (nonatomic, retain) IBOutlet UIWebView *myWeb;


@end
