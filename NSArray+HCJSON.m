/*
 * NSArray+CarbonateJSON.h
 * CarbonateJSON
 * 
 * Created by Árpád Goretity on 02/12/2011.
 * Licensed under a CreativeCommons Attribution 3.0 Unported License
 */

#import <string.h>
#import "NSArray+HCJSON.h"
#import "NSDictionary+HCJSON.h"

@implementation NSArray (HCJSON)

- (NSString *)serializeJSON
{
	NSMutableString *json = [[NSMutableString alloc] initWithString:@"["];
	int count = [self count];
	int i;

	for (i = 0; i < count; i++) {
		if (i > 0) {
			[json appendString:@", "];
		}
		
		id obj = [self objectAtIndex:i];
		
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
				// default to int
				[json appendFormat:@"%d", [(NSNumber *)obj intValue]];
			}
		} else if ([obj isKindOfClass:[NSNull class]]) {
			[json appendString:@"null"];
		} else if ([obj isKindOfClass:[NSArray class]]) {
			[json appendString:[(NSArray *)obj serializeJSON]];
		} else if ([obj isKindOfClass:[NSDictionary class]]) {
			[json appendString:[(NSDictionary *)obj serializeJSON]];
		} else {
			// no other objects allowed
			[json release];
			return nil;
		}
	}
	
	[json appendString:@"]"];
	return [json autorelease];
}

@end
