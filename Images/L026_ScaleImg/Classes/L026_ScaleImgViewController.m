//
//  L026_ScaleImgViewController.m
//  L026_ScaleImg
//
//  Created by jiaqiu on 11-7-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "L026_ScaleImgViewController.h"

@implementation L026_ScaleImgViewController



-(id)initWithCoder:(NSCoder *)aDecoder{
	
	lastDistance=0;
	return [super initWithCoder:aDecoder];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
	CGPoint p1;
	CGPoint p2;
	CGFloat sub_x;
	CGFloat sub_y;
	CGFloat currentDistance;
	CGRect imgFrame;
	
	NSArray * touchesArr=[[event allTouches] allObjects];
	
    NSLog(@"手指个数%d",[touchesArr count]);
//    NSLog(@"%@",touchesArr);
	
	if ([touchesArr count]>=2) {
		p1=[[touchesArr objectAtIndex:0] locationInView:self.view];
		p2=[[touchesArr objectAtIndex:1] locationInView:self.view];
		
		sub_x=p1.x-p2.x;
		sub_y=p1.y-p2.y;
		
		currentDistance=sqrtf(sub_x*sub_x+sub_y*sub_y);
		
		if (lastDistance>0) {
			
			imgFrame=imageView.frame;
			
			if (currentDistance>lastDistance+2) {
				NSLog(@"放大");
				
				imgFrame.size.width+=10;
				if (imgFrame.size.width>1000) {
					imgFrame.size.width=1000;
				}
				
				lastDistance=currentDistance;
			}
			if (currentDistance<lastDistance-2) {
				NSLog(@"缩小");
				
				imgFrame.size.width-=10;
				
				if (imgFrame.size.width<50) {
					imgFrame.size.width=50;
				}
				
				lastDistance=currentDistance;
			}
			
			if (lastDistance==currentDistance) {
				imgFrame.size.height=imgStartHeight*imgFrame.size.width/imgStartWidth;
                
                float addwidth=imgFrame.size.width-imageView.frame.size.width;
                float addheight=imgFrame.size.height-imageView.frame.size.height;
                
				imageView.frame=CGRectMake(imgFrame.origin.x-addwidth/2.0f, imgFrame.origin.y-addheight/2.0f, imgFrame.size.width, imgFrame.size.height);
			}
			
		}else {
			lastDistance=currentDistance;
		}

	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	lastDistance=0;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	imgStartWidth=imageView.frame.size.width;
	imgStartHeight=imageView.frame.size.height;
	
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
