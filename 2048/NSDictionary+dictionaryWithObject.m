//
//  NSDictionary+dictionaryWithObject.m
//  Scott
//
//  Created by mengjq on 3/28/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "NSDictionary+dictionaryWithObject.h"
#import <objc/runtime.h>
#import "NSObject+objectWithDictionary.h"

@implementation NSDictionary (dictionaryWithObject)

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    if(!obj){
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if (![obj valueForKey:key]) {
            continue;
        }
        BOOL ifPropertyObject = [[obj valueForKey:key] isPropertyClass];
        if (!ifPropertyObject) {
            id subObj = [self dictionaryWithPropertiesOfObject:[obj valueForKey:key]];
            [dict setObject:subObj forKey:key];
        }
        else
        {
            id value = [obj valueForKey:key];
            [dict setObject:value forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}


@end
