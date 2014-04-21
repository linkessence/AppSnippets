//
//  ViewController.h
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/18/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIPopoverControllerDelegate>{
    
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *labelView;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

- (IBAction)btnSelectImageClicked:(id)sender;
- (IBAction)btnReKognizeImageClicked:(id)sender;

@end
