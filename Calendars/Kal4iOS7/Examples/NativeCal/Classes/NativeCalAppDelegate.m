/*
 * Copyright (c) 2010 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "NativeCalAppDelegate.h"
#import "EventKitDataSource.h"
#import "Kal.h"
#import "NSDate+Convenience.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation NativeCalAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    /*
     *    Kal Initialization
     *
     * When the calendar is first displayed to the user, Kal will automatically select today's date.
     * If your application requires an arbitrary starting date, use -[KalViewController initWithSelectedDate:]
     * instead of -[KalViewController init].
     */
   
//#define Single
#ifdef Single
    kal = [[KalViewController alloc] initWithSelectionMode:KalSelectionModeSingle];
    kal.selectedDate = [NSDate dateStartOfDay:[[NSDate date] offsetDay:1]];
#else
    kal = [[KalViewController alloc] initWithSelectionMode:KalSelectionModeRange];
    kal.beginDate = [NSDate dateStartOfDay:[NSDate date]];
    kal.endDate = [NSDate dateStartOfDay:[[NSDate date] offsetDay:1]];
#endif
    
    kal.title = @"NativeCal";
    
    /*
     *    Kal Configuration
     *
     */
    kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Today", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
    kal.delegate = self;
    dataSource = [[EventKitDataSource alloc] init];
    kal.dataSource = dataSource;
    kal.minAvailableDate = [NSDate dateStartOfDay:[[NSDate date] offsetDay:-5]];
    kal.maxAVailableDate = [kal.minAvailableDate offsetDay:30];
    
    // Setup the navigation stack and display it.
    navController = [[UINavigationController alloc] initWithRootViewController:kal];
    window.rootViewController = navController;
    [window makeKeyAndVisible];
}

// Action handler for the navigation bar's right bar button item.
- (void)showAndSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Display a details screen for the selected event/row.
    EKEventViewController *vc = [[EKEventViewController alloc] init];
    vc.event = [dataSource eventAtIndexPath:indexPath];
    vc.allowsEditing = NO;
    [navController pushViewController:vc animated:YES];
}

#pragma mark -


@end
