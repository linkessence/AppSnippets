//
//  KSPopoverView.h
//  KSPopoverView
//
//  Copyright 2010, 2011 KatokichiSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPopoverViewParentButton.h"
#import "KSPopoverViewButtonBase.h"

#import "KSPopoverViewButtonLabel.h"
#import "KSPopoverViewButtonOnOff.h"

typedef enum {
	KSPopoverTypeTextLabel = 0,
	KSPopoverTypeOnOffLabel,
} KSPopoverType;

typedef enum {
	KSPopoverStateNormal = 0,
	KSPopoverStateOpened,
} KSPopoverState;

typedef enum {
	KSPopoverPositionTopCenter = 0,
	KSPopoverPositionTopLeft,      // Not implemented
	KSPopoverPositionTopRight,
	KSPopoverPositionBottomCenter, 
	KSPopoverPositionBottomLeft,   // Not implemented
	KSPopoverPositionBottomRight,  // Not implemented
    
} KSPopoverPosition;

// デリゲートメソッドが呼ばれたときのinfoパラメータ内のキー
extern NSString *KSPopoverViewButtonInfoLabelNameKey;   // ラベルの名前

@protocol KSPopoverViewDelegate;

@interface KSPopoverView : UIView {
	@private
	// メニュー内の子要素
	Class klass;
	NSMutableArray *_childs;
	
	// 通常時、広がったときのサイズとその場所
	CGRect _normalFrame;
	CGRect _openedFrame;
	KSPopoverState _state;
	KSPopoverPosition _position;
    CGFloat _offset;
	
	// ユーザーに見せるボタン相当
	KSPopoverViewParentButton *_button;
	UITouch *_firstTouch;
	
	id<KSPopoverViewDelegate> _delegate;

	// デバッグ情報の表示
	BOOL _debug;
}

@property(nonatomic, retain) KSPopoverViewParentButton *button;
@property(nonatomic, retain) UITouch *firstTouch;
@property(retain) NSMutableArray *childs;
@property(nonatomic, assign) id<KSPopoverViewDelegate> delegate;
@property(nonatomic, assign, readonly) CGRect frame;
@property(nonatomic, assign) KSPopoverPosition position;
// メニュー全体の縦方向へのオフセット（大きいほどボタン全体が離れる）
@property(nonatomic, assign) CGFloat offset;
// デバッグログの表示切り替え
@property(nonatomic, assign) BOOL debug;

- (id)initWithType:(KSPopoverType)type image:(UIImage *)buttonImage point:(CGPoint)point;
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (KSPopoverViewButtonBase *)labelAtIndex:(NSInteger)index;
- (NSInteger)countOfLabels;

@end

#pragma mark -
@protocol KSPopoverViewDelegate <NSObject>
@required
// ポップオーバー表示されたボタンのいずれかが選択されたときに呼ばれる
- (void)popoverView:(KSPopoverView *)view selectedButtonIndex:(NSInteger)buttonIndex withInfo:(NSDictionary *)info;
@end

