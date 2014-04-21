

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController<UICollectionViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *itms;
}
@property(nonatomic,assign,readwrite) NSMutableArray *itmms;
-(void)clickbutton:(id)sender;
-(void)clickaction:(id)sender;
-(void)clickcancel:(id)sender;
-(void)clickdelete:(id)sender;
-(void)clickaddto:(id)sender;
-(void)clickshare:(id)sender;
@end
