//
//  NSMutableArray+Additions.m
//  MFSC
//
//  Created by Jiehao YUAN on 26/06/13.
//  Copyright (c) 2013 mousquetaires. All rights reserved.
//

#import "NSMutableArray+Additions.h"
#import "NSArray+Additions.h"

@implementation NSMutableArray (Additions)

- (void)addInteger:(NSInteger)number
{
  if (![self containsInteger:number]) {
    NSNumber * nb = [NSNumber numberWithInteger:number];
    [self addObject:nb];
  }
}

- (void)addString:(NSString *)str
{
  if (![self containsString:str]) {
    [self addObject:str];
  }
}

- (void)removeInteger:(NSInteger)number
{
  for (id obj in [self copy]) {
    if ([obj isKindOfClass:[NSNumber class]]) {
      if ([(NSNumber *)obj integerValue] == number) {
        [self removeObject:obj];
      }
    }
  }
}

- (void)removeString:(NSString *)str
{
  for (id obj in [self copy]) {
    if ([obj isKindOfClass:[NSString class]]) {
      if ([(NSString *)obj isEqualToString:str]) {
        [self removeObject:obj];
      }
    }
  }
}

@end