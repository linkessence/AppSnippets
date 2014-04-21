//
//  ReKognitionResults.m
//  StacheCam
//
//  Created by Yushan on 10/25/13.
//
//

#import "ReKognitionResults.h"

@implementation FaceDetectItem @end
@implementation FaceAddItem @end
@implementation FaceClusterItem @end
@implementation FaceRecognizeItem @end
@implementation FaceVisualizeItem @end
@implementation FaceSearchItem @end
@implementation NameSpaceStatsItem @end
@implementation UserIdStatsItem @end
@implementation RKBaseResults @end
@implementation RKFaceDetectResults @end
@implementation RKFaceClusterResults @end
@implementation RKFaceCrawlResults @end
@implementation RKFaceVisualizeResults @end
@implementation RKNameSpaceStatsResults @end
@implementation RKUserIdStatsResults @end
@implementation RKSceneUnderstandingResults @end


@implementation ReKognitionResponseParser

+ (NSDictionary *)parseRawResponse:(NSData *)response baseResults:(RKBaseResults *)baseResults {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    baseResults.rawResponse = response;
    baseResults.status = dict[@"usage"][@"status"];
    baseResults.api_id = dict[@"usage"][@"api_id"];
    baseResults.quota = [dict[@"usage"][@"quota"] integerValue];
    return dict;
}


+ (void)parseFaceDetectionItem:(NSDictionary *)item result:(FaceDetectItem *)result {
    result.boundingbox = CGRectMake([item[@"boundingbox"][@"tl"][@"x"] floatValue],
                                         [item[@"boundingbox"][@"tl"][@"y"] floatValue],
                                         [item[@"boundingbox"][@"size"][@"width"] floatValue],
                                         [item[@"boundingbox"][@"size"][@"height"] floatValue]);
    if (item[@"eye_left"]) {
        result.eye_left = CGPointMake([item[@"eye_left"][@"x"] floatValue], [item[@"eye_left"][@"y"] floatValue]);
    }
    if (item[@"eye_right"]) {
        result.eye_right = CGPointMake([item[@"eye_right"][@"x"] floatValue], [item[@"eye_right"][@"y"] floatValue]);
    }
    if (item[@"mouth_l"]) {
        result.mouth_l = CGPointMake([item[@"mouth_l"][@"x"] floatValue], [item[@"mouth_l"][@"y"] floatValue]);
    }
    if (item[@"mouth_r"]) {
        result.mouth_r = CGPointMake([item[@"mouth_r"][@"x"] floatValue], [item[@"mouth_r"][@"y"] floatValue]);
    }
    if (item[@"nose"]) {
        result.nose = CGPointMake([item[@"nose"][@"x"] floatValue], [item[@"nose"][@"y"] floatValue]);
    }
    if (item[@"confidence"]) {
        result.confidence = [item[@"confidence"] floatValue];
    }
    if (item[@"sex"]) {
        result.sex = [item[@"sex"] floatValue];
    }
    if (item[@"age"]) {
        result.age = [item[@"age"] floatValue];
    }
    if (item[@"glasses"]) {
        result.wear_glasses = [item[@"glasses"] floatValue];
    }
    if (item[@"mouth_open_wide"]) {
        result.mouth_open_wide = [item[@"mouth_open_wide"] floatValue];
    }
    if (item[@"eye_closed"]) {
        result.eye_closed = [item[@"eye_closed"] floatValue];
    }
    if (item[@"smile"]) {
        result.smile = [item[@"smile"] floatValue];
    }
    
    if (item[@"pose"]) {
        RKPose pose;
        pose.roll = [item[@"pose"][@"roll"] floatValue];
        pose.yaw = [item[@"pose"][@"yaw"] floatValue];
        pose.pitch = [item[@"pose"][@"pitch"] floatValue];
        result.pose = pose;
    }
    
    // TODO: check ordering.
    if (item[@"race"]) {
        NSDictionary *raceList = item[@"race"];
        NSMutableArray *races = [NSMutableArray arrayWithCapacity:[raceList count]];
        NSMutableArray *raceScores = [NSMutableArray arrayWithCapacity:[raceList count]];
        for (NSString *race in [raceList allKeys]) {
            [races addObject:race];
            [raceScores addObject:raceList[race]];
        }
        result.matched_races = races;
        result.matched_race_scores = raceScores;
    }
    
    // TODO: check ordering.
    if (item[@"emotion"]) {
        NSDictionary *emotionList = item[@"emotion"];
        NSMutableArray *emotions = [NSMutableArray arrayWithCapacity:[emotionList count]];
        NSMutableArray *emotionScores = [NSMutableArray arrayWithCapacity:[emotionList count]];
        for (NSString *emotion in [emotionList allKeys]) {
            [emotions addObject:emotion];
            [emotionScores addObject:emotionList[emotion]];
        }
        result.matched_emotions = emotions;
        result.matched_emotion_scores = emotionScores;
    }
}


