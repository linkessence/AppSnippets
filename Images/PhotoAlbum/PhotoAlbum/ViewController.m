

#import "ViewController.h"
#import "CollectionViewController.h"
#import "CollectionViewController2.h"
#import "ViewControllertwo.h"
@interface ViewController (){
    UIBarButtonItem *zjbuttonItem;
    UIBarButtonItem *bjbuttonItem;
    UIBarButtonItem *donebuttonItem;
}
-(void)clickzjbutton:(id)sender;
-(void)clickbjbutton:(id)sender;
-(void)clickdonebutton:(id)sender;

@end

@implementation ViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)clickzjbutton:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"New Album" message:@"Enter a name for this album" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"保存", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        UITextField *txt=[alertView textFieldAtIndex:0];
        [items addObject:txt.text];
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:[items count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:(UITableViewRowAnimationFade)];
    }
}
-(void)clickbjbutton:(id)sender{
    [self setEditing:YES animated:YES];
}
-(void)clickdonebutton:(id)sender{
    [self setEditing:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Albums(QQ:345731028)";
    self.navigationController.navigationBar.tintColor=[UIColor grayColor];
    self.navigationController.title=@"主页面";
    self.tableView.backgroundColor=[UIColor grayColor];
    zjbuttonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickzjbutton:)];
    zjbuttonItem.tintColor=[UIColor blackColor];
    bjbuttonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(clickbjbutton:)];
    donebuttonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(clickdonebutton:)];
    donebuttonItem.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=zjbuttonItem;
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    self.editButtonItem.tintColor=[UIColor blackColor];
    items=[[NSMutableArray alloc]initWithObjects:@"Saved Photos(21张)", nil];
    self.hidesBottomBarWhenPushed=YES;
    //self.navigationController.toolbarHidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[items objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=@"点击查看详情";
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i.JPG",indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return NO;
    }
    return YES;
}

NSInteger row=0,seco=0;
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        row=indexPath.row;
        seco=indexPath.section;
        UIActionSheet *actio=[[UIActionSheet alloc]initWithTitle:@"Are you sure want to delete the album?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Album" otherButtonTitles:nil];
        [actio showInView:self.view];
//        if(@"Delete Album"){
//        [items removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSIndexPath *index=[NSIndexPath indexPathForRow:row inSection:seco];
    if (buttonIndex==0) {
        [items removeObjectAtIndex:row];   
        [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (buttonIndex==1){
        
    }
}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [items exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    sb=[items objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(90, 90);
        CollectionViewController *coll=[[[CollectionViewController alloc]initWithCollectionViewLayout:layout]autorelease];
        coll.itmms=items;
        [self.navigationController pushViewController:coll animated:YES];
    }
    else{
        UICollectionViewFlowLayout *layout2=[[UICollectionViewFlowLayout alloc]init];
        layout2.itemSize=CGSizeMake(90, 90);
        CollectionViewController2 *coll2=[[[CollectionViewController2 alloc]initWithCollectionViewLayout:layout2]autorelease];
        coll2.itms=items;
        [self.navigationController pushViewController:coll2 animated:YES];
    }
}

@end
