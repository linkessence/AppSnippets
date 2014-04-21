

#import "CollectionViewController.h"
#import "Cell.h"
#import "PhotosController.h"
#import "ViewController.h"
#import "ViewControllertwo.h"
#define REUSEABLE_CELL_IDENTITY @"CELL"
@interface CollectionViewController ()

@end

@implementation CollectionViewController
@synthesize itmms;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor grayColor];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickaction:)];
    UIBarButtonItem *itms1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(clickbutton:)];
    UIBarButtonItem *itms2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items=[NSArray arrayWithObjects:item1,itms1,item2,itms2, nil];
    self.toolbarItems=items;    
    self.title=@"Photos";
    self.navigationController.title=@"图片";
    self.navigationController.toolbar.translucent=YES;
    //self.navigationController.toolbar.backgroundColor=[UIColor blackColor];
    self.collectionView.backgroundColor=[UIColor blackColor];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY];
    itms=[[NSMutableArray alloc]initWithCapacity:21];
    PhotosController *pho=[[PhotosController alloc]initWithNibName:@"PhotosController" bundle:nil];
    pho.ittms=itms;
    for (int i=0; i<21; i++) {
        [itms addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
    }
}
-(void)clickaction:(id)sender{
    UIBarButtonItem *its1=[[UIBarButtonItem alloc]initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(clickshare:)];
    its1.tintColor=[UIColor blackColor];

    its1.width=80;
    UIBarButtonItem *it1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *its2=[[UIBarButtonItem alloc]initWithTitle:@"Add To" style:UIBarButtonItemStyleBordered target:self action:@selector(clickaddto:)];
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
-(void)clickbutton:(id)sender{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:21];
    UIImage *img=nil;
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 375)];
    for (int i=0; i<21; i++) {
        img=[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]];
        [array addObject:img];
        imageview.animationImages=array;
        imageview.animationDuration=21;
    }
    [self.view addSubview:imageview];
    if (imageview.isAnimating) {
        [imageview stopAnimating];
    }
    else{
        [imageview startAnimating];
    }
}
-(void)clickcancel:(id)sender{
    self.navigationItem.rightBarButtonItem=nil;
    [self viewDidLoad];
}
-(void)clickdelete:(id)sender{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil, nil];
    [action showInView:self.view];
}
-(void)clickaddto:(id)sender{
    ViewControllertwo *vc=[[ViewControllertwo alloc]initWithStyle:UITableViewStyleGrouped];
    [vc setItems:itmms];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
      
    }
    else if (buttonIndex==1){
        
    }
    NSLog(@"%i",buttonIndex);
}
-(void)clickshare:(id)sender{
    UIActionSheet *act=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"  " otherButtonTitles:@"  ",@"  ",@"  ",@"  ", nil];
    [act showInView:self.view];
 }
//-(void)clickbutton:(id)sender{
//    PhotosController *photos=[[PhotosController alloc]initWithNibName:@"PhotosController" bundle:nil];
//    [self.navigationController pushViewController:photos animated:YES];
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return [itms count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:REUSEABLE_CELL_IDENTITY forIndexPath:indexPath];
    
    cell.imageview.image=[itms objectAtIndex:indexPath.row];
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
    //PhotosController *pc=[[PhotosController alloc] initWithNibName:@"" bundle:nil];
}
@end
