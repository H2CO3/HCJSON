//
// NSDictionary+CarbonateJSON.h
// CarbonateJSON
// 
// Created by Árpád Goretity on 02/12/2011.
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import <string.h>
#import "NSDictionary+CarbonateJSON.h"
#import "NSArray+CarbonateJSON.h"


@implementation NSDictionary (CarbonateJSON)

- (NSString *) generateJson {
	NSMutableString *json = [NSMutableString string];
	[json appendString:@"{"];
	int count = [self count];
	for (int i = 0; i < count; i++) {
		if (i > 0) {
			[json appendString:@", "];
		}
		NSString *key = [[self allKeys] objectAtIndex:i];
		NSObject *obj = [self objectForKey:key];
		[json appendFormat:@"\"%@\": ", key];
		if ([obj isKindOfClass:[NSString class]]) {
			[json appendFormat:@"\"%@\"", obj];
		} else if ([obj isKindOfClass:[NSDate class]]) {
			[json appendFormat:@"\"%@\"", obj];
		} else if ([obj isKindOfClass:[NSNumber class]]) {
			if (strcmp([(NSNumber *)obj objCType], @encode(BOOL)) == 0) {
				[json appendString:[(NSNumber *)obj boolValue] ? @"true" : @"false"];
			} else if (strcmp([(NSNumber *)obj objCType], @encode(float)) == 0) {
				[json appendFormat:@"%f", [(NSNumber *)obj floatValue]];
			} else if (strcmp([(NSNumber *)obj objCType], @encode(double)) == 0) {
				[json appendFormat:@"%lf", [(NSNumber *)obj doubleValue]];
			} else if (strcmp([(NSNumber *)obj objCType], @encode(unsigned int)) == 0) {
				[json appendFormat:@"%u", [(NSNumber *)obj unsignedIntValue]];
			} else if (strcmp([(NSNumber *)obj objCType], @encode(unsigned long int)) == 0) {
				[json appendFormat:@"%lu", [(NSNumber *)obj unsignedLongValue]];
			} else if (strcmp([(NSNumber *)obj objCType], @encode(long int)) == 0) {
				[json appendFormat:@"%ld", [(NSNumber *)obj longValue]];
			} else {
				// default to long signed integer
				[json appendFormat:@"%d", [(NSNumber *)obj intValue]];
			}
		} else if ([obj isKindOfClass:[NSNull class]]) {
			[json appendString:@"null"];
		} else if ([obj isKindOfClass:[NSArray class]]) {
			[json appendString:[(NSArray *)obj generateJson]];
		} else if ([obj isKindOfClass:[NSDictionary class]]) {
			[json appendString:[(NSDictionary *)obj generateJson]];
		} else {
			// no other objects allowed
			return NULL;
		}
	}
	[json appendString:@"}"];
	return json;
}

@end

