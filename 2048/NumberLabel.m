//
//  NumberView.m
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "NumberLabel.h"

@implementation NumberLabel

-(id)initWithVertical:(int)verticalIndex andHorizontal:(int)horizontalIndex andValue:(int)value
{
    self = [super init];
    if (self) {
        self.text = [NSString stringWithFormat:@"%d",value];
        self.frame =CGRectMake(horizontalIndex*singleWight, verticalIndex*singleWight, singleWight, singleWight);
        self.textAlignment = NSTextAlignmentCenter;
        self.tag = horizontalIndex*4+verticalIndex;
    }
    return self;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text.length>3) {
        self.font=[UIFont boldSystemFontOfSize:19.0];
    }else
        self.font=[UIFont boldSystemFontOfSize:29.0];
    if ([text isEqualToString:@"2"]) {
        self.backgroundColor = [UIColor colorWithRed:137.0/255.0 green:215.0/255.0 blue:235.0/255.0 alpha:1.0];
    }else if([text isEqualToString:@"4"])
    {
        self.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:215.0/255.0 blue:235.0/255.0 alpha:1.0];
    }
    
}
@end
