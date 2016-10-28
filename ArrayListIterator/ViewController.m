//
//  ViewController.m
//  ArrayListIterator
//
//  Created by James Zhao on 28/10/2016.
//  Copyright © 2016 RoboticsGen. All rights reserved.
//

#import "ViewController.h"

#import "ArrayListIterator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Run Cases" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [button addTarget:self action:@selector(print:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)print:(id)sender
{
    [self printIteratorCase];
    [self removeBeforeCallingNextCase];
    [self reachesIteratorEndCase];
    [self removeEvenNumbersCase];
}

- (void)printIterator:(ArrayListIterator *)iterator
{
    NSMutableString * string = [[NSMutableString alloc]init];
    while ([iterator hasNext]) {
        NSInteger element = [iterator next];
        [string appendFormat:@"%ld ", element];
    }
    NSLog(@"%@", string);
}

- (void)printIteratorCase
{
    NSLog(@"======================");
    NSLog(@"printIteratorCase");
    NSArray *array = @[@[], @[@1, @3], @[], @[@5, @6, @7],@[@6, @8]];
    ArrayListIterator *iterator = [[ArrayListIterator alloc]initWithTwoDimensionalArray:array];
    [self printIterator:iterator];
}

- (void)removeBeforeCallingNextCase
{
    NSLog(@"======================");
    NSLog(@"removeBeforeCallingNextCase");
    NSArray *array = @[@[], @[@1, @3], @[], @[@5, @6, @7],@[@6, @8]];
    ArrayListIterator *iterator = [[ArrayListIterator alloc]initWithTwoDimensionalArray:array];
    [iterator remove];
}

- (void)reachesIteratorEndCase
{
    NSLog(@"======================");
    NSLog(@"reaches the end case");
    NSArray *array = @[@[], @[@1, @3], @[], @[@5, @6, @7],@[@6, @8]];
    ArrayListIterator *iterator = [[ArrayListIterator alloc]initWithTwoDimensionalArray:array];
    while ([iterator hasNext]) {
        [iterator next];
    }
    [iterator next];
}

- (void)removeEvenNumbersCase
{
    NSLog(@"======================");
    NSLog(@"remove even numbers case");
    NSArray *array = @[@[], @[@1, @3], @[], @[@5, @6, @7],@[@6, @8]];
    ArrayListIterator *iterator = [[ArrayListIterator alloc]initWithTwoDimensionalArray:array];
    [self printIterator:iterator];

    [iterator reset];
    while ([iterator hasNext]) {
        NSInteger element = [iterator next];
        if (element % 2 == 0) {
            [iterator remove];
        }
    }
    [iterator reset];
    [self printIterator:iterator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
