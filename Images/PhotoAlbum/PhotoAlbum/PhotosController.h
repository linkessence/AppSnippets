

#import <UIKit/UIKit.h>
@interface PhotosController : UIViewController<UIActionSheetDelegate>{
    IBOutlet UIImageView *imageview;
    int s;
}
@property(nonatomic,assign,readwrite) int s;
@property(nonatomic,assign,readwrite) NSMutableArray *ittms;;
-(void)clickbutton:(id)sender;
-(void)shanchu:(id)sender;
-(void)sharebutton:(id)sender;
@end
