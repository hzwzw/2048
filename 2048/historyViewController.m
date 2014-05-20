//
//  historyViewController.m
//  2048
//
//  Created by mengjq on 5/20/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "historyViewController.h"
#import "NSObject+objectWithDictionary.h"
#import "historyRecord.h"
#import "ViewController.h"
@interface historyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end

@implementation historyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _array = [NSArray arrayWithObject:[historyRecord ObjectWithPropertiesOfDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"nice"]]];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        historyRecord *record = [_array objectAtIndex:0];
        NSData *data = record.imageData;
        cell.imageView.image = [UIImage imageWithData:data];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd hh:mm"];
        NSString *stringFromDate = [formatter stringFromDate:record.time];
        cell.textLabel.text = stringFromDate;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *viewController =(ViewController *) self.presentingViewController;
    [viewController reset:[(historyRecord *)[_array objectAtIndex:0] dataArray]];
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
@end
