//
//  Calculate.h
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberLabel.h"

@interface Locus : NSObject
@property(nonatomic,assign)CGPoint nowIndex;
@property(nonatomic,assign)CGPoint arriveIndex;
@property(nonatomic,strong)NSNumber *number;
@property(nonatomic,assign)BOOL dismiss;
@end

@interface Calculate : NSObject

+(NSMutableArray *)swipDirction:(UISwipeGestureRecognizerDirection)dirction;
+(NumberLabel *)addNew;
+(NSArray *)save;
+(void)reset:(NSArray *)array;
@end