+ (RKFaceDetectResults *)parseFaceDetectResponse:(NSData *)response {
    RKFaceDetectResults * results = [[RKFaceDetectResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    results.url = dict[@"url"];
    results.rawImageSize = CGSizeMake([dict[@"ori_img_size"][@"width"] floatValue], [dict[@"ori_img_size"][@"height"] floatValue]);
    NSArray *list = dict[@"face_detection"];
    NSMutableArray *detections = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceDetectItem *detection = [[FaceDetectItem alloc] init];
        [ReKognitionResponseParser parseFaceDetectionItem:i result:detection];
        [detections addObject:detection];
    }
    results.faceDetectOrALikeItems = detections;
    return results;
}


+ (RKFaceDetectResults *)parseFaceAddResponse:(NSData *)response {
    RKFaceDetectResults *results = [[RKFaceDetectResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    results.url = dict[@"url"];
    results.rawImageSize = CGSizeMake([dict[@"ori_img_size"][@"width"] floatValue], [dict[@"ori_img_size"][@"height"] floatValue]);
    NSArray *list = dict[@"face_detection"];
    NSMutableArray *faceadds = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceAddItem *faceadd = [[FaceAddItem alloc] init];
        [ReKognitionResponseParser parseFaceDetectionItem:i result:faceadd];
        faceadd.img_index = i[@"img_index"];
        [faceadds addObject:faceadd];
    }
    results.faceDetectOrALikeItems = faceadds;
    return results;
}


+ (RKBaseResults *)parseFaceTrainResponse:(NSData *)response {
    RKBaseResults *results = [[RKBaseResults alloc] init];
    [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    return results;
}


+ (RKFaceClusterResults *)parseFaceClusterResponse:(NSData *)response {
    RKFaceClusterResults * results = [[RKFaceClusterResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    NSArray *list = [dict objectForKey:@"clusters"];
    NSMutableArray *clusters = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceClusterItem *cluster = [[FaceClusterItem alloc] init];
        cluster.tag = i[@"tag"];
        cluster.img_indices = i[@"img_index"];
        [clusters addObject:cluster];
    }
    results.faceClusterItems = clusters;
    return results;
}


+ (RKFaceCrawlResults *)parseFaceCrawlResponse:(NSData *)response {
    RKFaceCrawlResults *results = [[RKFaceCrawlResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    results.faceCount = [dict[@"face_found"] integerValue];
    return results;
}


+ (RKFaceDetectResults *)parseFaceRecognizeResponse:(NSData *)response {
    RKFaceDetectResults *results = [[RKFaceDetectResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    results.url = dict[@"url"];
    results.rawImageSize = CGSizeMake([dict[@"ori_img_size"][@"width"] floatValue], [dict[@"ori_img_size"][@"height"] floatValue]);
    NSArray *list = dict[@"face_detection"];
    NSMutableArray *recognitions = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceRecognizeItem *recognition = [[FaceRecognizeItem alloc] init];
        [ReKognitionResponseParser parseFaceDetectionItem:i result:recognition];
        NSArray *matches = i[@"matches"];
        NSMutableArray *matchedTags = [NSMutableArray arrayWithCapacity:[matches count]];
        NSMutableArray *matchedScores = [NSMutableArray arrayWithCapacity:[matches count]];
        for (NSDictionary *j in matches) {
            [matchedTags addObject:j[@"tag"]];
            [matchedScores addObject:j[@"score"]];
        }
        recognition.matched_names = matchedTags;
        recognition.matched_name_scores = matchedScores;
        [recognitions addObject:recognition];
    }
    results.faceDetectOrALikeItems = recognitions;
    return results;
}


+ (RKFaceVisualizeResults *)parseFaceVisualizeResponse:(NSData *)response {
    RKFaceVisualizeResults * results = [[RKFaceVisualizeResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    NSArray *list = [dict objectForKey:@"visualization"];
    NSMutableArray *visualizations = [[NSMutableArray alloc] initWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceVisualizeItem * visualization = [[FaceVisualizeItem alloc] init];
        visualization.tag = i[@"tag"];
        visualization.url = i[@"url"];
        visualization.img_indices = i[@"index"];
        [visualizations addObject:visualization];
    }
    results.faceVisualizeItems = visualizations;
    return results;
}


+ (RKFaceDetectResults *)parseFaceSearchResponse:(NSData *)response {
    RKFaceDetectResults * results = [[RKFaceDetectResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    results.url = dict[@"url"];
    results.rawImageSize = CGSizeMake([dict[@"ori_img_size"][@"width"] floatValue], [dict[@"ori_img_size"][@"height"] floatValue]);
    NSArray *list = dict[@"face_detection"];
    NSMutableArray *searches = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        FaceSearchItem *search = [[FaceSearchItem alloc] init];
        [self parseFaceDetectionItem:i result:search];
        NSArray *matches = i[@"matches"];
        NSMutableArray *matchedTags = [NSMutableArray arrayWithCapacity:[matches count]];
        NSMutableArray *matchedImageIndices = [NSMutableArray arrayWithCapacity:[matches count]];
        NSMutableArray *matchedScores = [NSMutableArray arrayWithCapacity:[matches count]];
        for (NSDictionary *j in matches) {
            [matchedTags addObject:j[@"tag"]];
            [matchedImageIndices addObject:j[@"img_index"]];
            [matchedScores addObject:j[@"score"]];
        }
        search.matched_tags = matchedTags;
        search.matched_img_indices = matchedImageIndices;
        search.matched_scores = matchedScores;
        [searches addObject:search];
    }
    results.faceDetectOrALikeItems = searches;
    return results;
}


+ (RKBaseResults *)parseFaceDeleteResponse:(NSData *)response {
    RKBaseResults *results = [[RKBaseResults alloc] init];
    [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    return results;
}


+ (RKBaseResults *)parseFaceRenameResponse:(NSData *)response {
    RKBaseResults *results = [[RKBaseResults alloc] init];
    [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    return results;
}


+ (RKNameSpaceStatsResults *)parseNameSpaceStatsResponse:(NSData *)response {
    RKNameSpaceStatsResults * results = [[RKNameSpaceStatsResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    NSArray *list = dict[@"name_space_stats"];
    NSMutableArray *stats = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        NameSpaceStatsItem *stat = [[NameSpaceStatsItem alloc] init];
        stat.name_space = i[@"name_space"];
        stat.num_user_id = [i[@"num_user_id"] integerValue];
        stat.num_tags = [i[@"num_tags"] integerValue];
        stat.num_img = [i[@"num_img"] integerValue];
        [stats addObject:stat];
    }
    results.nameSpaceStatsItems = stats;
    return results;
}


+ (RKUserIdStatsResults *)parseUserIdStatsResponse:(NSData *)response {
    RKUserIdStatsResults * results = [[RKUserIdStatsResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    NSArray *list = dict[@"user_id_stats"];
    NSMutableArray *stats = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        UserIdStatsItem *stat = [[UserIdStatsItem alloc] init];
        stat.user_id = i[@"user_id"];
        stat.num_tags = [i[@"num_tags"] integerValue];
        stat.num_img = [i[@"num_img"] integerValue];
        [stats addObject:stat];
    }
    results.userIdStatsItems = stats;
    return results;
}


+ (RKSceneUnderstandingResults *)parseSceneUnderstandingResponse:(NSData *)response {
    RKSceneUnderstandingResults * results = [[RKSceneUnderstandingResults alloc] init];
    NSDictionary *dict = [ReKognitionResponseParser parseRawResponse:response baseResults:results];
    
    results.url = dict[@"url"];
    NSArray *list = dict[@"scene_understanding"];
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:[list count]];
    NSMutableArray *scores = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSDictionary *i in list) {
        [labels addObject:i[@"label"]];
        [scores addObject:i[@"score"]];
    }
    results.matched_scenes = labels;
    results.matched_scene_scores = scores;
    return results;
}
@end

