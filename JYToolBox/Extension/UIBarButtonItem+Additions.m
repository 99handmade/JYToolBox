//
//  UIBarButtonItem+Additions.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"


@implementation UIBarButtonItem (Additions)

- (id)initWithImage:(UIImage *)image title:(NSString*)title target:(id)target action:(SEL)action
{
  UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame= CGRectMake(0, 0, image.size.width, image.size.height);
  [button setImage:image forState:UIControlStateNormal];
  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  
  UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(2, 3, image.size.width, image.size.height)];
  label.tag                 = -1;
  label.textAlignment       = UITextAlignmentCenter;
  label.textColor           = [UIColor whiteColor];
  label.backgroundColor     = [UIColor clearColor];
  label.text                = title;
  [button addSubview:label];
  
  return [self initWithCustomView:button];
}

- (void)setLabelTitle:(NSString *)title
{
  for (UIView * view in self.customView.subviews) {
    if (view.tag == -1) {
      UILabel * label = (UILabel *)view;
      [label setText:title];
    }
  }
}

@end