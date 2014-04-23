//
//  iCodeMapViewController.m
//  iCodeMap
//
//  Created by Collin Ruffenach on 7/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iCodeMapViewController.h"
#import "iCodeBlogAnnotation.h"

@implementation iCodeMapViewController

@synthesize tableview;
@synthesize mapView;
@synthesize shadowImage;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)viewDidLoad 
{
    [super viewDidLoad];
	[self loadOurAnnotations];
}

-(void)loadOurAnnotations
{
	CLLocationCoordinate2D workingCoordinate;
	
	workingCoordinate.latitude = 40.763856;
	workingCoordinate.longitude = -73.973034;
	iCodeBlogAnnotation *appleStore1 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[appleStore1 setTitle:@"Apple Store 5th Ave."];
	[appleStore1 setSubtitle:@"Apple's Flagship Store"];
	[appleStore1 setAnnotationType:iCodeBlogAnnotationTypeApple];

	[mapView addAnnotation:appleStore1];
	
	workingCoordinate.latitude = 51.514298;
	workingCoordinate.longitude = -0.141949;
	iCodeBlogAnnotation *appleStore2 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[appleStore2 setTitle:@"Apple Store St. Regent"];
	[appleStore2 setSubtitle:@"London England"];
	[appleStore2 setAnnotationType:iCodeBlogAnnotationTypeApple];
	
	[mapView addAnnotation:appleStore2];
	
	workingCoordinate.latitude = 35.672284;
	workingCoordinate.longitude = 139.765702;
	iCodeBlogAnnotation *appleStore3 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[appleStore3 setTitle:@"Apple Store Giza"];
	[appleStore3 setSubtitle:@"Tokyo, Japan"];
	[appleStore3 setAnnotationType:iCodeBlogAnnotationTypeApple];
	
	[mapView addAnnotation:appleStore3];
	
	workingCoordinate.latitude = 37.331741;
	workingCoordinate.longitude = -122.030564;
	iCodeBlogAnnotation *appleStore4 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[appleStore4 setTitle:@"Apple Headquarters"];
	[appleStore4 setSubtitle:@"The Mothership"];
	[appleStore4 setAnnotationType:iCodeBlogAnnotationTypeApple];
	
	[mapView addAnnotation:appleStore4];
	
	workingCoordinate.latitude = 41.894518;
	workingCoordinate.longitude = -87.624005;
	iCodeBlogAnnotation *appleStore5 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[appleStore5 setTitle:@"Apple Store Michigan Ave."];
	[appleStore5 setSubtitle:@"Chicago, IL"];
	[appleStore5 setAnnotationType:iCodeBlogAnnotationTypeApple];
	
	[mapView addAnnotation:appleStore5];
	
	workingCoordinate.latitude = 32.264977;
	workingCoordinate.longitude = -110.944011;
	iCodeBlogAnnotation *tacoShop1 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[tacoShop1 setTitle:@"Nico's Taco Shop"];
	[tacoShop1 setSubtitle:@"Tucson, AZ"];
	[tacoShop1 setAnnotationType:iCodeBlogAnnotationTypeTaco];
	
	[mapView addAnnotation:tacoShop1];
	
	workingCoordinate.latitude = 32.743242;
	workingCoordinate.longitude = -117.181451;
	iCodeBlogAnnotation *tacoShop2 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[tacoShop2 setTitle:@"Lucha Libre Gourmet"];
	[tacoShop2 setSubtitle:@"San Diego, CA"];
	[tacoShop2 setAnnotationType:iCodeBlogAnnotationTypeTaco];
	
	[mapView addAnnotation:tacoShop2];
	
	workingCoordinate.latitude = 32.594987;
	workingCoordinate.longitude = -117.060936;
	iCodeBlogAnnotation *tacoShop3 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[tacoShop3 setTitle:@"El Ranchero Taco Shop"];
	[tacoShop3 setSubtitle:@"Rocky Pointe, Mexico"];
	[tacoShop3 setAnnotationType:iCodeBlogAnnotationTypeTaco];
	
	[mapView addAnnotation:tacoShop3];
	
	workingCoordinate.latitude = -34.594859;
	workingCoordinate.longitude = -58.384336;
	iCodeBlogAnnotation *tacoShop4 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[tacoShop4 setTitle:@"Taco Tequila Sangria S.A."];
	[tacoShop4 setSubtitle:@"Buneos Aires, Argentina"];
	[tacoShop4 setAnnotationType:iCodeBlogAnnotationTypeTaco];
	
	[mapView addAnnotation:tacoShop4];
	
	workingCoordinate.latitude = 38.240550;
	workingCoordinate.longitude = -0.526509;
	iCodeBlogAnnotation *tacoShop5 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[tacoShop5 setTitle:@"Albertsma Taco"];
	[tacoShop5 setSubtitle:@"Gran Alacant, Spain"];
	[tacoShop5 setAnnotationType:iCodeBlogAnnotationTypeTaco];
	
	[mapView addAnnotation:tacoShop5];	
	
	workingCoordinate.latitude = 33.419490;
	workingCoordinate.longitude = -111.930563;
	iCodeBlogAnnotation *school1 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[school1 setTitle:@"Arizona State University"];
	[school1 setSubtitle:@"Go Sun Devils"];
	[school1 setAnnotationType:iCodeBlogAnnotationTypeEDU];
	
	[mapView addAnnotation:school1];
	
	workingCoordinate.latitude = 35.087537;
	workingCoordinate.longitude = -106.618184;
	iCodeBlogAnnotation *school2 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[school2 setTitle:@"University of New Mexico"];
	[school2 setSubtitle:@"Go Lobos"];
	[school2 setAnnotationType:iCodeBlogAnnotationTypeEDU];
	
	[mapView addAnnotation:school2];
	
	workingCoordinate.latitude = 40.730838;
	workingCoordinate.longitude = -73.997498;
	iCodeBlogAnnotation *school3 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[school3 setTitle:@"New York University"];
	[school3 setSubtitle:@"New York, NY"];
	[school3 setAnnotationType:iCodeBlogAnnotationTypeEDU];
	
	[mapView addAnnotation:school3];
	
	workingCoordinate.latitude = 51.753523;
	workingCoordinate.longitude = -1.253171;
	iCodeBlogAnnotation *school4 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[school4 setTitle:@"Oxford University"];
	[school4 setSubtitle:@"Oxford, England"];
	[school4 setAnnotationType:iCodeBlogAnnotationTypeEDU];
	
	[mapView addAnnotation:school4];
	
	workingCoordinate.latitude = 22.131982;
	workingCoordinate.longitude = 82.142302;
	iCodeBlogAnnotation *school5 = [[iCodeBlogAnnotation alloc] initWithCoordinate:workingCoordinate];
	[school5 setTitle:@"India Institute of Technology"];
	[school5 setSubtitle:@"Delhi, India"];
	[school5 setAnnotationType:iCodeBlogAnnotationTypeEDU];
	
	[mapView addAnnotation:school5];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{	
	return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
	if(orientation == UIInterfaceOrientationLandscapeLeft)
	{
		NSLog(@"Rotated left");
	}

	else if(orientation == UIInterfaceOrientationLandscapeRight)
	{
		CGRect mapViewFrame;
		CGRect tableViewFrame;
		CGRect shadowFrame;
		
		mapViewFrame.origin.x = 0;
		mapViewFrame.origin.y = 0;
		mapViewFrame.size.width = 80;
		mapViewFrame.size.height = 480;
		
		shadowFrame.origin.x = 240;
		shadowFrame.origin.y = 0;
		shadowFrame.size.width = 80;
		shadowFrame.size.height = 480;
		
		tableViewFrame.origin.x = 240;
		tableViewFrame.origin.y = 0;
		tableViewFrame.size.width = 80;
		tableViewFrame.size.height = 480;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		[mapView setFrame:mapViewFrame];
		[tableview setFrame:tableViewFrame];
		[UIView commitAnimations];
	}

	else if(orientation == UIInterfaceOrientationPortrait)
	{
		CGRect mapViewFrame;
		CGRect tableViewFrame;
		CGRect shadowFrame;
		
		mapViewFrame.origin.x = 0;
		mapViewFrame.origin.y = 0;
		mapViewFrame.size.width = 320;
		mapViewFrame.size.height = 296;
		
		shadowFrame.origin.x = 0;
		shadowFrame.origin.y = 282;
		shadowFrame.size.width = 320;
		shadowFrame.size.height = 178;
		
		tableViewFrame.origin.x = 0;
		tableViewFrame.origin.y = 290;
		tableViewFrame.size.width = 320;
		tableViewFrame.size.height = 170;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1];
		[mapView setFrame:mapViewFrame];
		[tableview setFrame:tableViewFrame];
		[UIView commitAnimations];
	}
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}

