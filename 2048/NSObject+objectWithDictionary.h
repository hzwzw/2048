//
//  NSObject+objectWithDictionary.h
//  Scott
//
//  Created by mengjq on 3/28/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  convert a object to nsdictionary.
    warning: it will occur error when the property of the object is nsdictionary or nsarray.
 */
@interface NSObject (objectWithDictionary)

+(id) ObjectWithPropertiesOfDictionary:(NSDictionary *)dict;
-(BOOL)isPropertyClass;
@end
