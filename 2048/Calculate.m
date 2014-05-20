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

+(NSArray *)save
{
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<4; i++) {
        for (int j=0; j<4; j++) {
            [array addObject:[NSNumber numberWithInt:num[i][j]]];
        }
    }
    return [NSArray arrayWithArray:array];
}
+(void)reset:(NSArray *)array
{
    for (int i = 0; i<[array count]; i++) {
        num[i/4][i%4] = [[array objectAtIndex:i] intValue];
    }
}
+(NSMutableArray *)swipDirction:(UISwipeGestureRecognizerDirection)dirction
{
    NSMutableArray* locusArray = [NSMutableArray new];
    if (dirction == UISwipeGestureRecognizerDirectionLeft) {
        for (int vertical = 0; vertical<4; vertical++) {
            int horizontal_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int horizontal_Value_index = 0;
            for (int horizontal=0; horizontal<4; horizontal++) {
                if (num[vertical][horizontal]>0) {
                    Locus *locus = [Locus new];
                    locus.nowIndex = CGPointMake(horizontal,vertical);
                    if ((horizontal_Value_index>0)&&(horizontal_num[horizontal_Value_index-1][0]==num[vertical][horizontal])&&(!horizontal_num[horizontal_Value_index-1][1])) {
                            horizontal_num[horizontal_Value_index-1][0]=num[vertical][horizontal]*2;
                            horizontal_num[horizontal_Value_index-1][1]=1;
                            locus.arriveIndex = CGPointMake(horizontal_Value_index-1,vertical);
                            locus.number = [NSNumber numberWithInt:num[vertical][horizontal]*2];
                        for (Locus *insiLosuc in locusArray) {
                            if (CGPointEqualToPoint(insiLosuc.arriveIndex, locus.arriveIndex)) {
                                insiLosuc.dismiss = YES;
                            }
                        }
                    }else
                    {
                        locus.arriveIndex = CGPointMake(horizontal_Value_index,vertical);
                        horizontal_num[horizontal_Value_index][0] =num[vertical][horizontal];
                        horizontal_Value_index++;
                    }
                    [locusArray addObject:locus];
                }
            }
            
            for (int i = 0; i<4; i++) {
                num[vertical][i] = horizontal_num[i][0];
            }
            
        }
    }
    if (dirction == UISwipeGestureRecognizerDirectionRight) {
        for (int vertical = 0; vertical<4; vertical++) {
            int horizontal_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int horizontal_Value_index = 3;
            for (int horizontal=3; horizontal>-1; horizontal--) {
                if (num[vertical][horizontal]>0) {
                    Locus *locus = [Locus new];
                    locus.nowIndex = CGPointMake(horizontal,vertical);
                    if ((horizontal_Value_index<3)&&(horizontal_num[horizontal_Value_index+1][0]==num[vertical][horizontal])&&(!horizontal_num[horizontal_Value_index+1][1])) {
                            horizontal_num[horizontal_Value_index+1][0]=num[vertical][horizontal]*2;
                            horizontal_num[horizontal_Value_index+1][1]=1;
                            locus.arriveIndex = CGPointMake(horizontal_Value_index+1,vertical);
                            locus.number = [NSNumber numberWithInt:num[vertical][horizontal]*2];
                        for (Locus *insiLosuc in locusArray) {
                            if (CGPointEqualToPoint(insiLosuc.arriveIndex, locus.arriveIndex)) {
                                insiLosuc.dismiss = YES;
                            }
                        }
                    }else
                    {
                        locus.arriveIndex = CGPointMake(horizontal_Value_index,vertical);
                        horizontal_num[horizontal_Value_index][0] =num[vertical][horizontal];
                        horizontal_Value_index--;
                    }
                    [locusArray addObject:locus];
                }
            }
            for (int i = 0; i<4; i++) {
                num[vertical][i] = horizontal_num[i][0];
            }
        }
    }
    
    if (dirction == UISwipeGestureRecognizerDirectionUp) {
        for (int horizontal = 0; horizontal<4; horizontal++) {
            int vertical_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int vertical_Value_index = 0;
            for (int vertical=0; vertical<4; vertical++) {
                if (num[vertical][horizontal]>0) {
                    Locus *locus = [Locus new];
                    locus.nowIndex = CGPointMake(horizontal,vertical);
                    if ((vertical_Value_index>0)&&(vertical_num[vertical_Value_index-1][0]==num[vertical][horizontal])&&(!vertical_num[vertical_Value_index-1][1])) {
                        vertical_num[vertical_Value_index-1][0]=num[vertical][horizontal]*2;
                        vertical_num[vertical_Value_index-1][1]=1;
                        locus.arriveIndex = CGPointMake(horizontal,vertical_Value_index-1);
                        locus.number = [NSNumber numberWithInt:num[vertical][horizontal]*2];
                        for (Locus *insiLosuc in locusArray) {
                            if (CGPointEqualToPoint(insiLosuc.arriveIndex, locus.arriveIndex)) {
                                insiLosuc.dismiss = YES;
                            }
                        }
                    }
                    else
                    {
                        locus.arriveIndex = CGPointMake(horizontal,vertical_Value_index);
                        vertical_num[vertical_Value_index][0] =num[vertical][horizontal];
                        vertical_Value_index++;
                    }
                    [locusArray addObject:locus];
                }
            }
            for (int i = 0; i<4; i++) {
                num[i][horizontal] = vertical_num[i][0];
            }
        }
    }
    if (dirction == UISwipeGestureRecognizerDirectionDown) {
        for (int horizontal = 0; horizontal<4; horizontal++) {
            int vertical_num[4][2] ={{0,0},{0,0},{0,0},{0,0}};
            int vertical_Value_index = 3;
            for (int vertical=3; vertical>-1; vertical--) {
                if (num[vertical][horizontal]>0) {
                    Locus *locus = [Locus new];
                    locus.nowIndex = CGPointMake(horizontal,vertical);
                    if ((vertical_Value_index<3)&&(vertical_num[vertical_Value_index+1][0]==num[vertical][horizontal])&&(!vertical_num[vertical_Value_index+1][1])) {
                            vertical_num[vertical_Value_index+1][0]=num[vertical][horizontal]*2;
                            vertical_num[vertical_Value_index+1][1]=1;
                        locus.arriveIndex = CGPointMake(horizontal,vertical_Value_index+1);
                        locus.number = [NSNumber numberWithInt:num[vertical][horizontal]*2];
                        for (Locus *insiLosuc in locusArray) {
                            if (CGPointEqualToPoint(insiLosuc.arriveIndex, locus.arriveIndex)) {
                                insiLosuc.dismiss = YES;
                            }
                        }
                    }else
                    {
                        locus.arriveIndex = CGPointMake(horizontal,vertical_Value_index);
                        vertical_num[vertical_Value_index][0] =num[vertical][horizontal];
                        vertical_Value_index--;
                    }
                    [locusArray addObject:locus];
                }
            }
            for (int i = 0; i<4; i++) {
                num[i][horizontal] = vertical_num[i][0];
            }
        }
    }
    return locusArray;
}
+(NumberLabel *)addNew
{
    BOOL find = NO;
    NSMutableArray *indexArray = [NSMutableArray new];
    for (int i=0;i<4; i++) {
        for (int j=0; j<4; j++) {
            if (num[i][j]==0) {
                CGPoint point = CGPointMake(i, j);
                [indexArray addObject:[NSValue valueWithCGPoint:point]];
                find = YES;
            }
        }
    }
    if (find == NO) {
        return nil;
    }
    int index = arc4random() % indexArray.count;
    CGPoint point = [[indexArray objectAtIndex:index] CGPointValue];
    int x=point.x;
    int y=point.y;
    int value = (arc4random() %2)*2+2;
    num[x][y] = value;
    NumberLabel *label = [[NumberLabel alloc]initWithVertical:point.x andHorizontal:point.y andValue:value];
    return label;
}
@end

@implementation Locus

@end
