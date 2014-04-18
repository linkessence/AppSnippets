//
//  MediaPlayerSubView.m
//  VideoCamera2
//
//  Created by  on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MediaPlayerSubView.h"

@implementation MediaPlayerSubView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSURL *url = [NSURL URLWithString:[myDefault objectForKey:@"temp"]];
        
        MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
                                                
        [self.navigationController pushViewController:playerVC animated:YES];
        [[playerVC moviePlayer] play];
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

@end
