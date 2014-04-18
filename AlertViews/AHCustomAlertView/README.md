# AHAlertView

## Overview

`AHAlertView` is a powerful, block-based alternative to UIKit's `UIAlertView`. It has the following attractive features:

 1. Block-based button events - no more messy delegate code
 2. `UIAppearance` conformance to allow easy skinning of all elements
 3. Additional presentation and dismissal animations (tumble, fade, zoom, etc.)

Showing an alert is as simple as creating an alert, adding a button, and showing the alert:

    AHAlertView *alert = [[AHAlertView alloc] initWithTitle:@"Hello, World!" message:@"I'm an alert view!"];
    [alert setCancelButtonTitle:@"Dismiss" block:nil];
    [alert show];

You can use the block you pass in with the button title to perform any action, including setting a custom dismissal animation based on which button was touched:

    [alert setCancelButtonTitle:@"Cancel" block:^{
	    alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
    }];

## TODO

 - Currently, only the default style (title and message) is available. Styles with text fields or an activity indicator are planned.
 - The layout code is monolithic and inflexible. It needs to be cleaned up.
 - I think we can all agree a little more documentation would be nice.