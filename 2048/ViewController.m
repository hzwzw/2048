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
#import "historyViewController.h"
#import "historyRecord.h"
#import "NSDictionary+dictionaryWithObject.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

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

    [self addGesture];
    [self addNew];
    [self addNew];
}

- (void)addGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenresinresponde)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
- (void)hidenresinresponde
{
    [[UIApplication sharedApplication]sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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
        
        [UIView animateWithDuration:0.2 animations:^{
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

-(void)reset:(NSArray *)array
{
    [Calculate reset:array];
    for (UIView *view in _backView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<[array count]; i++) {
        if ([[array objectAtIndex:i] intValue]>0) {
            NumberLabel *label = [[NumberLabel alloc]initWithVertical:i/4 andHorizontal:i%4 andValue:[[array objectAtIndex:i] intValue]];
            [_backView addSubview:label];
        }
    }
}
- (IBAction)save:(id)sender {
    historyRecord *record = [historyRecord new];
    record.imageData= [self screenshot];
    record.time= [NSDate date];
    record.dataArray =[Calculate save];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithPropertiesOfObject:record] forKey:@"nice"];
}
- (IBAction)resetLarger:(id)sender {
    if (!_textField.text.length) {
        return;
    }
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_textField.text];
    
    int yushu = [myNumber intValue];
    float ok = log2(yushu);
    if (ok==(int)ok) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:myNumber, nil];
        for (int i = 0; i<15; i++) {
            [array addObject:@0];
        }
        [self reset:[NSArray arrayWithArray:array]];
    }
}

- (NSData*)screenshot {
    UIGraphicsBeginImageContext(_backView.bounds.size);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] ){
        [_backView drawViewHierarchyInRect:_backView.bounds afterScreenUpdates:YES];
    }else{
        [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    return imageData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
