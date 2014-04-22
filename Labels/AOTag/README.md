#AOTag - simple tag implementation

AOTag is under MIT Licence so if you find it helpful just use it !

###**AOTagDemo**

This project add/remove tag with image and title inside a tag list view. When user tap on a tag, it's removed from the view. Please see the sample project for more.

The usage of distant tag image is supported by using EGOImageView module.

https://github.com/enormego/EGOImageLoading.git

###**Screenshot:**
AOTagDemo in the iphone simulator

![AOTagDemo in the simulator][1]

##How To Use It

Sample project show a simple usage.

###Documentation

```objc

@protocol AOTagDelegate <NSObject>

@optional

// Delegate method to handle distant image loading

- (void)tagDistantImageDidLoad:(AOTag *)tag;
- (void)tagDistantImageDidFailLoad:(AOTag *)tag withError:(NSError *)error;

// Delegate method to handle tag action

- (void)tagDidAddTag:(AOTag *)tag;
- (void)tagDidRemoveTag:(AOTag *)tag;
- (void)tagDidSelectTag:(AOTag *)tag;

@end

/**************************
 * Methods to load tags with bundle images
 **************************/

/**
 * Create a new tag object
 *
 * @param tTitle the NSString tag label
 * @param tImage the NSString tag image named
 */
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage;

/**
 * Create a new tag object with custom colors
 *
 * @param tTitle the NSString tag label
 * @param tImage the NSString tag image named
 * @param labelColor the UIColor tag label color. Default color is [UIColor whiteColor]
 * @param backgroundColor the UIColor tag background color. Default color is [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000]
 * @param closeColor the UIColor tag close button color. Default color is [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000]
 */
- (void)addTag:(NSString *)tTitle withImage:(NSString *)tImage withLabelColor:(UIColor *)labelColor withBackgroundColor:(UIColor *)backgroundColor withCloseButtonColor:(UIColor *)closeColor;

/**************************
 * Methods to load tags with distant images
 **************************/

/**
 * Create a new tag object
 *
 * @param tTitle the NSString tag label
 * @param imageURL the NSURL tag image
 * @param tPlaceholderImage the NSString tag image placeholder. If nil no image will be shown will downloading distant image
 */
- (void)addTag:(NSString *)tTitle withImageURL:(NSURL *)imageURL andImagePlaceholder:(NSString *)tPlaceholderImage;

/**
 * Create a new tag object with custom colors
 *
 * @param tTitle the NSString tag label
 * @param tPlaceholderImage the NSString tag image placeholder. If nil no image will be shown will downloading distant image
 * @param imageURL the NSURL tag image
 * @param labelColor the UIColor tag label color. Default color is [UIColor whiteColor]
 * @param backgroundColor the UIColor tag background color. Default color is [UIColor colorWithRed:0.204 green:0.588 blue:0.855 alpha:1.000]
 * @param closeColor the UIColor tag close button color. Default color is [UIColor colorWithRed:0.710 green:0.867 blue:0.953 alpha:1.000]
 */
- (void)addTag:(NSString *)tTitle withImagePlaceholder:(NSString *)tPlaceholderImage withImageURL:(NSURL *)imageURL withLabelColor:(UIColor *)labelColor withBackgroundColor:(UIColor *)backgroundColor withCloseButtonColor:(UIColor *)closeColor;

/**************************
 * Common methods for tags
 **************************/

/**
 * Create a new tags object and add them to the tag list view.
 *
 * @param tags the NSArray tag list to be added. The given tag must be of NSDictionary type (ie. @{@"title": @"Tyrion", @"image": @"tyrion.jpg"})
 */
- (void)addTags:(NSArray *)tags;

/**
 * Remove the given tag from the tag list view
 *
 * @param tag the AOTag instance to be removed
 */
- (void)removeTag:(AOTag *)tag;

/**
 * Remove all tags object
 */
- (void)removeAllTag;
    
```

###Code snippet

```objc
// First add the tag container view in your view controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0.0f,
                                                           50.0f,
                                                           320.0f,
                                                           300.0f)];
    
	[self.view addSubview:self.tag];

	// Then add new tag
	[self.tag addTag:@"my tag title" withImage:@"myTagImage.png"];
}
    
```

```objc
// Add tag with specific label, background and close button color
// If nil, custom color are used

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0.0f,
                                                           50.0f,
                                                           320.0f,
                                                           300.0f)];
    
	[self.view addSubview:self.tag];

	// Then add new tag
	[self.tag addTag:@"my tag title"
               withImage:[UIImage imageNamed:"myTagImage.png"]
          withLabelColor:[UIColor blackColor]
     withBackgroundColor:[UIColor redColor]
    withCloseButtonColor:[UIColor whiteColor]];
}
    
```

```objc
// Add tag with specific label, background and close button color with distant tag image and tag image placeholder
// If nil placeholder image, no image will be used as a placeholder
// If nil distant image URL, no image will be downloaded
// If nil custom color, built in colors are used

@see - (IBAction)addCustomColorTagWithDistantImage:(id)sender method in demo project

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0.0f,
                                                           50.0f,
                                                           320.0f,
                                                           300.0f)];
    
	[self.view addSubview:self.tag];

	// Then add new tag
    [self.tag addTag:@"my tag title"
               withImagePlaceholder:[UIImage imageNamed:"myTagImage.png"]
            withImageURL:[NSURL URLWithString:@"http://myTagDistantURL"]
          withLabelColor:[UIColor blackColor]
     withBackgroundColor:[colors objectAtIndex:arc4random() % [colors count]]
    withCloseButtonColor:[UIColor whiteColor]];
}
    
```

```objc
// Add tag with specific label, background and close button color with distant tag image and tag image placeholder
// If nil distant image URL, no image will be downloaded
// If nil custom color, built in colors are used

@see - (IBAction)addRandomTagWithDistantImage:(id)sender method in demo project

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.tag = [[AOTagList alloc] initWithFrame:CGRectMake(0.0f,
                                                           50.0f,
                                                           320.0f,
                                                           300.0f)];
    
	[self.view addSubview:self.tag];

	// Then add new tag
    [self.tag addTag:@"my tag title" withImageURL:[NSURL URLWithString:@"http://myTagDistantURL"] andImagePlaceholder:[UIImage imageNamed:"myTagImage.png"]];
}
    
```

Any comments are welcomed

@Appsido
contact@appsido.com

 [1]:http://public.appsido.com/iPhone/public/AOTag/AOTagScreen_1.1.png
