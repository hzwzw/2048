//
//  Calculate.h
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberLabel.h"
typedef NS_OPTIONS(NSUInteger, Dirction) {
    Right = 1 << 0,
    Left  = 1 << 1,
    Up    = 1 << 2,
    Down  = 1 << 3
};

@interface Locus : NSObject
@property(nonatomic,assign)CGPoint nowIndex;
@property(nonatomic,assign)CGPoint arriveIndex;
@property(nonatomic,strong)NSNumber *number;
@property(nonatomic,assign)BOOL dismiss;
@end

@interface Calculate : NSObject

+(NSMutableArray *)swipDirction:(UISwipeGestureRecognizerDirection)dirction;
+(NumberLabel *)addNew;
@end
