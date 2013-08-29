//
//  UIView+Additions.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 24/05/12.
//  Copyright (c) 2012 yuan.idea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Additions)

- (UIImage *)captureAsImageWithScale:(CGFloat)aScale opaque:(BOOL)opaque;

- (void)setX:(CGFloat)x;

- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)aWidth;

- (void)setHeight:(CGFloat)aHeight;

- (void)addX:(CGFloat)x;

- (void)addY:(CGFloat)y;

- (void)addWidth:(CGFloat)aWidth;

- (void)addHeight:(CGFloat)aHeight;

@end