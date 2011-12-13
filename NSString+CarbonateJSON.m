//
// NSString+CarbonateJSON.m
// CarbonateJSON
// 
// Created by Árpád Goretity on 02/12/2011.
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import "NSString+CarbonateJSON.h"
#import "CJFunctions.h"


@implementation NSString (CarbonateJSON)

- (NSObject *) parseJson {
	char *json = [self UTF8String];
	id obj = CJParseCString(json, -1);
	return obj;
}

@end

