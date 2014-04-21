//
//  TranslucentViewController.m
//  Translucent
//
//  Created by 谢伟 on 11-2-14.
//  Copyright 2011 易联伟达 www.e-linkway.com. All rights reserved.
//

#import "TranslucentViewController.h"
#import "ELTranslucentView.h"

@implementation TranslucentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    ELTranslucentView *translucentView = [[ELTranslucentView alloc] initWithFrame: CGRectMake(0, 50, 1024, 629)];
    translucentView.backgroundImage = [UIImage imageNamed: @"car1"];
    translucentView.translucentImage = [UIImage imageNamed: @"car2"];
	translucentView.moveMinY = 80;
    [self.view addSubview: translucentView];
	

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(600, 590, 800, 50)];
	label.text = @"北京易联伟达科技有限公司";
	label.font = [UIFont boldSystemFontOfSize: 30];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor grayColor];
	label.alpha = 0.8;
	[self.view addSubview:label];
	
	label = [[UILabel alloc] initWithFrame:CGRectMake(600, 600, 800, 150)];
	label.text = @"电 话: 010－57736785\n网 址: http://www.e-linkway.com\n邮 箱: info@e-linkway.com";
	label.numberOfLines = 3;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor grayColor];
	label.alpha = 0.8;
	label.font = [UIFont systemFontOfSize: 20]; //[UIFont fontWithName:@"TrebuchetMS" size:30];
	[self.view addSubview:label];

	label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1024, 120)];
	label.alpha = 1.0;
	label.backgroundColor = [UIColor lightGrayColor];
	[self.view addSubview:label];
	
	UIImageView *_logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_shadow.png"]];
	_logoImage.frame = CGRectMake(800, 20, 216 * 0.8, 104 * 0.8);
	[self.view addSubview:_logoImage];

	label = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, 800, 50)];
	//label = [[UILabel alloc] initWithFrame:CGRectMake(60, 640, 800, 50)];
	label.text = @"透  视  图  模  块";
	label.alpha = 0.6;
	label.font = [UIFont boldSystemFontOfSize: 46]; //[UIFont fontWithName:@"TrebuchetMS" size:30];
	label.backgroundColor = [UIColor clearColor];
	[self.view addSubview:label];
	
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
	|| (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
	;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
