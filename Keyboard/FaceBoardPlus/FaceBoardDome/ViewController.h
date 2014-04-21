//
//  ViewController.h
//  FaceBoardDome
//
//  Created by blue on 12-12-20.
//  Copyright (c) 2012年 Blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood
//


#import <UIKit/UIKit.h>

#import "FaceBoard.h"

#import "MessageListCell.h"


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
        CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate,
                                               UITextViewDelegate, FaceBoardDelegate > {

    BOOL isFirstShowKeyboard;

    BOOL isButtonClicked;

    BOOL isKeyboardShowing;

    BOOL isSystemBoardShow;


    CGFloat keyboardHeight;

    NSMutableArray *messageList;

    NSMutableDictionary *sizeList;

    FaceBoard *faceBoard;


    IBOutlet UIView *toolBar;

    IBOutlet UITextView *textView;

    IBOutlet UIButton *keyboardButton;

    IBOutlet UIButton *sendButton;

    IBOutlet UITableView *messageListView;
}


@property (nonatomic, retain) IBOutlet MessageListCell *tmpCell;

@property (nonatomic, retain) UINib *cellNib;


@end
