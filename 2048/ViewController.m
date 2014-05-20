//
//  ViewController.m
//  2048
//
//  Created by mengjq on 5/19/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "ViewController.h"
#import "NumberLabel.h"
#import "Calculate.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [_backView addGestureRecognizer:rightSwipeGesture];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_backView addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [downSwipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [_backView addGestureRecognizer:downSwipeGesture];
    
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [upSwipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [_backView addGestureRecognizer:upSwipeGesture];
    _backView.tag = 100;

    [self addNew];
    [self addNew];
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    NSMutableArray *locuses = [Calculate swipDirction:[gesture direction]];
    BOOL move = NO;
    for (Locus *locus in locuses) {
        move = YES;
        CGPoint nowIndex = locus.nowIndex;
        int tag =nowIndex.x*4+nowIndex.y;
        int arriveTag =locus.arriveIndex.x*4+locus.arriveIndex.y;
        CGPoint arrive = CGPointMake(locus.arriveIndex.x*singleWight, locus.arriveIndex.y*singleWight);
        NumberLabel *label = (NumberLabel *)[_backView viewWithTag:tag];
        if (locus.dismiss) {
            [_backView sendSubviewToBack:label];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            label.frame = CGRectMake(arrive.x, arrive.y, singleWight, singleWight);
        }completion:^(BOOL finished){
            if (finished) {
                if (locus.dismiss) {
                    [label removeFromSuperview];
                }else
                {
                    label.tag =arriveTag;
                    if (locus.number) {
                        label.text = [locus.number stringValue];
                    }
                }
            }
        }];
    }
    [self performSelector:@selector(addNew) withObject:nil afterDelay:move?0.5:0.0];
}

- (void)addNew
{
    NumberLabel *label =[Calculate addNew];
    if (!label) {
        return;
    }
    label.transform = CGAffineTransformMakeScale(0.3, 0.3);
    label.alpha = 0;
    [_backView addSubview:label];
    [UIView animateWithDuration:0.2 animations:^{
        label.alpha = 1;
        label.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished){
        
    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
