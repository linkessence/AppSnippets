//
//  RootViewController.h
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-27.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIScrollViewDelegate>
{
    
}

@property (strong, nonatomic) UIScrollView *sv;

@property (strong, nonatomic) UIImageView *iv;

- (void)loadImage:(NSString *)imageURL;



@end
