/*
 Copyright © 2012, Alex Muller
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "ViewController.h"

@interface ViewController () {
    IBOutlet UILabel *textLabel;
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [[CommandMaster sharedInstance] addToView:self.view andLoadGroup:@"TestGroup"];
    [CommandMaster sharedInstance].delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[CommandMaster sharedInstance] buttonForTitle:@"settings" setEnabled:NO];
}

- (void)didSelectMenuListItemAtIndex:(NSInteger)index ForButton:(CommandButton *)selectedButton {
    textLabel.text = [NSString stringWithFormat:@"index %i of button titled \"%@\"", index, selectedButton.title];
}

- (void)didSelectButton:(CommandButton *)selectedButton {
    textLabel.text = [NSString stringWithFormat:@"button titled \"%@\" was selected", selectedButton.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
