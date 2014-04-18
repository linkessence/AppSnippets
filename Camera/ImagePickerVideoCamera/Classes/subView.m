//
//  subView.m
//  VideoCamera2
//
//  Created by  on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "subView.h"

@implementation subView

@synthesize myWeb;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:[myDefault objectForKey:@"temp"]];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWeb setDelegate:self];
    [myWeb loadRequest:request];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -
#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"......");
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finish");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error");
}


@end
