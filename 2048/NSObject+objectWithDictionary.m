//
//  NSObject+objectWithDictionary.m
//  Scott
//
//  Created by mengjq on 3/28/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "NSObject+objectWithDictionary.h"
#import <objc/runtime.h>
@implementation NSObject (objectWithDictionary)

+(id) ObjectWithPropertiesOfDictionary:(NSDictionary *)dict
{
    if(!dict){
        return nil;
    }
    id obj = [self new];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        obj = [dict copy];
        return obj;
    }
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if (![dict objectForKey:key]) {
            continue;
        }
        if ([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            const char *propType = getPropertyType(properties[i]);
            NSString *className = [NSString stringWithCString:propType encoding:NSUTF8StringEncoding];
            Class subClass = NSClassFromString (className);
            id sub_obj = [subClass ObjectWithPropertiesOfDictionary:[dict objectForKey:key]];
            [obj setValue:sub_obj forKey:key];
        }else
        {
            id value = [dict objectForKey:key];
            [obj setValue:value forKey:key];
        }
    }
    
    free(properties);
    return obj;
}

-(BOOL)isPropertyClass
{
    BOOL ifstring = [self isKindOfClass:[NSString class]];
    if (ifstring) {
        return YES;
    }
    BOOL ifdictionary = [self isKindOfClass:[NSDictionary class]];
    if (ifdictionary) {
        return YES;
    }
    BOOL ifnumber = [self isKindOfClass:[NSValue class]];
    if (ifnumber) {
        return YES;
    }
    BOOL ifarray = [self isKindOfClass:[NSArray class]];
    if (ifarray) {
        return YES;
    }
    BOOL ifdata = [self isKindOfClass:[NSData class]];
    if (ifdata) {
        return YES;
    }
    BOOL ifdate = [self isKindOfClass:[NSDate class]];
    if (ifdate) {
        return YES;
    }
    return NO;
}
static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}


@end
