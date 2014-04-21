Keyboard TextField Manager
==========================

Often while developing an app, We ran into an issues where the iPhone UIKeyboard slide up and cover the `UITextField/UITextView`.

## Screen Shot
[![image](./KeyboardTextFieldDemo/Screenshot/IQKeyboardManagerScreenshot.png)](http://youtu.be/6nhLw6hju2A)

## Video

<a href="http://www.youtube.com/watch?feature=player_embedded&v=6nhLw6hju2A
" target="_blank"><img src="http://img.youtube.com/vi/6nhLw6hju2A/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>


Installation
==========================

Cocoapod
---
IQKeyboardManager is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod 'IQKeyboardManager', '~>3.0.0'

Framework:-
---
Link your project against `KeyboardManager.framework` found in "KeyboardManagerFramework" directory. Drag and drop the resource bundle `IQKeyboardManager.bundle` found in same directory. add `-ObjC` flag in `other linker flag`. That's it. No need to write any single line of code.

Source Code:-
---
Just drag and drop `IQKeyBoardManager` directory from demo project to your project. That's it. No need to write any single line of code. It will enable automatically.

Properties and functions usage:-
---
1)	@method +sharedManager;
Returns the default singleton instance.

2)	@property enable;
Use this to enable/disable managing distance between keyboard & textField/textView).

3)	@property keyboardDistanceFromTextField
Set Distance between keyboard & textField. Can't be less than zero. Default is 10.

4)	@property enableAutoToolbar
Enable autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard. Default is YES.

5)	@property canAdjustTextView
Giving permission to modify TextView's frame. Adjust textView's frame when it is too big in height. Default is NO.

6)	@property shouldResignOnTouchOutside
Resign textField if touched outside of UITextField/UITextView.

7)	@property shouldShowTextFieldPlaceholder
If YES, then it add the textField's placeholder text on IQToolbar. Default is YES.

8)	@property shouldPlayInputClicks
If YES, then it plays inputClick sound on next/previous/done click. Default is NO.

9)	@property toolbarUsesCurrentWindowTintColor
If YES, then uses textField's tintColor property for IQToolbar, otherwise tintColor is black. Default is NO.

10)	@property toolbarManageStyle
Setting toolbar behaviour to IQAutoToolbarBySubviews to manage previous/next according to UITextField's hierarchy in it's SuperView. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order. Default is IQAutoToolbarBySubviews.

11)	@method -resignFirstResponder
Resigns currently first responder field.



If you don't want to import these files you can use an older version of `IQKeyboardManager` in Tag 2.6.

## Feature:-

 1) Support Device Orientation.
 
 2) Enable/Disable Keyboard Manager when needed with `enable` boolean.

 3) Easiest integration.

 4) AutoHandle UIToolbar as a accessoryInputView of textField/textView with `enableAutoToolbar` boolean.

 5) AutoHandle UIToolbar can be manged by superview's hierarchy or can be managed by tag property of textField/textView using `toolbarManageBehaviour` enum.

 6) `UIView` Category for easily adding Next/Previous and Done button as Keyboard UIToolBar, even automatic with `enableAutoToolbar` boolean.

 7) Enable/Disable Next/Previous buttons with Category methods, even automatic with `enableAutoToolbar` boolean.

 8) Set keyboard distance from textFields using `keyboardDistanceFromTextField`.
 
 9) Resign keyboard on touching outside using `shouldResignOnTouchOutside`.
 
 10) Manage UITextView's frame when it's hight is too large to fit on screen with `canAdjustTextView` boolean.
 
 11) Can manage `UITextField/UITextView` inside `UITableView/UIScrollView`.
 
 12) Can play input sound on Next/Previous/Done click.

LICENSE
---
Distributed under the MIT License.

Contributions
---
Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

Author
---
If you wish to contact me, email at: hack.iftekhar@gmail.com

