//
//  ReKognitionResults.h
//  StacheCam
//
//  Created by Yushan on 10/25/13.
//
//  Result data classes and parsers for ReKognition APIs.

#import <Foundation/Foundation.h>

struct RKPose {
    CGFloat roll;
    CGFloat yaw;
    CGFloat pitch;
};
typedef struct RKPose RKPose;


@interface FaceDetectItem : NSObject
@property (nonatomic) CGRect boundingbox;
@property (nonatomic) CGFloat confidence;
@property (nonatomic) CGPoint eye_left;
@property (nonatomic) CGPoint eye_right;
@property (nonatomic) CGPoint nose;
@property (nonatomic) CGPoint mouth_l;
@property (nonatomic) CGPoint mouth_r;
@property (nonatomic) RKPose pose;
@property (strong, nonatomic) NSArray * matched_emotions;
@property (strong, nonatomic) NSArray * matched_emotion_scores;
@property (strong, nonatomic) NSArray * matched_races;
@property (strong, nonatomic) NSArray * matched_race_scores;
@property (nonatomic) CGFloat smile;
@property (nonatomic) CGFloat age;
@property (nonatomic) CGFloat wear_glasses;
@property (nonatomic) CGFloat eye_closed;
@property (nonatomic) CGFloat mouth_open_wide;
@property (nonatomic) CGFloat sex;
@end


@interface FaceAddItem : FaceDetectItem
@property (strong, nonatomic) NSString * img_index;
@end


@interface FaceClusterItem : NSObject
@property (strong, nonatomic) NSString * tag;
@property (strong, nonatomic) NSArray * img_indices;
@end


@interface FaceRecognizeItem : FaceDetectItem
@property (strong, nonatomic) NSArray * matched_names;
@property (strong, nonatomic) NSArray * matched_name_scores;
@end


@interface FaceVisualizeItem : NSObject
@property (strong, nonatomic) NSString * tag;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSArray * img_indices;
@end


@interface FaceSearchItem: FaceDetectItem
@property (strong, nonatomic) NSArray * matched_tags;
@property (strong, nonatomic) NSArray * matched_img_indices;
@property (strong, nonatomic) NSArray * matched_scores;
@end


@interface NameSpaceStatsItem : NSObject
@property (strong, nonatomic) NSString * name_space;
@property (nonatomic) NSInteger num_user_id;
@property (nonatomic) NSInteger num_tags;
@property (nonatomic) NSInteger num_img;
@end


@interface UserIdStatsItem : NSObject
@property (strong, nonatomic) NSString *user_id;
@property (nonatomic) NSInteger num_tags;
@property (nonatomic) NSInteger num_img;
@end


@interface RKBaseResults : NSObject
@property (strong, nonatomic) NSData * rawResponse;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) NSString * api_id;
@property (nonatomic) NSInteger quota;
@end


// Result data class for FaceDect, FaceAdd, FaceRecognize, and FaceSearch API call.
@interface RKFaceDetectResults : RKBaseResults
@property (strong, nonatomic) NSString * url;
@property (nonatomic) CGSize rawImageSize;
@property (strong, nonatomic) NSArray * faceDetectOrALikeItems;    // List of FaceDetectItem, FaceAddItem, FaceRecognizeItem, or FaceSearchItem depending on the parsing method used.
@end


@interface RKFaceClusterResults : RKBaseResults
@property (strong, nonatomic) NSArray * faceClusterItems;   // List of FaceClusterItem
@end


@interface RKFaceCrawlResults : RKBaseResults
@property (nonatomic) NSInteger faceCount;
@end


@interface RKFaceVisualizeResults : RKBaseResults
@property (strong, nonatomic) NSArray * faceVisualizeItems; // List of FaceVisualizeItem
@end


@interface RKNameSpaceStatsResults : RKBaseResults
@property (strong, nonatomic) NSArray * nameSpaceStatsItems;    // List of NameSpaceStatsItem
@end


@interface RKUserIdStatsResults : RKBaseResults
@property (strong, nonatomic) NSArray * userIdStatsItems;   // List of UserIdStatsItem
@end


@interface RKSceneUnderstandingResults : RKBaseResults
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSArray * matched_scenes;
@property (strong, nonatomic) NSArray * matched_scene_scores;
@end


@interface ReKognitionResponseParser : NSObject
+ (RKFaceDetectResults *)parseFaceDetectResponse:(NSData *)response;
+ (RKFaceDetectResults *)parseFaceAddResponse:(NSData *)response;
+ (RKBaseResults *)parseFaceTrainResponse:(NSData *)response;
+ (RKFaceClusterResults *)parseFaceClusterResponse:(NSData *)response;
+ (RKFaceCrawlResults *)parseFaceCrawlResponse:(NSData *)response;
+ (RKFaceDetectResults *)parseFaceRecognizeResponse:(NSData *)response;
+ (RKFaceVisualizeResults *)parseFaceVisualizeResponse:(NSData *)response;
+ (RKFaceDetectResults *)parseFaceSearchResponse:(NSData *)response;
+ (RKBaseResults *)parseFaceDeleteResponse:(NSData *)response;
+ (RKBaseResults *)parseFaceRenameResponse:(NSData *)response;
+ (RKNameSpaceStatsResults *)parseNameSpaceStatsResponse:(NSData *)response;
+ (RKUserIdStatsResults *)parseUserIdStatsResponse:(NSData *)response;
+ (RKSceneUnderstandingResults *)parseSceneUnderstandingResponse:(NSData *)response;
@end

