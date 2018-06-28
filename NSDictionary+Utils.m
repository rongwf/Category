//
//  NSDictionary+Utils.m
//  OfferManager
//
//  Created by rongwf on 2018/1/29.
//  Copyright © 2018年 rongwf. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}

@end
