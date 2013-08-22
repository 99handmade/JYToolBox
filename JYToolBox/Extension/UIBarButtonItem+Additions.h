//
//  UIBarButtonItem+Additions.h
//  MFSC
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)

- (id)initWithImage:(UIImage *)image title:(NSString*)title target:(id)target action:(SEL)action;

- (void)setLabelTitle:(NSString *)title;

@end