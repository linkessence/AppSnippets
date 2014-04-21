//
//  RKPostJobs.h
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//
//  Wrapper for ReKognition APIs.

#import <Foundation/Foundation.h>
#import "ReKognitionResults.h"

typedef NS_OPTIONS(NSUInteger, FaceDetectJobs) {
    FaceDetectAggressive = 1UL << 1,
    FaceDetectPart = 1UL << 2,
    FaceDetectPartDetail = 1UL << 3,
    FaceDetectGender = 1UL << 4,
    FaceDetectEmotion = 1UL << 5,
    FaceDetectRace = 1UL << 6,
    FaceDetectAge = 1UL << 7,
    FaceDetectGlass = 1UL << 8,
    FaceDetectMouthOpen = 1UL << 9,
    FaceDetectEyeClosed = 1UL << 10,
    FaceDetectSmile = 1UL << 11
};


@interface ReKognitionSDK : NSObject

- (id)initWithAPIKey:(NSString *)key APISecret:(NSString *)secret namespace:(NSString *)nameSpace userid:(NSString *)userid;
- (id)initWithAPIKey:(NSString *)key APISecret:(NSString *)secret; // "default" will be used for namespace and userid.


// ReKognition Post Jobs Function (to customize your own recognition functions)
- (NSData *)postReKognitionJobs:(NSDictionary *)jobsDictionary;


// ReKognition Face Detect Function (if not set, jobs is "face_aggressive" by default)
- (RKFaceDetectResults *)RKFaceDetect:(UIImage*)image
                                 jobs:(FaceDetectJobs)jobs;
- (RKFaceDetectResults *)RKFaceDetectWithUrl:(NSURL *)imageUrl
                                        jobs:(FaceDetectJobs)jobs;


// ReKognition Face Add Function
- (RKFaceDetectResults *)RKFaceAdd:(UIImage*)image
                    faceDetectJobs:(FaceDetectJobs)jobs
                       assignedTag:(NSString *)tag;             // If nil, assigned to untagged group
- (RKFaceDetectResults *)RKFaceAddWithUrl:(NSURL *)imageUrl
                           faceDetectJobs:(FaceDetectJobs)jobs
                              assignedTag:(NSString *)tag;      // If nil, assigned to untagged group


// ReKognition Face Train Function
- (RKBaseResults *)RKFaceTrain:(NSArray *)selectedTags;         // If nil, train all tags


// ReKognition Face Cluster Function
- (RKFaceClusterResults *)RKFaceCluster:(NSNumber *)aggressiveness;     // If nil, use 40


// ReKognition Face Crawl Function
- (RKFaceCrawlResults *)RKFaceCrawl:(NSString *)fb_id
                        accessToken:(NSString *)access_token
                          friendIds:(NSArray *)friends_ids;


// ReKognition Face Recognize Function
- (RKFaceDetectResults *)RKFaceRecognize:(UIImage *)image
                          faceDetectJobs:(FaceDetectJobs)jobs
                              resultsNum:(NSNumber *)num_return         // If nil, return 3 results
                               amongTags:(NSArray *)tags;               // If nil, recognize among all tags
- (RKFaceDetectResults *)RKFaceRecognizeWithUrl:(NSURL *)imageUrl
                                 faceDetectJobs:(FaceDetectJobs)jobs
                                     resultsNum:(NSNumber *)num_return  // If nil, returns 3 retuls
                                      amongTags:(NSArray *)tags;        // If nil, recognize among all tags


// ReKognition Face Visualize Function
- (RKFaceVisualizeResults *)RKFaceVisualize:(NSArray *)selectedTags             // If nil, return all tags
                                 showImages:(BOOL)flag
                               imagesPerTag:(NSNumber *)num_img_return_pertag;  // If nil, return all images


// ReKognition Face Search Function
- (RKFaceDetectResults *)RKFaceSearch:(UIImage *)image
                       faceDetectJobs:(FaceDetectJobs)jobs
                           resultsNum:(NSNumber *)num_return        // If nil, return all results
                            amongTags:(NSArray *)tags;              // If nil, search among all tags
- (RKFaceDetectResults *)RKFaceSearchWithUrl:(NSURL *)imageUrl
                              faceDetectJobs:(FaceDetectJobs)jobs
                                  resultsNum:(NSNumber *)num_return // If nil, return all results
                                   amongTags:(NSArray *)tags;       // If nil, search among all tags


// ReKognition Face Delete Function
- (RKBaseResults *)RKFaceDelete:(NSString *)tag                     // If nil, entire user_id is removed
                     imageIndex:(NSArray *)img_index_array;         // If nil, entire tag is removed


// ReKognition Face Rename/Merge/Assign Function
- (RKBaseResults *)RKFaceRenameOrMergeTag:(NSString *)oldTag
                                  withTag:(NSString *)newTag
                        onlySelectedFaces:(NSArray *)img_index_array;    // If nil, rename all images under the tag


// ReKognition Face Stats
- (RKNameSpaceStatsResults *)RKNameSpaceStats;
- (RKUserIdStatsResults *)RKUserIdStats;


// ReKognition Scene Understadning Function
- (RKSceneUnderstandingResults *)RKSceneUnderstanding:(UIImage *)image;
- (RKSceneUnderstandingResults *)RKSceneUnderstandingWithUrl:(NSURL *)imageUrl;


@end
