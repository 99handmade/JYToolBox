//
//  CheckableButton.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 25/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "CheckableButton.h"

@interface CheckableButton ()

@property (strong, nonatomic) UIImage *       checkedImage;
@property (strong, nonatomic) UIImage *       uncheckedImage;
@property (strong, nonatomic) UIImage *       checkedBackgroundImage;
@property (strong, nonatomic) UIImage *       uncheckedBackgroundImage;

- (void)didCheckButton;

@end

@implementation CheckableButton

@synthesize checked                   = _checked;
@synthesize checkedImage              = _checkedImage;
@synthesize uncheckedImage            = _uncheckedImage;
@synthesize checkedBackgroundImage    = _checkedBackgroundImage;
@synthesize uncheckedBackgroundImage  = _uncheckedBackgroundImage;


#pragma mark - Init & Dealloc

- (id)init
{
  return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      _checkedImage = nil;
      _uncheckedImage = nil;
      _checkedBackgroundImage = nil;
      _uncheckedBackgroundImage = nil;
      _checked = FALSE;
      [self addTarget:self action:@selector(didCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



#pragma mark - Getter & Setter

- (UIImage *)checkedImage
{
  return _checkedImage;
}

- (UIImage *)uncheckedImage
{
  return _uncheckedImage;
}

- (UIImage *)checkedBackgroundImage
{
  return _checkedBackgroundImage;
}

- (UIImage *)uncheckedBackgroundImage
{
  return _uncheckedBackgroundImage;
}

- (void)setCheckedImage:(UIImage *)image
{
  _checkedImage = image;
  [self setImage:_uncheckedImage forState:UIControlStateNormal];
}

- (void)setUncheckedImage:(UIImage *)image
{
  _uncheckedImage = image;
  [self setImage:_uncheckedImage forState:UIControlStateNormal];
}

- (void)setCheckedBackgroundImage:(UIImage *)image
{
  _checkedBackgroundImage = image;
  [self setBackgroundImage:_checkedBackgroundImage forState:UIControlStateNormal];
}

- (void)setUncheckedBackgroundImage:(UIImage *)image
{
  _uncheckedBackgroundImage = image;
  [self setBackgroundImage:_uncheckedBackgroundImage forState:UIControlStateNormal];
}




#pragma mark - UI action

- (void)didCheckButton
{
  _checked = !_checked;
  if (self.checked) {
    [self check];
  }
  else {
    [self unCheck];
  }

}

- (void)check
{
  _checked = TRUE;
  [self setImage:_checkedImage forState:UIControlStateNormal];
  [self setBackgroundImage:_checkedBackgroundImage forState:UIControlStateNormal];
}

- (void)unCheck
{
  _checked = FALSE;
  [self setImage:_uncheckedImage forState:UIControlStateNormal];
  [self setBackgroundImage:_uncheckedBackgroundImage forState:UIControlStateNormal];
}

@end