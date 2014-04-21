//
//  RKPostJobs.m
//  Rekognition_iOS_SDK
//
//  Created by cys on 7/20/13.
//  Copyright (c) 2013 Orbeus Inc. All rights reserved.
//

#import "ReKognitionSDK.h"

@interface ReKognitionSDK()
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;
@property (strong, nonatomic) NSString *namespace;
@property (strong, nonatomic) NSString *userid;
@end


@implementation ReKognitionSDK

- (id)initWithAPIKey:(NSString *)key APISecret:(NSString *)secret namespace:(NSString *)nameSpace userid:(NSString *)userid {
    self = [super init];
    if (self) {
        self.apiKey = key;
        self.apiSecret = secret;
        self.namespace = nameSpace;
        self.userid = userid;
    }
    return self;
}


- (id)initWithAPIKey:(NSString *)key APISecret:(NSString *)secret {
    return [self initWithAPIKey:key APISecret:secret namespace:nil userid:nil];
}


- (NSData *)dictionaryToUrlData:(NSDictionary *)dict {
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    NSArray *keys = [dict allKeys];
    if ([dict count] > 0) {
        [bodyString appendFormat:@"%@=%@", keys[0], [dict valueForKey:keys[0]]];
        for(int i = 1; i < [dict count]; i++) {
            [bodyString appendFormat:@"&%@=%@", keys[i], [dict valueForKey:keys[i]]];
        }
    }
    return [bodyString dataUsingEncoding:NSUTF8StringEncoding];
}


- (NSData *)postReKognitionJobs:(NSDictionary *) jobsDictionary {
    NSData *data = [self dictionaryToUrlData:jobsDictionary];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    NSString *url = @"http://rekognition.com/func/api/";
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if([responseCode statusCode] != 200 || error){
        NSLog(@"Error getting response: HTTP status code: %i, Error: %@", [responseCode statusCode], [error localizedDescription]);
        return nil;
    }
    return oResponseData;
}


- (NSString *)parseFaceDetectJobs:(FaceDetectJobs)jobs {
    NSMutableString *builder = [[NSMutableString alloc] init];
    if (jobs & FaceDetectAggressive) [builder appendString:@"_aggressive"];
    if (jobs & FaceDetectPart) [builder appendString:@"_part"];
    if (jobs & FaceDetectPartDetail) [builder appendString:@"_part_detail"];
    if (jobs & FaceDetectGender) [builder appendString:@"_gender"];
    if (jobs & FaceDetectEmotion) [builder appendString:@"_emotion"];
    if (jobs & FaceDetectRace) [builder appendString:@"_race"];
    if (jobs & FaceDetectAge) [builder appendString:@"_age"];
    if (jobs & FaceDetectGlass) [builder appendString:@"_glass"];
    if (jobs & FaceDetectMouthOpen) [builder appendString:@"_mouth_open_wide"];
    if (jobs & FaceDetectEyeClosed) [builder appendString:@"_eye_closed"];
    if (jobs & FaceDetectSmile) [builder appendString:@"_smile"];
    return builder;
}


// ReKognition Face Detect Function
- (RKFaceDetectResults *)RKFaceDetect:(UIImage *)image jobs:(FaceDetectJobs)jobs {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSDictionary * jobsDictionary = @{@"api_key": self.apiKey,
                                      @"api_secret": self.apiSecret,
                                      @"jobs": [@"face" stringByAppendingString:jobsString],
                                      @"base64": encodedString};
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceDetectResponse:data];
}


- (RKFaceDetectResults *)RKFaceDetectWithUrl:(NSURL *)imageUrl jobs:(FaceDetectJobs)jobs {
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSDictionary * jobsDictionary = @{@"api_key": self.apiKey,
                                      @"api_secret": self.apiSecret,
                                      @"jobs": [@"face" stringByAppendingString:jobsString],
                                      @"urls": [imageUrl absoluteString]};
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceDetectResponse:data];
}


// ReKognition Face Add Function
- (RKFaceDetectResults *)RKFaceAdd:(UIImage *)image faceDetectJobs:(FaceDetectJobs)jobs assignedTag:(NSString *)tag {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_add" stringByAppendingString:jobsString],
                                                                                           @"base64": encodedString}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (tag) {
        [jobsDictionary setObject:tag forKey:@"tag"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceAddResponse:data];
}

