//
//  VideoCamera.h
//  VideoCamera2
//
//  Created by matao.ct@gmail.com on 12-6-4.
//  Copyright 2012 __福州微泰网络__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FTPHelper.h"
#import "UIControlFactory.h"

#import "MediaListController.h"

@interface VideoCamera : UIViewController<UIImagePickerControllerDelegate,FTPHelperDelegate> {
	UIButton *btnCamera;
	UISegmentedControl *segmentVideoQuality;
	UIButton *btnSelectFile;
	UIButton *btnSendFile;
	UIImageView *imageView;
    
    UIButton *btnStream;
	
	NSURL *targetURL;
	BOOL isCamera;
}

@property (nonatomic, retain) IBOutlet UIButton *btnCamera;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentVideoQuality;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectFile;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *btnSendFile;
@property (nonatomic, retain) IBOutlet UIButton *btnStream;




-(IBAction)startCamera:(id)sender;
-(IBAction)selectFile:(id)sender;
-(IBAction)sendFile:(id)sender;
-(IBAction)listServer:(id)sender;

-(void)getPreViewImg:(NSURL *)url;
-(void)sendFileByPath:(NSURL *)filePath;
-(void)sendFileByData:(NSData *)fileData fileName:(NSString *)name;
-(void)ftpSetting;

-(NSString *)getFileName:(NSString *)fileName;
-(NSString *)timeStampAsString;
@end
