//
//  CheckableButton.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 25/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckableButton : UIButton

@property (nonatomic, assign, readonly) BOOL      checked;

- (UIImage *)checkedImage;

- (UIImage *)uncheckedImage;

- (UIImage *)checkedBackgroundImage;

- (UIImage *)uncheckedBackgroundImage;

- (void)setCheckedImage:(UIImage *)image;

- (void)setUncheckedImage:(UIImage *)image;

- (void)setCheckedBackgroundImage:(UIImage *)image;

- (void)setUncheckedBackgroundImage:(UIImage *)image;

- (void)check;

- (void)unCheck;

@end