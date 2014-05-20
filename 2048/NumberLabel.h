//
//  NumberView.h
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberLabel : UILabel
-(id)initWithVertical:(int)verticalIndex andHorizontal:(int)horizontalIndex andValue:(int)value;
@end
