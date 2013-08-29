//
//  UIView+Additions.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 24/05/12.
//  Copyright (c) 2012 yuan.idea. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (UIImage *)captureAsImageWithScale:(CGFloat)aScale opaque:(BOOL)opaque
{
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, aScale);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext(); 
  UIGraphicsEndImageContext();
  return img;
}

- (void)setX:(CGFloat)x
{
  self.frame = CGRectMake(x, 
                          self.frame.origin.y, 
                          self.frame.size.width, 
                          self.frame.size.height);
}

- (void)setY:(CGFloat)y
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          y, 
                          self.frame.size.width, 
                          self.frame.size.height);
}

- (void)setWidth:(CGFloat)aWidth
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          self.frame.origin.y, 
                          aWidth, 
                          self.frame.size.height);
}

- (void)setHeight:(CGFloat)aHeight
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          self.frame.origin.y, 
                          self.frame.size.width, 
                          aHeight);
}

- (void)addX:(CGFloat)x
{
  self.frame = CGRectMake(self.frame.origin.x + x, 
                          self.frame.origin.y, 
                          self.frame.size.width, 
                          self.frame.size.height);
}

- (void)addY:(CGFloat)y
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          self.frame.origin.y + y, 
                          self.frame.size.width, 
                          self.frame.size.height);
}

- (void)addWidth:(CGFloat)aWidth
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          self.frame.origin.y, 
                          self.frame.size.width + aWidth, 
                          self.frame.size.height);
}
  
- (void)addHeight:(CGFloat)aHeight
{
  self.frame = CGRectMake(self.frame.origin.x, 
                          self.frame.origin.y, 
                          self.frame.size.width, 
                          self.frame.size.height + aHeight);
}

@end