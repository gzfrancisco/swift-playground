//
//  main.m
//  IncodeCodeTest
//
//  Created by Francisco Granados on 7/13/16.
//  Copyright © 2016 Bistro Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZSolution : NSObject

+ (NSArray *)implementationForArray:(NSArray *)objects withMaxValue:(NSNumber *)maxValue;
+ (NSDictionary *)dictionaryInfoForArray:(NSArray *)objects;

@end

@implementation GZSolution

+ (NSArray *)implementationForArray:(NSArray *)objects withMaxValue:(NSNumber *)maxValue {
//  Constraints
  NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject,
                                                                 NSDictionary<NSString *,id> * _Nullable bindings) {
    return [evaluatedObject isKindOfClass:[NSNumber class]] && [evaluatedObject integerValue] < [maxValue integerValue];
  }];
  NSArray *numbers = [objects filteredArrayUsingPredicate:predicate];
//  Uniqness
  NSSet *uniqueNumbers = [NSSet setWithArray:numbers];
//  Sort
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"integerValue" ascending:YES];
  return [uniqueNumbers sortedArrayUsingDescriptors:@[sortDescriptor]];
}

+ (NSDictionary *)dictionaryInfoForArray:(NSArray *)objects {
//  Flatten the objects
  NSArray *flatArray = [self arrayFlattenFromArray:objects];
  NSMutableDictionary *descriptor = [NSMutableDictionary dictionary];
  NSCountedSet *set = [NSCountedSet set];
  
//  Count the objects
  [flatArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [set addObject:NSStringFromClass([obj classForCoder])];
  }];
  
//  Create the descriptor dictionary
  [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
    [descriptor setObject:@([set countForObject:obj]) forKeyedSubscript:obj];
  }];
  
  return descriptor;
}

+ (NSArray *)arrayFlattenFromArray:(NSArray *)array {
//  I can't use KVC because the it was an unbalanced tree array.
  NSMutableArray *result = [NSMutableArray array];
  [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isKindOfClass:[NSArray class]]) {
      [result addObjectsFromArray:[self arrayFlattenFromArray:obj]];
      
    } else {
      [result addObject:obj];
    }
  }];
  return result;
}

@end

int main(int argc, const char * argv[]) {
  @autoreleasepool {
//    First challenge
    NSLog(@"First challenge -----");
    NSLog(@"%@", [GZSolution implementationForArray:@[@10, @50, @50, @5, @"James"] withMaxValue:@100]);
    NSLog(@"%@", [GZSolution implementationForArray:@[@11, @10, @50, @20, @50, @5, @"James", @23] withMaxValue:@100]);
    
//    Second challenge
    NSLog(@"Second challenge ----");
    NSLog(@"%@", [GZSolution dictionaryInfoForArray:@[@"Idaho", @5, @7]]);
    NSLog(@"%@", [GZSolution dictionaryInfoForArray:@[@1, @[@2, @3]]]);
    NSLog(@"%@", [GZSolution dictionaryInfoForArray:@[@1, @[@2, @3, @[@"a", @3, @8]]]]);
  }
  return 0;
}