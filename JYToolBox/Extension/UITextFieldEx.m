//
//  UITextFieldEx.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 08/11/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UITextFieldEx.h"

#import "Common.h"

@interface UITextFieldEx ()

- (void)showHelpInfo;

@end

@implementation UITextFieldEx





#pragma mark - Init & Dealloc

- (id)init
{
  self = [super init];
  if (self) {
    self.helpInfo = nil;
    self.attributedHelpInfo = nil;
  }
  return self;
}





#pragma mark - Setter & Getter

- (void)setRightView:(UIView *)rightView
{
  UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] init];
  [recognizer addTarget:self action:@selector(showHelpInfo)];
  [rightView addGestureRecognizer:recognizer];
  rightView.userInteractionEnabled = TRUE;
  [super setRightView:rightView];
}




#pragma mark - UI action

- (void)showHelpInfo
{
  UILabel * label = [[UILabel alloc] init];
  label.backgroundColor = [UIColor blackColor];
  label.textColor = [UIColor whiteColor];
  label.numberOfLines = 9;
  [self.superview addSubview:label];
  
  CGRect rect = CGRectZero;
  if (self.helpInfo != nil && self.helpInfo.length > 0) {
    rect.size = [self.helpInfo sizeWithFont:label.font
                          constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
                              lineBreakMode:NSLineBreakByWordWrapping];
    label.text = self.helpInfo;
  }
  if (self.attributedHelpInfo != nil && self.attributedHelpInfo.length > 0) {
    rect = [self.attributedHelpInfo boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil];
    label.attributedText = self.attributedHelpInfo;
  }
  
  label.frame           = CGRectMake(self.frame.origin.x,
                                     self.frame.origin.y - rect.size.height,
                                     self.frame.size.width,
                                     rect.size.height);
  
  
  
  [UIView animateWithDuration:5 animations:^{
    label.alpha = 0;
  } completion:^(BOOL finished) {
    [label removeFromSuperview];
  }];
}





#pragma mark - Layout

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  if (SYSTEM_VERSION >= 7.0f && self.rightView != nil) {
    self.rightView.frame = CGRectMake(self.rightView.frame.origin.x - 5,
                                      self.rightView.frame.origin.y,
                                      self.rightView.frame.size.width,
                                      self.rightView.frame.size.height);
  }
}

@end