//
//  TaobanIdeViewController.m
//  LodingBar
//
//  Created by 笑书的钢琴 on 13-8-7.
//  Copyright (c) 2013年 笑书的钢琴. All rights reserved.
//

#import "TaobanIdeViewController.h"
#import "WTStatusBar.h"

@interface TaobanIdeViewController (){
    BOOL isAnimo;
}

@end

@implementation TaobanIdeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
      
}


-(void)viewWillAppear:(BOOL)animated{
    [WTStatusBar setLoading:YES loadAnimated:YES];
    isAnimo = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
  
}

-(IBAction)stopAndClear:(id)sender{
    
    if (isAnimo) {
        [WTStatusBar setLoading:NO loadAnimated:NO];
        [WTStatusBar clearStatus];
        isAnimo = NO;
    }else
    {
        [WTStatusBar setLoading:YES loadAnimated:YES];
          isAnimo = YES;
    }
    
   
}

@end
