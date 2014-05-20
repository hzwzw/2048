//
//  historyRecord.h
//  2048
//
//  Created by mengjq on 5/20/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface historyRecord : NSObject
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)NSDate *time;
@property (nonatomic,strong)NSArray *dataArray;
@end
