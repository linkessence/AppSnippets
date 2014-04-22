//
//  NSObject+KVC.m
//  CloudLabel
//
//  Created by PowerAuras on 13-9-6.
//  qq120971999  http://www.cnblogs.com/powerauras/
//  Copyright (c) 2013年 PowerAuras. All rights reserved.
//

#import "NSObject+KVC.h"

@implementation NSObject(aa)
- (id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, key);
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
