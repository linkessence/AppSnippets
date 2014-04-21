//
//  TranslucentView.h
//  Translucent
//
//  Created by 谢伟 on 11-2-14.
//  Copyright 2011 易联伟达 www.e-linkway.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ELTranslucentView : UIView
{
@private
    CGPoint _firstPoint;
    
    UIImageView *_boundsView;
    UIImageView *_contentImageView;
    
    BOOL _isDragBegan;
    float _boundsViewOriY;
	
	CGFloat _moveMinY;
	CGFloat _moveMaxY;
	
}

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *translucentImage;

@property (nonatomic, readwrite) CGFloat moveMinY;
@property (nonatomic, readwrite) CGFloat moveMaxY;

@end
