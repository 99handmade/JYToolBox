//
//  NSArray+Additions.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 03/07/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (BOOL)containsString:(NSString *)str
{
  for (id obj in self) {
    if ([obj isMemberOfClass:[NSString class]]) {
      if ([(NSString *)obj isEqualToString:str]) {
        return TRUE;
      }
    }
  }
  return FALSE;
}

- (BOOL)containsInteger:(NSInteger)number
{
  for (id obj in self) {
    if ([obj isKindOfClass:[NSNumber class]]) {
      if ([(NSNumber *)obj integerValue] == number) {
        return TRUE;
      }
    }
  }
  return FALSE;
}

@end