//
//  LeftController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftController.h"
#import "FeedController.h"
#import "DDMenuController.h"

@implementation LeftController

@synthesize tableView=_tableView;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    /* 
     * Content in this cell should be inset the size of kMenuOverlayWidth
     */
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row];
    
    return cell;
    
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Left Controller";
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // set the root controller
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    FeedController *controller = [[FeedController alloc] init];
    controller.title = [NSString stringWithFormat:@"Cell %i", indexPath.row];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];

    [menuController setRootController:navController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}



@end
