//
//  UIPageControlEx.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 01/08/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UIPageControlEx.h"

@implementation UIPageControlEx

- (void)setCurrentPage:(NSInteger)currentPage
{
  [super setCurrentPage:currentPage];
  
  if (![self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] &&
      self.currentPageImageEx != nil) {
    for (int i = 0; i < self.subviews.count; i++) {
      UIView * view = [self.subviews objectAtIndex:i];
      if ([view isMemberOfClass:[UIImageView class]] && i == self.currentPage) {
        [(UIImageView *)view setImage:self.currentPageImageEx];
      }
      else if ([view isMemberOfClass:[UIImageView class]]) {
        [(UIImageView *)view setImage:self.pageImageEx];
      }
    }
  }
}

@end