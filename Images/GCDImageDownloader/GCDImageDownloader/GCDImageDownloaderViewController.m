//
//  GCDImageDownloaderViewController.m
//  GCDImageDownloader
//
//  Created by Slava on 5/22/11.
//  Copyright 2011 Alterplay. All rights reserved.
//

#import "GCDImageDownloaderViewController.h"
#import "UIImageView+DispatchLoad.h"

@interface GCDImageDownloaderViewController()
- (void) initImageArray;
- (void) downloadRandomImage;
@end

@implementation GCDImageDownloaderViewController

- (void)dealloc
{
    [_images release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initImageArray];
    
    for (int i=0; i<1000; i++) {
        [self downloadRandomImage];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Image Management

- (void) initImageArray {
    _images = [[NSArray arrayWithObjects:
                @"http://farm6.static.flickr.com/5094/5464787611_642ee9280d_m.jpg",
                @"http://farm5.static.flickr.com/4078/4861715526_6ccb2b9a19_m.jpg",
                @"http://farm6.static.flickr.com/5143/5643450822_93fe951bd1_m.jpg",
                @"http://farm6.static.flickr.com/5030/5605213905_a7124c8f23_m.jpg",
                @"http://farm6.static.flickr.com/5084/5351625889_ecce70eb4a_m.jpg",
                @"http://farm5.static.flickr.com/4098/4940540425_7d562e1e2d_m.jpg",
                @"http://farm6.static.flickr.com/5182/5644429692_aa5499bfca_m.jpg",
                @"http://farm2.static.flickr.com/1077/5101973016_1c1675b17a_m.jpg",
                @"http://farm4.static.flickr.com/3147/3109786067_9994b32727_m.jpg",
                @"http://farm6.static.flickr.com/5147/5643154294_fdbc9b249f_m.jpg",
                @"http://farm6.static.flickr.com/5048/5351303637_2cedcbe403_m.jpg",
                @"http://farm6.static.flickr.com/5162/5348855106_14ea0da091_m.jpg",
                @"http://farm6.static.flickr.com/5004/5335600202_be33b46608_m.jpg",
                @"http://farm6.static.flickr.com/5002/5332760342_da7cc2c34b_m.jpg",
                @"http://farm6.static.flickr.com/5088/5338153683_d08b8e24e7_m.jpg",
                @"http://farm6.static.flickr.com/5282/5341981199_6b173c5c42_m.jpg",
                @"http://farm6.static.flickr.com/5042/5345973796_0f4b3acb37_m.jpg",
                nil] retain];
}

- (void) downloadRandomImage {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.center = CGPointMake(rand()%(int)self.view.frame.size.width, rand()%(int)self.view.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin;
    imageView.transform = CGAffineTransformScale(imageView.transform, 0.01, 0.01);
    
    [imageView setImageFromUrl:[_images objectAtIndex:(rand()%_images.count)]
                    completion:^(void) {

                        [UIView animateWithDuration:3.0 animations:^(void) {
                                             imageView.alpha = 0.0;
                                             imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
                                         } completion:^(BOOL finished) {
                                             [imageView removeFromSuperview];
                                         }];
                    }
     ];
    
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    [imageView release];
}

@end