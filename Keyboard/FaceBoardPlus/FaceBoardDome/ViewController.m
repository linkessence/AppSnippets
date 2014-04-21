//
//  ViewController.m
//  FaceBoardDome
//
//  Created by blue on 12-12-20.
//  Copyright (c) 2012年 Blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood
//


#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController


@synthesize tmpCell, cellNib;


- (void)viewDidLoad {

    [super viewDidLoad];

    if ( !faceBoard) {

        faceBoard = [[FaceBoard alloc] init];
        faceBoard.delegate = self;
        faceBoard.inputTextView = textView;
    }

    if ( !messageList ) {

        messageList = [[NSMutableArray alloc] init];
    }

    if ( !sizeList ) {

        sizeList = [[NSMutableDictionary alloc] init];
    }

    self.cellNib = [UINib nibWithNibName:@"MessageListCell" bundle:nil];

    //textView.contentInset = UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f);
    [textView.layer setCornerRadius:6];
    [textView.layer setMasksToBounds:YES];

    isFirstShowKeyboard = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if (iPhone5) {
        
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }
    else{
        
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }

    CGRect frame = messageListView.frame;
    frame.size.height = self.view.frame.size.height - 64;
    messageListView.frame = frame;

    frame = toolBar.frame;
    frame.origin.y = self.view.frame.size.height - 64;
    toolBar.frame = frame;
}

/** ################################ UIKeyboardNotification ################################ **/

- (void)keyboardWillShow:(NSNotification *)notification {

    isKeyboardShowing = YES;

    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = messageListView.frame;
                         frame.size.height += keyboardHeight;
                         frame.size.height -= keyboardRect.size.height;
                         messageListView.frame = frame;
                         
                         frame = toolBar.frame;
                         frame.origin.y += keyboardHeight;
                         frame.origin.y -= keyboardRect.size.height;
                         toolBar.frame = frame;
                         
                         keyboardHeight = keyboardRect.size.height;
                     }];

    if ( isFirstShowKeyboard ) {
        
        isFirstShowKeyboard = NO;
        
        isSystemBoardShow = !isButtonClicked;
    }

    if ( isSystemBoardShow ) {

        [keyboardButton setImage:[UIImage imageNamed:@"board_emoji"]
                       forState:UIControlStateNormal];
    }
    else {

        [keyboardButton setImage:[UIImage imageNamed:@"board_system"]
                       forState:UIControlStateNormal];
    }

    if ( messageList.count ) {

        [messageListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messageList.count - 1
                                                                   inSection:0]
                               atScrollPosition:UITableViewScrollPositionBottom
                                       animated:NO];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {

    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = messageListView.frame;
                         frame.size.height += keyboardHeight;
                         messageListView.frame = frame;
                         
                         frame = toolBar.frame;
                         frame.origin.y += keyboardHeight;
                         toolBar.frame = frame;
                         
                         keyboardHeight = 0;
                     }];
}

- (void)keyboardDidHide:(NSNotification *)notification {

    isKeyboardShowing = NO;

    if ( isButtonClicked ) {

        isButtonClicked = NO;

        if ( ![textView.inputView isEqual:faceBoard] ) {

            isSystemBoardShow = NO;

            textView.inputView = faceBoard;
        }
        else {

            isSystemBoardShow = YES;

            textView.inputView = nil;
        }

        [textView becomeFirstResponder];
    }
}

/** ################################ ViewController ################################ **/

- (IBAction)faceBoardClick:(id)sender {

    isButtonClicked = YES;

    if ( isKeyboardShowing ) {

        [textView resignFirstResponder];
    }
    else {

        if ( isFirstShowKeyboard ) {
            
            isFirstShowKeyboard = NO;
            
            isSystemBoardShow = NO;
        }

        if ( !isSystemBoardShow ) {

            textView.inputView = faceBoard;
        }

        [textView becomeFirstResponder];
    }
}

- (IBAction)faceBoardHide:(id)sender {

    BOOL needReload = NO;
    if ( ![textView.text isEqualToString:@""] ) {

        needReload = YES;

        NSMutableArray *messageRange = [[NSMutableArray alloc] init];
        [self getMessageRange:textView.text :messageRange];
        [messageList addObject:messageRange];
        [messageRange release];

        messageRange = [[NSMutableArray alloc] init];
        [self getMessageRange:textView.text :messageRange];
        [messageList addObject:messageRange];
        [messageRange release];
    }

    textView.text = nil;
    [self textViewDidChange:textView];

    [textView resignFirstResponder];

    isFirstShowKeyboard = YES;

    isButtonClicked = NO;

    textView.inputView = nil;

    [keyboardButton setImage:[UIImage imageNamed:@"board_emoji"]
                   forState:UIControlStateNormal];

    if ( needReload ) {

        [messageListView reloadData];

        [messageListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messageList.count - 1
                                                                   inSection:0]
                               atScrollPosition:UITableViewScrollPositionBottom
                                       animated:NO];
    }
}

/**
 * 解析输入的文本
 *
 * 根据文本信息分析出哪些是表情，哪些是文字
 */
