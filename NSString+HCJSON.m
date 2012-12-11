/*
 * NSString+CarbonateJSON.m
 * CarbonateJSON
 * 
 * Created by Árpád Goretity on 02/12/2011.
 * Licensed under a CreativeCommons Attribution 3.0 Unported License
 */

#import "NSString+HCJSON.h"

@implementation NSString (HCJSON)

- (id <HCJCocoaContainer>)parseJSON
{
	const char *json = [self UTF8String];
	id <HCJCocoaContainer> obj = CJParseCString(json, -1);
	return obj;
}

@end
