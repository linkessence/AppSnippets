//
//  SDWebImageDataSource.m
//  Sample
//
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "SDWebImageDataSource.h"
#import "KTPhotoView+SDWebImage.h"
#import "KTThumbView+SDWebImage.h"

#define FULL_SIZE_INDEX 0
#define THUMBNAIL_INDEX 1

@implementation SDWebImageDataSource

- (void)dealloc {
   [images_ release], images_ = nil;
   [super dealloc];
}

- (id)init {
   self = [super init];
   if (self) {
      // Create a 2-dimensional array. First element of
      // the sub-array is the full size image URL and 
      // the second element is the thumbnail URL.
      images_ = [[NSArray alloc] initWithObjects:
                 [NSArray arrayWithObjects:@"http://farm3.static.flickr.com/2735/4430131154_95212b8e88_o.jpg", @"http://farm3.static.flickr.com/2735/4430131154_17d8a02b8c_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm5.static.flickr.com/4001/4439826859_19ba9a6cfa_o.jpg", @"http://farm5.static.flickr.com/4001/4439826859_4215c01a16_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm4.static.flickr.com/3427/3192205971_0f494a3da2_o.jpg", @"http://farm4.static.flickr.com/3427/3192205971_b7b18558db_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm2.static.flickr.com/1316/4722532733_6b73d00787_z.jpg", @"http://farm2.static.flickr.com/1316/4722532733_6b73d00787_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm2.static.flickr.com/1200/591574815_8a4a732d00_o.jpg", @"http://farm2.static.flickr.com/1200/591574815_29db79a63a_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm4.static.flickr.com/3610/3439180743_21b8799d82_o.jpg", @"http://farm4.static.flickr.com/3610/3439180743_b7b07df9d4_s.jpg", nil],
                 [NSArray arrayWithObjects:@"http://farm3.static.flickr.com/2721/4441122896_eec9285a67.jpg", @"http://farm3.static.flickr.com/2721/4441122896_eec9285a67_s.jpg", nil],
                 nil];
   }
   return self;
}


#pragma mark -
#pragma mark KTPhotoBrowserDataSource

- (NSInteger)numberOfPhotos {
   NSInteger count = [images_ count];
   return count;
}

- (void)imageAtIndex:(NSInteger)index photoView:(KTPhotoView *)photoView {
   NSArray *imageUrls = [images_ objectAtIndex:index];
   NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
   [photoView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView {
   NSArray *imageUrls = [images_ objectAtIndex:index];
   NSString *url = [imageUrls objectAtIndex:THUMBNAIL_INDEX];
   [thumbView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}


@end
