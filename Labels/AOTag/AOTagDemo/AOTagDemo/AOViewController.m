//
//  AOViewController.m
//  AOTagDemo
//
//  Created by Loïc GRIFFIE on 24/09/13.
//  Copyright (c) 2013 Appsido. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AOViewController.h"
#import "AOTag.h"

@interface AOViewController ()

@property (retain) AOTagList *tag;
@property (retain) NSMutableArray *randomTag;

@end

@implementation AOViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetRandomTagsName];
    
    self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0.0f,
                                                           50.0f,
                                                           320.0f,
                                                           300.0f)];
    
    [self.tag setDelegate:self];
    [self.view addSubview:self.tag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetRandomTagsName
{
    [self.tag removeAllTag];
    
    self.randomTag = [NSMutableArray arrayWithArray:@[@{@"title": @"Tyrion", @"image": @"tyrion.jpg"}, @{@"title": @"Jaime", @"image": @"jaime.jpg"}, @{@"title": @"Robert", @"image": @"robert.jpg"}, @{@"title": @"Sansa", @"image": @"sansa.jpg"}, @{@"title": @"Arya", @"image": @"arya.jpg"}, @{@"title": @"Jon", @"image": @"john.jpg"}, @{@"title": @"Catelyn", @"image": @"catherine.jpg"}, @{@"title": @"Cersei", @"image": @"cersei.jpg"}]];
}

- (NSUInteger)getRandomTagIndex
{
    return arc4random() % [self.randomTag count];
}

- (IBAction)addRandomTag:(id)sender
{
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"] withImage:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]];
        [self.randomTag removeObjectAtIndex:index];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)addRandomTagWithDistantImage:(id)sender
{
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"] withImageURL:[NSURL URLWithString:@"https://identicons.github.com/e45c2d792a22e0ebe8488d42f4dc22d5.png"] andImagePlaceholder:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]];
        [self.randomTag removeObjectAtIndex:index];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)addCustomColorTag:(id)sender
{
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor greenColor], [UIColor yellowColor]];
    
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"]
               withImage:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]
          withLabelColor:[UIColor blackColor]
     withBackgroundColor:[colors objectAtIndex:arc4random() % [colors count]]
    withCloseButtonColor:[UIColor whiteColor]];
        
        [self.randomTag removeObjectAtIndex:index];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)addCustomColorTagWithDistantImage:(id)sender
{
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor greenColor], [UIColor yellowColor]];
    
    if ([self.randomTag count])
    {
        NSInteger index = [self getRandomTagIndex];
        
        [self.tag addTag:[[self.randomTag objectAtIndex:index] valueForKey:@"title"]
               withImagePlaceholder:[[self.randomTag objectAtIndex:index] valueForKey:@"image"]
            withImageURL:[NSURL URLWithString:@"https://identicons.github.com/e45c2d792a22e0ebe8488d42f4dc22d5.png"]
          withLabelColor:[UIColor blackColor]
     withBackgroundColor:[colors objectAtIndex:arc4random() % [colors count]]
    withCloseButtonColor:[UIColor whiteColor]];
        
        [self.randomTag removeObjectAtIndex:index];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                        message:@"No more random data to be used !"
                                                       delegate:self
                                              cancelButtonTitle:@"Reset"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)addAllTag:(id)sender
{
    [self resetRandomTagsName];
    
    [self.tag addTags:self.randomTag];
    
    [self.randomTag removeAllObjects];
}

- (IBAction)removeAllTag:(id)sender
{
    [self resetRandomTagsName];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self resetRandomTagsName];
}

#pragma mark - Tag delegate

- (void)tagDidAddTag:(AOTag *)tag
{
    NSLog(@"Tag > %@ has been added", tag);
}

- (void)tagDidRemoveTag:(AOTag *)tag
{
    NSLog(@"Tag > %@ has been removed", tag);
}

- (void)tagDidSelectTag:(AOTag *)tag
{
    NSLog(@"Tag > %@ has been selected", tag);
}

#pragma mark - Tag delegate

- (void)tagDistantImageDidLoad:(AOTag *)tag
{
    NSLog(@"Distant image has been downloaded for tag > %@", tag);
}

- (void)tagDistantImageDidFailLoad:(AOTag *)tag withError:(NSError *)error
{
    NSLog(@"Distant image has failed to download > %@ for tag > %@", error, tag);
}

@end
