//
//  Calculate.h
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, Dirction) {
    Right = 1 << 0,
    Left  = 1 << 1,
    Up    = 1 << 2,
    Down  = 1 << 3
};

@interface Calculate : NSObject

-(void)swipDirction:(Dirction)dirction;
@end
