HCJSON is an elegant way to parse and generate JSON from Cocoa object types.
Being an OO wrapper around libjsonz (the author's not-very-strict JSON parser library), it adds
categories to NSArray, NSDictionary and NSString to generate and parse JSON data.

How to generate JSON data:
 - Ensure your NSArray or NSDictionary only contains NSString, NSNumber, NSDate, NSNull, NSArray and NSDictionary instances
 - Send the `- serializeJSON` message to your NSArray or NSDictionary instance

How to parse JSON data:
 - Ensure your NSString holds valid JSON
 - Send the `- parseJSON` message to your NSString instance
 - The result will be either an NSArray or an NSDictionary. Check their class and use them as above.


If you're developing for Cydia, I recommend using the prebuilt, dynamically linkable framework from Cydia
(as it's conceptually better/more elegant/uses less memory), but you can use this in your AppStore apps
as well by statically linking the source along with your project.
(Please note that in the latter case you'll need to statically link the libjsonz library as well.)
