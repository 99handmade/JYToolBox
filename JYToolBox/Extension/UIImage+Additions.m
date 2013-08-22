//
//  UIImage+Additions.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UIImage+Additions.h"

#import "sys/utsname.h"

@implementation UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, rect);
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)improvedImageNamed:(NSString *)name
{
  struct utsname systemInfo;
  uname(&systemInfo);
  if ([[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] isEqualToString:@"iPhone5,1"]
      || [[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] isEqualToString:@"iPhone5,2"]) {
    NSMutableString * fullName = [NSMutableString stringWithString:name];
    NSRange range = [name rangeOfString:@"." options:NSBackwardsSearch];
    if (range.length == 0) {
      [fullName insertString:@"-568h@2x" atIndex:name.length];
    }
    else {
      [fullName insertString:@"-568h@2x" atIndex:range.location];
    }
    if ([UIImage imageNamed:fullName]) {
      return [UIImage imageNamed:fullName];
    }
    else {
      return [UIImage imageNamed:name];
    }
  }
  else {
    return [UIImage imageNamed:name];
  }
}

@end