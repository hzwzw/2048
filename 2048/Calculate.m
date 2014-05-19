//
//  Calculate.m
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "Calculate.h"

@implementation Calculate

static int num[4][4] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
+ (void)initialize
{
    NSLog(@"test:%d",num[1][1]);
}

-(void)swipDirction:(Dirction)dirction
{
    if (dirction == Left) {
        for (int vertical = 0; vertical<4; vertical++) {
            int horizontal_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int horizontal_Value_index = 0;
            for (int horizontal=0; horizontal<4; horizontal++) {
                if (num[vertical][horizontal]>0) {
                    if (horizontal_Value_index>0) {
                        if ((horizontal_num[horizontal_Value_index-1][0]==num[vertical][horizontal])&&(!horizontal_num[horizontal_Value_index-1][1])) {
                            horizontal_num[horizontal_Value_index-1][0]=num[vertical][horizontal]*2;
                            horizontal_num[horizontal_Value_index-1][1]=1;
                            num[vertical][horizontal_Value_index-1]=horizontal_num[horizontal_Value_index-1][0];
                            return;
                        }
                    }
                    horizontal_num[horizontal_Value_index][0] =num[vertical][horizontal];
                    num[vertical][horizontal_Value_index]=num[vertical][horizontal];
                    horizontal_Value_index++;
                }
            }
        }
    }
    if (dirction == Right) {
        for (int vertical = 0; vertical<4; vertical++) {
            int horizontal_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int horizontal_Value_index = 3;
            for (int horizontal=3; horizontal>-1; horizontal--) {
                if (num[vertical][horizontal]>0) {
                    if (horizontal_Value_index<3) {
                        if ((horizontal_num[horizontal_Value_index+1][0]==num[vertical][horizontal])&&(!horizontal_num[horizontal_Value_index+1][1])) {
                            horizontal_num[horizontal_Value_index+1][0]=num[vertical][horizontal]*2;
                            horizontal_num[horizontal_Value_index+1][1]=1;
                            num[vertical][horizontal_Value_index+1]=horizontal_num[horizontal_Value_index+1][0];
                            return;
                        }
                    }
                    horizontal_num[horizontal_Value_index][0] =num[vertical][horizontal];
                    num[vertical][horizontal_Value_index]=num[vertical][horizontal];
                    horizontal_Value_index--;
                }
            }
        }
    }
    
    if (dirction == Up) {
        for (int vertical = 0; vertical<4; vertical++) {
            int horizontal_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int horizontal_Value_index = 0;
            for (int horizontal=0; horizontal<4; horizontal++) {
                if (num[vertical][horizontal]>0) {
                    if (horizontal_Value_index>0) {
                        if ((horizontal_num[horizontal_Value_index-1][0]==num[vertical][horizontal])&&(!horizontal_num[horizontal_Value_index-1][1])) {
                            horizontal_num[horizontal_Value_index-1][0]=num[vertical][horizontal]*2;
                            horizontal_num[horizontal_Value_index-1][1]=1;
                            num[vertical][horizontal_Value_index-1]=horizontal_num[horizontal_Value_index-1][0];
                            return;
                        }
                    }
                    horizontal_num[horizontal_Value_index][0] =num[vertical][horizontal];
                    num[vertical][horizontal_Value_index]=num[vertical][horizontal];
                    horizontal_Value_index++;
                }
            }
        }
    }
}
@end
