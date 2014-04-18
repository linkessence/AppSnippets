//
//  ViewController.m
//  ButtonBoardTest
//
//  Created by 孙 化育 on 13-8-28.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "ViewController.h"
#import "SUNButtonBoard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    [_fButton release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_textField release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardButtonClick:) name:SUNButtonBoarButtonClickNotification object:nil];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTaped:)];
    [self.view addGestureRecognizer:gesture];
    [gesture release];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)fButtonAction:(UIButton *)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)presentButton:(UIButton *)sender {
    ViewController *vc = [[ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)dissmissButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)boardButtonClick:(NSNotification *)nofi{
    NSNumber *num = [nofi object];
    switch ([num intValue]) {
        case 0:
            self.view.backgroundColor = [UIColor redColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        default:
            break;
            
    }
}


- (void)backgroundTaped:(UITapGestureRecognizer *)ges{
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
