/*
 Copyright (c) 2013 Katsuma Tanaka
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>

@class QBPopupMenu;

@interface QBPopupMenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIView *customView;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, assign, getter = isEnabled) BOOL enabled;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, retain) UIFont *font;

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (id)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;
+ (id)itemWithCustomView:(UIView *)customView target:(id)target action:(SEL)action;

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action;
- (id)initWithCustomView:(UIView *)customView target:(id)target action:(SEL)action;

- (CGSize)actualSize;
- (UIFont *)actualFont;
- (void)performAction;

@end
