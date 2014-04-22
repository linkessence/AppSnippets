//
//  UIFont+Replacement.m
//  FontReplacer
//
//  Created by Cédric Luthi on 2011-08-08.
//  Copyright (c) 2011 Cédric Luthi. All rights reserved.
//

#import "UIFont+Replacement.h"
#import <objc/runtime.h>

@implementation UIFont (Replacement)

static NSDictionary *replacementDictionary = nil;
static NSString *systemFontName = @"Helvetica";
static NSString *boldSystemFontName = @"Helvetica-Bold";
static NSString *italicSystemFontName = @"Helvetica-Italic";

static void initializeReplacementFonts()
{
	static BOOL initialized = NO;
	if (initialized)
		return;
	initialized = YES;
	
	NSDictionary *replacementDictionary = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ReplacementFonts"];
	[UIFont setReplacementDictionary:replacementDictionary];
}

+ (void) load
{
	Method fontWithName_size_ = class_getClassMethod([UIFont class], @selector(fontWithName:size:));
	Method systemFontOfSize_ = class_getClassMethod([UIFont class], @selector(systemFontOfSize:));
	Method boldSystemFontOfSize_ = class_getClassMethod([UIFont class], @selector(boldSystemFontOfSize:));
	Method italicSystemFontOfSize_ = class_getClassMethod([UIFont class], @selector(italicSystemFontOfSize:));
	Method fontWithName_size_traits_ = class_getClassMethod([UIFont class], @selector(fontWithName:size:traits:));
	Method replacementFontWithName_size_ = class_getClassMethod([UIFont class], @selector(replacement_fontWithName:size:));
	Method replacementFontWithName_size_traits_ = class_getClassMethod([UIFont class], @selector(replacement_fontWithName:size:traits:));
	Method replacementSystemFontOfSize_ = class_getClassMethod([UIFont class], @selector(replacement_systemFontOfSize:));
	Method replacementBoldSystemFontOfSize_ = class_getClassMethod([UIFont class], @selector(replacement_boldSystemFontOfSize:));
	Method replacementItalicSystemFontOfSize_ = class_getClassMethod([UIFont class], @selector(replacement_italicSystemFontOfSize:));

	if (fontWithName_size_ && replacementFontWithName_size_ && strcmp(method_getTypeEncoding(fontWithName_size_), method_getTypeEncoding(replacementFontWithName_size_)) == 0)
		method_exchangeImplementations(fontWithName_size_, replacementFontWithName_size_);
	if (fontWithName_size_traits_ && replacementFontWithName_size_traits_ && strcmp(method_getTypeEncoding(fontWithName_size_traits_), method_getTypeEncoding(replacementFontWithName_size_traits_)) == 0)
		method_exchangeImplementations(fontWithName_size_traits_, replacementFontWithName_size_traits_);

    if (systemFontOfSize_ && replacementSystemFontOfSize_ && strcmp(method_getTypeEncoding(systemFontOfSize_), method_getTypeEncoding(replacementSystemFontOfSize_)) == 0)
		method_exchangeImplementations(systemFontOfSize_, replacementSystemFontOfSize_);
    if (boldSystemFontOfSize_ && replacementBoldSystemFontOfSize_ && strcmp(method_getTypeEncoding(boldSystemFontOfSize_), method_getTypeEncoding(replacementBoldSystemFontOfSize_)) == 0)
		method_exchangeImplementations(boldSystemFontOfSize_, replacementBoldSystemFontOfSize_);
    if (italicSystemFontOfSize_ && replacementItalicSystemFontOfSize_ && strcmp(method_getTypeEncoding(italicSystemFontOfSize_), method_getTypeEncoding(replacementItalicSystemFontOfSize_)) == 0)
		method_exchangeImplementations(italicSystemFontOfSize_, replacementItalicSystemFontOfSize_);
}

+ (UIFont *) replacement_systemFontOfSize:(CGFloat)fontSize
{
    return [self replacement_fontWithName:systemFontName size:fontSize];
}

+ (UIFont *) replacement_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [self replacement_fontWithName:boldSystemFontName size:fontSize];
}

+ (UIFont *) replacement_italicSystemFontOfSize:(CGFloat)fontSize
{
    return [self replacement_fontWithName:italicSystemFontName size:fontSize];
}

+ (UIFont *) replacement_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
	initializeReplacementFonts();
	NSString *replacementFontName = [replacementDictionary objectForKey:fontName];
	return [self replacement_fontWithName:replacementFontName ?: fontName size:fontSize];
}

+ (UIFont *) replacement_fontWithName:(NSString *)fontName size:(CGFloat)fontSize traits:(int)traits
{
	initializeReplacementFonts();
	NSString *replacementFontName = [replacementDictionary objectForKey:fontName];
	return [self replacement_fontWithName:replacementFontName ?: fontName size:fontSize traits:traits];
}

+ (NSDictionary *) replacementDictionary
{
	return replacementDictionary;
}

+ (void) setReplacementDictionary:(NSDictionary *)aReplacementDictionary
{
	if (aReplacementDictionary == replacementDictionary)
		return;
	
	for (id key in [aReplacementDictionary allKeys])
	{
		if (![key isKindOfClass:[NSString class]])
		{
			NSLog(@"ERROR: Replacement font key must be a string.");
			return;
		}
		
		id value = [aReplacementDictionary valueForKey:key];
		if (![value isKindOfClass:[NSString class]])
		{
			NSLog(@"ERROR: Replacement font value must be a string.");
			return;
		}
	}
	
	[replacementDictionary release];
	replacementDictionary = [aReplacementDictionary retain];
	
	for (id key in [replacementDictionary allKeys])
	{
		NSString *fontName = [replacementDictionary objectForKey:key];
		UIFont *font = [UIFont fontWithName:fontName size:10];
		if (!font)
			NSLog(@"WARNING: replacement font '%@' is not available.", fontName);
	}
}

@end
