//


#import "CollectionViewController2.h"
#import "Cell.h"
#import "PhotosController.h"
#import "CollectionViewController2.h"
#import "ViewControllertwo.h"
#define REUSEABLE @"CELL"

@interface CollectionViewController2 ()

@end

@implementation CollectionViewController2
@synthesize itms;
int j=0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.toolbarHidden=YES;
}
-(void)clickAction:(id)sender{
    UIBarButtonItem *its1=[[UIBarButtonItem alloc]initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(clickshare:)];
    its1.tintColor=[UIColor blackColor];
    
    its1.width=80;
    UIBarButtonItem *it1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *its2=[[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(clickaddto:)];
    its2.tintColor=[UIColor blackColor];
    
    its2.width=80;
    
    UIBarButtonItem *its3=[[UIBarButtonItem alloc]initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(clickdelete:)];
    its3.tintColor=[UIColor redColor];
    its3.width=80;
    
   self.toolbarItems=[NSArray arrayWithObjects:its1,it1,its2,it1,its3, nil];
    
UIBarButtonItem  *clickbuttonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickcancel:)];
    clickbuttonItem.tintColor=[UIColor blueColor];
    self.navigationItem.rightBarButtonItem=clickbuttonItem;

}
-(void)clickButton:(id)sender{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:j];
    UIImage *img=nil;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 375)];
    for (int i=0; i<j; i++) {
        img=[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]];
        [array addObject:img];
        imageview.animationImages=array;
        imageview.animationDuration=j;
    }
    [self.view addSubview:imageview];
    if (imageview.isAnimating) {
        [imageview stopAnimating];
    }
    else{
        [imageview startAnimating];
    }

}
-(void)clickshare:(id)sender{
    UIActionSheet *act=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"  " otherButtonTitles:@"  ",@"  ",@"  ",@"  ", nil];
    [act showInView:self.view];
}
-(void)clickaddto:(id)sender{
//    UIActionSheet *actions=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add to Existing Album",@"Add to New Album", nil];
//    [actions showInView:self.view];
    ViewControllertwo *vc=[[ViewControllertwo alloc]initWithStyle:UITableViewStyleGrouped];
    [vc setItems:itms];
    //[self.navigationController presentViewController:vc
    //animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)clickdelete:(id)sender{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil, nil];
    [action showInView:self.view];

}
-(void)clickcancel:(id)sender{
    [self viewDidLoad];
}
- (void)viewDidLoad
{ 
    [super viewDidLoad];
    itms2=[[NSMutableArray alloc]initWithCapacity:j];
    for (int i=0; i<j; i++) {
        [itms2 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
    }
	// Do any additional setup after loading the view.
    if (itms2==nil) {
        UIBarButtonItem *ittmes1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickAction:)];
        UIBarButtonItem *ittems=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSArray *ite=[NSArray arrayWithObjects:ittmes1,ittems,nil];
        self.toolbarItems=ite;
    }
    else{
        self.navigationController.navigationBar.tintColor=[UIColor grayColor];
        UIBarButtonItem *ittems1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickAction:)];
        UIBarButtonItem *ittems=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *ittem2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(clickButton:)];
        NSArray *ite=[NSArray arrayWithObjects:ittems1,ittems,ittem2,ittems, nil];
        self.toolbarItems=ite;
        }
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:REUSEABLE];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [itms2 count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:REUSEABLE forIndexPath:indexPath];
    
    cell.imageview.image=[itms2 objectAtIndex:indexPath.row];
    cell.bounds=CGRectMake(0, 0, 90, 90);
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotosController *photo=[[PhotosController alloc]initWithNibName:@"PhotosController" bundle:nil];
    photo.s=indexPath.row;
    [self.navigationController pushViewController:photo animated:YES];
}
@end