- (RKFaceDetectResults *)RKFaceAddWithUrl:(NSURL *)imageUrl faceDetectJobs:(FaceDetectJobs)jobs assignedTag:(NSString *)tag {
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_add" stringByAppendingString:jobsString],
                                                                                           @"urls": [imageUrl absoluteString]}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (tag) {
        [jobsDictionary setObject:tag forKey:@"tag"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceAddResponse:data];
}


//ReKognition Face Train Function
- (RKBaseResults *)RKFaceTrain:(NSArray *)selectedTags {
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret}];
    if (selectedTags) {
        [jobsDictionary setObject:@"face_train_sync" forKey:@"jobs"];
        [jobsDictionary setObject:[selectedTags componentsJoinedByString:@";"] forKey:@"tags"];
    } else {
        [jobsDictionary setObject:@"face_train" forKey:@"jobs"];
    }
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceTrainResponse:data];
}


// ReKognition Face Cluster Function
- (RKFaceClusterResults *)RKFaceCluster:(NSNumber *)aggressiveness {
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": @"face_cluster"}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (aggressiveness) {
        [jobsDictionary setObject:aggressiveness forKey:@"aggressiveness"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceClusterResponse:data];
}


// ReKognition Face Crawl Function
- (RKFaceCrawlResults *)RKFaceCrawl:(NSString *)fb_id accessToken:(NSString *)access_token friendIds:(NSArray *)friends_ids {
    NSString *temp_string = [friends_ids componentsJoinedByString:@";"];
    NSString *crawl_string = [@"face_crawl_" stringByAppendingFormat:@"[%@]", temp_string];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": crawl_string,
                                                                                           @"fb_id": fb_id,
                                                                                           @"access_token": access_token}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceCrawlResponse:data];
}


//ReKognition Face Recognize Function
- (RKFaceDetectResults *)RKFaceRecognize:(UIImage *)image faceDetectJobs:(FaceDetectJobs)jobs resultsNum:(NSNumber *)num_return amongTags:(NSArray *)tags {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_recognize" stringByAppendingString:jobsString],
                                                                                           @"base64": encodedString}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (num_return) {
        [jobsDictionary setObject:num_return forKey:@"num_return"];
    }
    if (tags) {
        [jobsDictionary setObject:[tags componentsJoinedByString:@";"] forKey:@"tags"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceRecognizeResponse:data];
}

- (RKFaceDetectResults *)RKFaceRecognizeWithUrl:(NSURL *)imageUrl faceDetectJobs:(FaceDetectJobs)jobs resultsNum:(NSNumber *)num_return amongTags:(NSArray *)tags {
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_recognize" stringByAppendingString:jobsString],
                                                                                           @"urls": [imageUrl absoluteString]}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (num_return) {
        [jobsDictionary setObject:num_return forKey:@"num_return"];
    }
    if (tags) {
        [jobsDictionary setObject:[tags componentsJoinedByString:@";"] forKey:@"tags"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceRecognizeResponse:data];
}


// ReKognition Face Visualize Function
- (RKFaceVisualizeResults *)RKFaceVisualize:(NSArray *)selectedTags showImages:(BOOL)flag imagesPerTag:(NSNumber *)num_img_return_pertag {
    NSString *jobsString = @"face_visualize_show_default_tag";
    if (!flag) {
        jobsString = [jobsString stringByAppendingString:@"_no_image"];
    }
    
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": jobsString}];
    if (selectedTags) {
        [jobsDictionary setObject:[selectedTags componentsJoinedByString:@";"] forKey:@"tags"];
    }
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (num_img_return_pertag) {
        [jobsDictionary setObject:num_img_return_pertag forKey:@"num_img_return_pertag"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceVisualizeResponse:data];
}


// ReKognition Face Search Function
- (RKFaceDetectResults *)RKFaceSearch:(UIImage *)image faceDetectJobs:(FaceDetectJobs)jobs resultsNum:(NSNumber *)num_return amongTags:(NSArray *)tags {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_search" stringByAppendingString:jobsString],
                                                                                           @"base64": encodedString}];
    if (tags) {
        [jobsDictionary setObject:[tags componentsJoinedByString:@";"] forKey:@"tags"];
    }
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (num_return) {
        [jobsDictionary setObject:num_return forKey:@"num_return"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceSearchResponse:data];
}

