//
//  ArrayListIterator.h
//  ArrayListIterator
//
//  Created by James Zhao on 28/10/2016.
//  Copyright © 2016 RoboticsGen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayListIterator : NSObject

- (instancetype)initWithTwoDimensionalArray:(NSArray<NSMutableArray <NSNumber *>*> *)array;

- (BOOL)hasNext;
- (NSInteger)next;
- (void)remove;
- (void)reset;

@end
