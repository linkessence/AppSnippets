URBMediaFocusViewController
============

## Overview

`URBMediaFocusViewController` is an experiment to recreate the view used to enlarge photos and videos from their thumbnail previews as seen in [Tweetbot 3](https://itunes.apple.com/app/id722294701) for iOS 7 using the new UIDynamics API available in iOS 7.

![Basic example](https://dl.dropboxusercontent.com/u/197980/Screenshots/URBMediaFocusViewController03.gif)

## Installation

### Installing with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects.

Add the following to your `Podfile` and run `$ pod install`:

	pod "URBMediaFocusViewController"
	
If you don't have CocoaPods installed or integrated into your project, you can learn how to do via [CocoaPods](http://cocoapods.org/).

### Installing Manually

To use `URBMediaFocusViewController` in your own project, just import `URBMediaFocusViewController.h` and `URBMediaFocusViewController.m` files into your project, and then include "`URBMediaFocusViewController.h`" where needed, or in your precompiled header.

The project uses ARC and targets iOS 7.0+.

## Usage Examples

To create an instance of `URBMediaFocusViewController`, just instantiate it the same way you would `UIViewController`, or by simply using `init`:

	self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
	
	/* ...or... */
	self.mediaFocusController = [[URBMediaFocusViewController alloc] initWithNibName:nil bundle:nil];

The standard usage of `URBMediaFocusViewController` is to use it for displaying full-size photos over an existing view. In most cases, you would use it from a smaller thumbnail view of the photo you wish to show an enlarged version for. You can either display a photo that already exists locally within your project, or load the full-size image from a remote URL asynchronously using `NSURLConnection`.

The standard method would be to load your thumbnail images first, then request their full sizes when displaying the media focus view:
	
	NSURL *url = [NSURL URLWithString:@"http://apollo.urban10.net/random/oiab/01.jpg"];
	[self.mediaFocusController showImageFromURL:url fromView:self.thumbnailView];

The following is a basic example of showing an image that is linked into your project locally:

	[self.mediaFocusController showImage:[UIImage imageNamed:@"seattle01.jpg"] fromView:self.thumbnailView];
	
In most cases, you would present `URBMediaFocusViewController` from your app's key window, which is the default implementation. However, in some cases you may want to present your `URBMediaFocusViewController` view from a specific view controller. You can provide a parent view controller in those cases, and the `URBMediaFocusViewController` instance will be added on top of that controller's view:

	[self.mediaFocusController showImageFromURL:url fromView:self.thubmnailView inViewController:self];

## Customization

Most of the customization options included within this component are related to animation and physics, all of which are stored as static variables in `URBMediaFocusViewController.m` and can be quickly edited to achieve your desired effect.

By default, parallax and blur effects are enabled. To disable one or both effects, just set the following properties on your instance:

	self.parallaxEnabled = NO;
	self.shouldBlurBackground = NO;

Note that currently if you disable the parallax effect, the background blur will also be disabled.

By default, tapping on the image will not dismiss the focus view, but tapping outside of the image bounds will. You can change this by setting `shouldDismissOnTap` to `YES` on your `URBMediaFocusViewController` instance, which will allow tapping directly on the image to dismiss:

	self.shouldDismissOnTap = YES;

## TODO

- ~~Add CocoaPods spec~~ (added 11/15/2013)
- Support for handling device orientation changes
- Support for focusing in image from a web view (issue #6)
- Add support for loading videos similar to the method for remote photos
- Consider adding support for additional present/dismiss transition animations

## License

This code is distributed under the terms and conditions of the MIT license.