- (void)getMessageRange:(NSString*)message :(NSMutableArray*)array {
    
	NSRange range = [message rangeOfString:FACE_NAME_HEAD];
    
    //判断当前字符串是否存在表情的转义字符串
    if ( range.length > 0 ) {

        if ( range.location > 0 ) {

            [array addObject:[message substringToIndex:range.location]];

            message = [message substringFromIndex:range.location];

            if ( message.length > FACE_NAME_LEN ) {
                
                [array addObject:[message substringToIndex:FACE_NAME_LEN]];
                
                message = [message substringFromIndex:FACE_NAME_LEN];
                [self getMessageRange:message :array];
            }
            else
            // 排除空字符串
            if ( message.length > 0 ) {
                    
                [array addObject:message];
            }
        }
        else {

            if ( message.length > FACE_NAME_LEN ) {

                [array addObject:[message substringToIndex:FACE_NAME_LEN]];

                message = [message substringFromIndex:FACE_NAME_LEN];
                [self getMessageRange:message :array];
            }
            else
            // 排除空字符串
            if ( message.length > 0 ) {

                [array addObject:message];
            }
        }
    }
    else {
        
        [array addObject:message];
    }
}

/**
 *  获取文本尺寸
 */
- (void)getContentSize:(NSIndexPath *)indexPath {

    @synchronized ( self ) {


        CGFloat upX;
        
        CGFloat upY;
        
        CGFloat lastPlusSize;
        
        CGFloat viewWidth;
        
        CGFloat viewHeight;
        
        BOOL isLineReturn;


        NSArray *messageRange = [messageList objectAtIndex:indexPath.row];
        
        NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:@"FaceMap"];
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        
        isLineReturn = NO;
        
        upX = VIEW_LEFT;
        upY = VIEW_TOP;
        
        for (int index = 0; index < [messageRange count]; index++) {
            
            NSString *str = [messageRange objectAtIndex:index];
            if ( [str hasPrefix:FACE_NAME_HEAD] ) {
                
                //NSString *imageName = [str substringWithRange:NSMakeRange(1, str.length - 2)];
                
                NSArray *imageNames = [faceMap allKeysForObject:str];
                NSString *imageName = nil;
                NSString *imagePath = nil;
 
                if ( imageNames.count > 0 ) {

                    imageName = [imageNames objectAtIndex:0];
                    imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                }
                
                if ( imagePath ) {
                    
                    if ( upX > ( VIEW_WIDTH_MAX - KFacialSizeWidth ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                    }
                    
                    upX += KFacialSizeWidth;
                    
                    lastPlusSize = KFacialSizeWidth;
                }
                else {
                    
                    for ( int index = 0; index < str.length; index++) {
                        
                        NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
                        
                        CGSize size = [character sizeWithFont:font
                                            constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
                        
                        if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
                            
                            isLineReturn = YES;
                            
                            upX = VIEW_LEFT;
                            upY += VIEW_LINE_HEIGHT;
                        }
                        
                        upX += size.width;
                        
                        lastPlusSize = size.width;
                    }
                }
            }
            else {
                
                for ( int index = 0; index < str.length; index++) {
                    
                    NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
                    
                    CGSize size = [character sizeWithFont:font
                                        constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
                    
                    if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                    }
                    
                    upX += size.width;
                    
                    lastPlusSize = size.width;
                }
            }
        }
        
        if ( isLineReturn ) {
            
            viewWidth = VIEW_WIDTH_MAX + VIEW_LEFT * 2;
        }
        else {
            
            viewWidth = upX + VIEW_LEFT;
        }
        
        viewHeight = upY + VIEW_LINE_HEIGHT + VIEW_TOP;

        NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake( viewWidth, viewHeight )];
        [sizeList setObject:sizeValue forKey:indexPath];
    }
}

/** ################################ UITextViewDelegate ################################ **/

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //点击了非删除键
    if( [text length] == 0 ) {
        
        if ( range.length > 1 ) {
            
            return YES;
        }
        else {
            
            [faceBoard backFace];
            
            return NO;
        }
    }
    else {
        
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)_textView {
    
    CGSize size = textView.contentSize;
    size.height -= 2;
    if ( size.height >= 68 ) {
        
        size.height = 68;
    }
    else if ( size.height <= 32 ) {
        
        size.height = 32;
    }
    
    if ( size.height != textView.frame.size.height ) {
        
        CGFloat span = size.height - textView.frame.size.height;
        
        CGRect frame = toolBar.frame;
        frame.origin.y -= span;
        frame.size.height += span;
        toolBar.frame = frame;
        
        CGFloat centerY = frame.size.height / 2;
        
        frame = textView.frame;
        frame.size = size;
        textView.frame = frame;
        
        CGPoint center = textView.center;
        center.y = centerY;
        textView.center = center;
        
        center = keyboardButton.center;
        center.y = centerY;
        keyboardButton.center = center;
        
        center = sendButton.center;
        center.y = centerY;
        sendButton.center = center;
    }
}

/** ################################ UITableViewDataSource ################################ **/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return messageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"MessageListCell";
    MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil ) {
        
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSMutableArray *message = [messageList objectAtIndex:indexPath.row];
    NSValue *sizeValue = [sizeList objectForKey:indexPath];
    CGSize size = [sizeValue CGSizeValue];

    if ( indexPath.row % 2 == 0 ) {

        [cell refreshForOwnMsg:message withSize:size];
    }
    else {

        [cell refreshForFrdMsg:message withSize:size];
    }
    
    return cell;
}

/** ################################ UITableViewDelegate ################################ **/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSValue *sizeValue = (NSValue *)[sizeList objectForKey:indexPath];
    if ( !sizeValue ) {

        [self getContentSize:indexPath];
        sizeValue = (NSValue *)[sizeList objectForKey:indexPath];
    }

    CGSize size = [sizeValue CGSizeValue];
    
    CGFloat span = size.height - MSG_VIEW_MIN_HEIGHT;
    CGFloat height = MSG_CELL_MIN_HEIGHT + span;

    return height;
}

/** ################################  ################################ **/

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];

    [faceBoard release];
    [toolBar release];
    [messageListView release];

    [messageList release];
    [sizeList release];

    [super dealloc];
}

@end
