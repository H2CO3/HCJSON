//
// CJFunctions.m
// CarbonateJSON
// 
// Created by Árpád Goretity on 02/12/2011.
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import "CJFunctions.h"


id CJParseCString(char *json, int length) {
	jsonz_result_t *buf = jsonz_parse(json, length);
	jsonz_type_t root_type = jsonz_result_get_root_type(buf);
	NSObject *obj = NULL;
	if (root_type == jsonz_type_array) {
		obj = [NSMutableArray array];
	} else if (root_type == jsonz_type_object) {
		obj = [NSMutableDictionary dictionary];
	} else {
		// this shouldn't be any other type
		jsonz_result_free(buf);
		return NULL;
	}
	int count = jsonz_result_get_count(buf);
	NSString *key = NULL;
	for (int i = 0; i < count; i++) {
		jsonz_type_t type = jsonz_result_get_type(buf, i);
		int pos = jsonz_result_get_position(buf, i);
		int len = jsonz_result_get_length(buf, i);
		if ((root_type == jsonz_type_object) && (i % 2 == 0)) {
			key = [[NSString alloc] initWithBytes:json + pos length:len encoding:NSUTF8StringEncoding];
			continue;
		}
		if (type == jsonz_type_null) {
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:[NSNull null]];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:[NSNull null] forKey:key];
			}
		} else if (type == jsonz_type_bool) {
			NSNumber *num = NULL;
			if (strncmp(json + pos, "true", 4) == 0) {
				num = [[NSNumber alloc] initWithBool:YES];
			} else if (strncmp(json + pos, "false", 5) == 0) {
				num = [[NSNumber alloc] initWithBool:NO];
			}
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:num];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:num forKey:key];
			}
			[num release];
		} else if (type == jsonz_type_number) {
			char *nstr = malloc(len + 1);
			strncpy(nstr, json + pos, len);
			nstr[len] = '\0';
			double n = strtod(nstr, NULL);
			free(nstr);
			NSNumber *num = [[NSNumber alloc] initWithDouble:n];			
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:num];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:num forKey:key];
			}
			[num release];
		} else if (type == jsonz_type_string) {
			NSString *str = [[NSString alloc] initWithBytes:json + pos length:len encoding:NSUTF8StringEncoding];
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:str];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:str forKey:key];
			}
			[str release];			
		} else if (type == jsonz_type_array) {
			NSArray *otherObj = CJParseCString(json + pos, len);
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:otherObj];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:otherObj forKey:key];
			}
		} else if (type == jsonz_type_object) {
			NSDictionary *otherObj = CJParseCString(json + pos, len);
			if (root_type == jsonz_type_array) {
				[(NSMutableArray *)obj addObject:otherObj];
			} else if (root_type == jsonz_type_object) {
				[(NSMutableDictionary *)obj setObject:otherObj forKey:key];
			}			
		}
		[key release];
	}
	jsonz_result_free(buf);
	return obj;
}

