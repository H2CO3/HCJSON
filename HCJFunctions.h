/*
 * HCJFunctions.h
 * HCJSON
 * 
 * Created by Árpád Goretity on 02/12/2011.
 * Licensed under a CreativeCommons Attribution 3.0 Unported License
 */

#import <string.h>
#import <stdlib.h>
#import <unistd.h>
#import <jsonz/jsonz.h>
#import <Foundation/Foundation.h>

@protocol HCJCocoaContainer <NSObject, NSCopying, NSMutableCopying, NSCoding, NSFastEnumeration>
@end

id <HCJCocoaContainer> CJParseCString(const char *json, ssize_t length);
