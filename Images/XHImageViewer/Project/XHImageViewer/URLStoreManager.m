//
//  URLStoreManager.m
//  XHImageViewer
//
//  Created by 曾 宪华 on 14-2-18.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "URLStoreManager.h"

@implementation URLStoreManager

+ (NSURL *)getUrlWithIndex:(NSInteger)index {
    NSURL *url = nil;
    switch (index) {
        case 0:
            break;
        case 1:
            url = [NSURL URLWithString:@"http://ui4app.qiniudn.com/photo/app/52abee8acb7e843b688b6c64.png"];
            break;
        case 2:
            url = [NSURL URLWithString:@"http://ui4app.qiniudn.com/photo/app/52abee7ecb7e841e178b6f09.png"];
            break;
        case 3:
            url = [NSURL URLWithString:@"http://ui4app.qiniudn.com/photo/app/529df265cb7e84c30b8b5080.jpg"];
            break;
        default:
            break;
    }
    return url;
}
@end