- (RKFaceDetectResults *)RKFaceSearchWithUrl:(NSURL *)imageUrl faceDetectJobs:(FaceDetectJobs)jobs resultsNum:(NSNumber *)num_return amongTags:(NSArray *)tags {
    NSString *jobsString = [self parseFaceDetectJobs:jobs];
    NSMutableDictionary * jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                           @"api_secret": self.apiSecret,
                                                                                           @"jobs": [@"face_search" stringByAppendingString:jobsString],
                                                                                           @"urls": [imageUrl absoluteString]}];
    if (tags) {
        [jobsDictionary setObject:[tags componentsJoinedByString:@";"] forKey:@"tags"];
    }
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    if (num_return) {
        [jobsDictionary setObject:num_return forKey:@"num_return"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceSearchResponse:data];
}


// ReKognition Face Delete Function
- (RKBaseResults *)RKFaceDelete:(NSString *)tag imageIndex:(NSArray *)img_index_array {
    NSMutableDictionary *jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                          @"api_secret": self.apiSecret,
                                                                                          @"jobs": @"face_delete"}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    } else {
        [jobsDictionary setObject:@"default" forKey:@"user_id"];
    }
    if (tag) {
        [jobsDictionary setObject:tag forKey:@"tag"];
    }
    if (img_index_array) {
        [jobsDictionary setObject:[img_index_array componentsJoinedByString:@";"] forKey:@"img_index"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceDeleteResponse:data];
}


//ReKognition Face Rename Function
- (RKBaseResults *)RKFaceRenameOrMergeTag:(NSString *)oldTag withTag:(NSString *)newTag onlySelectedFaces:(NSArray *)img_index_array {
    NSMutableDictionary *jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                          @"api_secret": self.apiSecret,
                                                                                          @"jobs": @"face_rename",
                                                                                          @"tag": oldTag,
                                                                                          @"new_tag": newTag}];
    if (img_index_array) {
        [jobsDictionary setObject:[img_index_array componentsJoinedByString:@";"] forKey:@"img_index"];
    }
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    if (self.userid) {
        [jobsDictionary setObject:self.userid forKey:@"user_id"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseFaceRenameResponse:data];
}


// ReKognition Face Stats Function
- (RKNameSpaceStatsResults *)RKNameSpaceStats {
    NSDictionary *jobsDictionary = @{@"api_key": self.apiKey,
                                     @"api_secret": self.apiSecret,
                                     @"jobs": @"face_name_space_stats"};
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseNameSpaceStatsResponse:data];
}

- (RKUserIdStatsResults *)RKUserIdStats {
    NSMutableDictionary *jobsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"api_key": self.apiKey,
                                                                                          @"api_secret": self.apiSecret,
                                                                                          @"jobs": @"face_user_id_stats"}];
    if (self.namespace) {
        [jobsDictionary setObject:self.namespace forKey:@"name_space"];
    }
    NSData *data = [self postReKognitionJobs:jobsDictionary];
    return [ReKognitionResponseParser parseUserIdStatsResponse:data];
}


// ReKognition Scene Understanding Function
- (RKSceneUnderstandingResults *)RKSceneUnderstanding:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSDictionary * jobDictionary = @{@"api_key": self.apiKey,
                                     @"api_secret": self.apiSecret,
                                     @"jobs": @"scene",
                                     @"base64": encodedString};
    NSData *data = [self postReKognitionJobs:jobDictionary];
    return [ReKognitionResponseParser parseSceneUnderstandingResponse:data];
}

- (RKSceneUnderstandingResults *)RKSceneUnderstandingWithUrl:(NSURL *)imageUrl {
    NSDictionary * jobDictionary = @{@"api_key": self.apiKey,
                                     @"api_secret": self.apiSecret,
                                     @"jobs": @"scene",
                                     @"urls": imageUrl};
    NSData *data = [self postReKognitionJobs:jobDictionary];
    return [ReKognitionResponseParser parseSceneUnderstandingResponse:data];
}

@end
