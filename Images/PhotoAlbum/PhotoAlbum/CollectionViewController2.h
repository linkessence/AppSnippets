//


#import <UIKit/UIKit.h>

@interface CollectionViewController2 : UICollectionViewController<UICollectionViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *itms2;
}
@property(nonatomic,assign,readwrite) NSMutableArray *itms;
-(void)clickButton:(id)sender;
-(void)clickAction:(id)sender;
-(void)clickshare:(id)sender;
-(void)clickaddto:(id)sender;
-(void)clickdelete:(id)sender;
-(void)clickcancel:(id)sender;
@end

