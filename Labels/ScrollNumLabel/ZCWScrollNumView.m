//
//  ZCWScrollNumView.m
//  车险达人
//
//  Created by zangcw on 12-9-6.
//  Copyright (c) 2012年 ZCW. All rights reserved.
//

#import "ZCWScrollNumView.h"

#define kRandomLength        10
#define kDefaultDigitFont   [UIFont systemFontOfSize:14.0]

@implementation ZCWScrollDigitView

@synthesize backgroundView;
@synthesize label;
@synthesize digit;
@synthesize digitFont;
- (void)setDigitAndCommit:(NSUInteger)aDigit {
    self.label.text = [NSString stringWithFormat:@"%d", aDigit];
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight;
    self.label.numberOfLines = 1;
    self.label.frame = rect;
    digit = aDigit;
}
- (void)setDigit:(NSUInteger)aDigit from:(NSUInteger)last{
    if (aDigit == last) {
        [self setDigitAndCommit:aDigit];
        return;
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%d", last];
    int count = 1;
    if (aDigit > last) {
        for (int i = last + 1; i < aDigit + 1; ++i) {
            ++count;
            [str appendFormat:@"\n%d", i];
        }
    } else {
        for (int i = last + 1; i < 10; ++i) {
            ++count;
            [str appendFormat:@"\n%d", i];
        }
        for (int i = 0; i < aDigit + 1; ++i) {
            ++count;
            [str appendFormat:@"\n%d", i];
        }
    }
    self.label.text = str;
    self.label.numberOfLines = count;
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight * count;
    self.label.frame = rect;
    digit = aDigit;
}
- (void)setDigitFromLast:(NSUInteger)aDigit {
    [self setDigit:aDigit from:self.digit];
    
}

- (void)setDigitFast:(NSUInteger)aDigit{
    self.label.text = [NSString stringWithFormat:@"%d\n%d", self.digit, aDigit];
    self.label.numberOfLines = 2;
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight * 2;
    self.label.frame = rect;
    digit = aDigit;
}

- (void)setRandomScrollDigit:(NSUInteger)aDigit length:(NSUInteger)length{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%d", self.digit];
    for (int i = 1; i < length - 1; ++i) {
        [str appendFormat:@"\n%d", rand() % 10];
    }
    [str appendFormat:@"\n%d", aDigit];
    self.label.text = str;
    self.label.numberOfLines = length;
    CGRect rect = self.label.frame;
    rect.origin.y = 0;
    rect.size.height = _oneDigitHeight * length;
    self.label.frame = rect;
    digit = aDigit;

}


- (void)commitChange{

    CGRect rect = self.label.frame;
    rect.origin.y = _oneDigitHeight - rect.size.height;
    self.label.frame = rect;
}


- (void)didConfigFinish{
    
    if (self.backgroundView == nil) {
        self.backgroundView = [[[UIView alloc] init] autorelease];
        self.backgroundView.backgroundColor = [UIColor grayColor];
    }
    CGRect backrect = {{0, 0}, self.frame.size};
    self.backgroundView.frame = backrect;
    [self addSubview:self.backgroundView];


    CGSize size= [@"8" sizeWithFont:self.digitFont];
    
    _oneDigitHeight = size.height;
    
    CGRect rect = {{(self.frame.size.width - size.width) / 2, (self.frame.size.height - size.height) / 2}, size};
    UIView *view = [[[UIView alloc] initWithFrame:rect] autorelease];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    rect.origin.x = 0;
    rect.origin.y = 0;
    self.label = [[[UILabel alloc] initWithFrame:rect] autorelease];
    self.label.font = self.digitFont;
    self.label.backgroundColor = [UIColor clearColor];
    [view addSubview:self.label];
    [self addSubview:view];
    [self setDigitAndCommit:self.digit];
    
    
    
}


@end



@implementation ZCWScrollNumView
@synthesize numberSize;
@synthesize numberValue;
@synthesize backgroundView;
@synthesize digitBackgroundView;
@synthesize digitFont;
@synthesize numberViews = _numberViews;
@synthesize splitSpaceWidth;
@synthesize topAndBottomPadding;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initScrollNumView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initScrollNumView];
    }
    return self;
}

