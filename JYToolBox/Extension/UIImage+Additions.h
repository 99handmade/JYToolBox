//
//  UIImage+Additions.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)improvedImageNamed:(NSString *)name;

@end