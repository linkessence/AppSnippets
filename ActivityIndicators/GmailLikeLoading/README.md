## GmailLikeLoading ##

Gmail iOS app like Loading view. 

Completely created using core animation.

Easy to drop into your project like a UIView.

You can resize the frame to whatever size.


## How to use ##
	
Drag GmailLikeLoadingView.h amd GmailLikeLoadingView.m files to your project.

Required framework: QuartzCore.framework

	#import "GmailLikeLoadingView.h"

	GmailLikeLoadingView *loadingView = [[GmailLikeLoadingView alloc] initWithFrame:CGRectMake(x, y, width, height)];

	[self addSubview:loadingView];

	[loadingView startAnimating];

### To stop animating: ###

	[loadingView stopAnimating];

### To Check view is animating: ###

	[loadingView isAnimating];


## How it looks ##

![GmailLikeLoading] (http://nikhilgohil11.com/github/GmailLikeLoading.gif)

## Lincense ##

[MIT License] (http://raweng.mit-license.org/ "MIT License")
