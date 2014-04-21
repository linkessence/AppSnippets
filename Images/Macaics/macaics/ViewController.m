//
//  ViewController.m
//  macaics
//
//  Created by gao on 13-7-4.
//  Copyright (c) 2013年 com.hairbobo. All rights reserved.
//

#import "ViewController.h"
#import "EditPhotoViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{

    __weak IBOutlet UIImageView *selectImg;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickPhotoAlbums:(id)sender {
    
    //相册是否允许访问
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
//        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePickerController animated:YES];

}

- (IBAction)clickCamera:(id)sender {
    
    
}

- (IBAction)clickEditMosaics:(id)sender {
    
    if (selectImg.image != nil) {
        EditPhotoViewController *control = [[EditPhotoViewController alloc] init];
        control.sourseImg = selectImg.image;
        [self presentModalViewController:control animated:YES];
    }
    
}


#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
	[picker dismissModalViewControllerAnimated:YES];
    
    [selectImg setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
	[self dismissModalViewControllerAnimated:YES];

}



- (void)viewDidUnload {
    selectImg = nil;
    [super viewDidUnload];
}
@end
