//
//  NSString+Additions.m
//  MFSC
//
//  Created by Jiehao YUAN on 03/07/13.
//  Copyright (c) 2013 mousquetaires. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

+ (NSString *)randomAlphaNumericStringWithLength:(NSInteger)length
{
  NSString * dictionary = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  NSMutableString * randomString = [NSMutableString stringWithCapacity:length];
  
  for (int i = 0; i < length; i++) {
    [randomString appendFormat:@"%C", [dictionary characterAtIndex:arc4random() % [dictionary length]]];
  }
  
  return randomString;
}

@end