- (iCodeBlogAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	iCodeBlogAnnotationView *annotationView = nil;
	
	// determine the type of annotation, and produce the correct type of annotation view for it.
	iCodeBlogAnnotation* myAnnotation = (iCodeBlogAnnotation *)annotation;
	
	if(myAnnotation.annotationType == iCodeBlogAnnotationTypeApple)
	{
		NSString* identifier = @"Apple";
		iCodeBlogAnnotationView *newAnnotationView = (iCodeBlogAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
		if(nil == newAnnotationView)
		{
			newAnnotationView = [[[iCodeBlogAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier] autorelease];
		}
		
		annotationView = newAnnotationView;
	}
	else if(myAnnotation.annotationType == iCodeBlogAnnotationTypeEDU)
	{
		NSString* identifier = @"School";
		
		iCodeBlogAnnotationView *newAnnotationView = (iCodeBlogAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
		if(nil == newAnnotationView)
		{
			newAnnotationView = [[[iCodeBlogAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier] autorelease];
		}
		
		annotationView = newAnnotationView;
	}
	else if(myAnnotation.annotationType == iCodeBlogAnnotationTypeTaco)
	{
		NSString* identifier = @"Taco";
		
		iCodeBlogAnnotationView *newAnnotationView = (iCodeBlogAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
		if(nil == newAnnotationView)
		{
			newAnnotationView = [[[iCodeBlogAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier] autorelease];
		}
		
		annotationView = newAnnotationView;
	}
	
	[annotationView setEnabled:YES];
	[annotationView setCanShowCallout:YES];
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{

}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == iCodeBlogAnnotationTypeApple)
	{
		return @"Apple Markers";
	}
	
	else if(section == iCodeBlogAnnotationTypeEDU)
	{
		return @"Schools";
	}
	
	else if(section == iCodeBlogAnnotationTypeTaco)
	{
		return @"Taco Shops";
	}
	
	return nil;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSMutableArray *annotations = [[NSMutableArray alloc] init];
	
	if(indexPath.section == 0)
	{
		for(iCodeBlogAnnotation *annotation in [mapView annotations])
		{
			if([annotation annotationType] == iCodeBlogAnnotationTypeApple)
			{
				[annotations addObject:annotation];
			}
		}
		
		cell.textLabel.text = [[annotations objectAtIndex:indexPath.row] title];
	}
	
	else if(indexPath.section == 1)
	{
		for(iCodeBlogAnnotation *annotation in [mapView annotations])
		{
			if([annotation annotationType] == iCodeBlogAnnotationTypeEDU)
			{
				[annotations addObject:annotation];
			}
		}		
		
		cell.textLabel.text = [[annotations objectAtIndex:indexPath.row] title];
	}
	
	else if(indexPath.section == 2)
	{
		for(iCodeBlogAnnotation *annotation in [mapView annotations])
		{
			if([annotation annotationType] == iCodeBlogAnnotationTypeTaco)
			{
				[annotations addObject:annotation];
			}
		}
		
		cell.textLabel.text = [[annotations objectAtIndex:indexPath.row] title];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	for(iCodeBlogAnnotation *annotation in [mapView annotations])
	{
		if([[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] isEqualToString:[annotation title]])
		{	
			[mapView setRegion:MKCoordinateRegionMake([annotation coordinate], MKCoordinateSpanMake(.01, .01)) animated:YES];
		}
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
