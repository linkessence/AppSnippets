//
//  TLViewController.m
//  TLAlertView
//
//  Created by Terry Lewis II on 5/31/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TLViewController.h"
#import "TLAlertView.h"

@interface TLViewController ()

@end

@implementation TLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showView:(id)sender {
    TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"Code4App.com" message:@"Code4App.com是国内最好的iOS源代码收集网站。" confirmButtonTitle:@"确定" cancelButtonTitle:@"取消"];
    
    [alertView handleCancel:^{
        NSLog(@"cancel");
    }         handleConfirm:^{
        NSLog(@"confirm");
    }];
    
    alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
    [alertView show];
}

@end