- (void)dealloc {
    [backgroundView release];
    [digitBackgroundView release];
    [digitFont release];
    [_numberViews release];
    [super dealloc];
}

- (void)initScrollNumView {
    self.numberSize = 1;
    numberValue = 0;
    self.splitSpaceWidth = 2.0;
    self.topAndBottomPadding = 2.0;
    self.digitFont = kDefaultDigitFont;
    self.randomLength = kRandomLength;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setNumber:(NSUInteger)number withAnimationType:(ZCWScrollNumAnimationType)type animationTime:(NSTimeInterval)timeSpan {
    for (int i = 0; i < numberSize; ++i) {
        ZCWScrollDigitView *digitView = [_numberViews objectAtIndex:i];
        NSUInteger digit = [ZCWScrollNumView digitFromNum:number withIndex:i];
        if (digit != [self digitIndex:i] || type == ZCWScrollNumAnimationTypeRand)
            switch (type) {
                case ZCWScrollNumAnimationTypeNone:
                    [digitView setDigit:digit from:digit];
                    break;
                    
                case ZCWScrollNumAnimationTypeNormal:
                    [digitView setDigit:digit from:0];
                    break;
                case ZCWScrollNumAnimationTypeFromLast:
                    [digitView setDigitFromLast:digit];
                    break;
                    
                case ZCWScrollNumAnimationTypeRand:
                    [digitView setRandomScrollDigit:digit length:self.randomLength];
                    break;
                case ZCWScrollNumAnimationTypeFast:
                    [digitView setDigitFast:digit];
                default:
                    break;
            }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeSpan];
    
    for (ZCWScrollDigitView *digitView in _numberViews) {
        [digitView commitChange];
    }
    [UIView commitAnimations];
    numberValue = number;
}

+ (NSUInteger)digitFromNum:(NSUInteger)number withIndex:(NSUInteger)index {
    NSUInteger num = number;
    for (int i = 0; i < index; ++i) {
        num /= 10;
    }
    
    return num % 10;
}

- (NSUInteger)digitIndex:(NSUInteger)index {
    return [ZCWScrollNumView digitFromNum:self.numberValue withIndex:index];
    
}

- (void)didConfigFinish {
    CGRect backRect = {{0, 0}, self.frame.size};
    self.backgroundView.frame = backRect;
    [self addSubview:self.backgroundView];
    _numberViews = [[NSMutableArray alloc] initWithCapacity:self.numberSize];
    CGFloat allWidth = self.frame.size.width;
    CGFloat digitWidth = (allWidth - (self.numberSize + 1) * splitSpaceWidth) / self.numberSize;
    NSData *digitBackgroundViewData = [NSKeyedArchiver archivedDataWithRootObject:self.digitBackgroundView];
    for (int i = 0; i < numberSize; ++i) {
        CGRect rect = {{allWidth - (digitWidth + self.splitSpaceWidth) * (i + 1), self.topAndBottomPadding}, {digitWidth, self.frame.size.height - self.topAndBottomPadding * 2}};
        
        ZCWScrollDigitView *digitView = [[[ZCWScrollDigitView alloc] initWithFrame:rect] autorelease];
        digitView.backgroundView = [NSKeyedUnarchiver unarchiveObjectWithData:digitBackgroundViewData];
        digitView.digitFont = self.digitFont;
        [digitView didConfigFinish];
        [digitView setDigitAndCommit:[self digitIndex:i]];
        if (self.digitColor != nil) {
            digitView.label.textColor = self.digitColor;
        }
        [_numberViews addObject:digitView];
        [self addSubview:digitView];
    }
}
@end
