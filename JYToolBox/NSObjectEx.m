//
//  NSObjectEx.m
//  MFSC
//
//  Created by Jiehao YUAN on 01/08/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "NSObjectEx.h"

@implementation NSObjectEx

- (NSString *)description
{
  NSMutableString * description = [NSMutableString stringWithString:[super description]];
  
  unsigned int propertyCount;
  objc_property_t * properties = class_copyPropertyList([self class], &propertyCount);
  
  [description appendString:@"\n"];
  [description appendFormat:@"[%@] ", NSStringFromClass([self class])];
  
  for (int i = 0; i < propertyCount; i++) {
    objc_property_t property = properties[i];
    const char * propName = property_getName(property);
    NSString * propertyName = [NSString stringWithUTF8String:propName];
    [description appendFormat:@"<%@>:%@ ", propertyName, [self valueForKey:propertyName]];
  }
  
  free(properties);
  return description;
}

@end