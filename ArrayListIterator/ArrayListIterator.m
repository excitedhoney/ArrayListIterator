//
//  ArrayListIterator.m
//  ArrayListIterator
//
//  Created by James Zhao on 28/10/2016.
//  Copyright © 2016 RoboticsGen. All rights reserved.
//

#import "ArrayListIterator.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ArrayListIterator ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray <NSNumber *>*> *array;
@property (nonatomic, assign) CGPoint currentPosition;
@property (nonatomic, assign) BOOL nextCalled;

@end

@implementation ArrayListIterator

- (instancetype)initWithTwoDimensionalArray:(NSArray<NSMutableArray <NSNumber *>*> *)array
{
    self = [super init];
    if (self) {
        self.array = [array mutableCopy];
        [self reset];
    }
    return self;
}

- (BOOL)hasNext
{
    CGPoint nextPosition = [self getNextPosition:self.currentPosition];
    return ![self hasReachedTheEnd:nextPosition];
}

- (NSInteger)next
{
    if ([self hasNext]) {
        CGPoint nextPosition = [self getNextPosition:self.currentPosition];
        NSNumber *number = [self getNumberAtPosition:nextPosition];
        self.currentPosition = nextPosition;
        self.nextCalled = YES;
        return number.integerValue;
    } else {
        //raise error
        NSLog(@"next error");
        self.nextCalled = YES;
        return INT_MAX;
    }
}

- (void)remove
{
    NSNumber *number = [self getNumberAtPosition:self.currentPosition];
    if (number == nil || !self.nextCalled) {
        //raise error
        NSLog(@"remove error");
    } else {
        NSInteger rowIndex = self.currentPosition.y;
        NSMutableArray <NSNumber *>*row = [self getRow:rowIndex];
        if (![row isKindOfClass:[NSMutableArray class]]) {
            row = [row mutableCopy];
        }
        self.array[rowIndex] = row;
        [row removeObject:number];
        self.currentPosition = CGPointMake(self.currentPosition.x - 1, self.currentPosition.y);
        self.nextCalled = NO;
    }
}

- (void)reset
{
    self.currentPosition = CGPointMake(-1, 0);
    self.nextCalled = NO;
}

- (NSMutableArray <NSNumber *>*)getRow:(NSInteger)y
{
    if (self.array.count > y && y >= 0) {
        return self.array[y];
    }
    return nil;
}

- (NSNumber *)getNumberAtPosition:(CGPoint)position
{
    if (position.y >= 0 && position.y <self.array.count) {
        NSMutableArray <NSNumber *>*row = [self getRow:position.y];
        if (position.x >= 0 && position.x < row.count) {
            return [row objectAtIndex:position.x];
        }
    }
    return nil;
}

- (BOOL)elementExistsAtPosition:(CGPoint)position
{
    if (position.y >= 0 && position.y <self.array.count) {
        NSMutableArray <NSNumber *>*row = [self getRow:position.y];
        if (position.x >= 0 && position.x < row.count) {
            return YES;
        }
    }
    return NO;
}

- (CGPoint)getNextPosition:(CGPoint)current
{
    NSInteger x = current.x + 1;
    NSInteger y = current.y;
    while (y < self.array.count) {
        BOOL exists = [self elementExistsAtPosition:CGPointMake(x, y)];
        if (!exists) {
            x = 0;
            y++;
        } else {
            return CGPointMake(x, y);
        }
    }
    return CGPointMake(0, -1);
}

- (BOOL)hasReachedTheEnd:(CGPoint)current
{
    return current.y == -1;
}
@end
