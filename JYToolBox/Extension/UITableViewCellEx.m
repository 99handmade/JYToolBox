//
//  UITableViewCellEx.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 16/05/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UITableViewCellEx.h"

#import "Common.h"
#import "UIImage+Additions.h"

#import "UITableViewEx.h"
#import "CheckableButton.h"

@interface  UITableViewCellEx ()

@property (nonatomic, strong) UIView *              whiteBGView;


@property (nonatomic, strong) CheckableButton *     checkableButton;


@property (nonatomic, assign) BOOL                  isChecked;

@property (strong, nonatomic) UIButton *            button;


- (void)didCheckCell;

- (void)didClickButton;

@end


@implementation UITableViewCellEx


#pragma mark - Init & Dealloc

- (id)init
{
  return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    self.isChecked      = FALSE;
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    ///check mark
    self.checkableButton = [CheckableButton buttonWithType:UIButtonTypeCustom];
    self.checkableButton.hidden = TRUE;
    [self.checkableButton setCheckedImage:[UIImage imageWithColor:[UIColor greenColor]
                                                             size:CGSizeMake(self.contentView.frame.size.height,
                                                                             self.contentView.frame.size.height)]];
    [self.checkableButton setUncheckedImage:[UIImage imageWithColor:[UIColor grayColor]
                                                               size:CGSizeMake(self.contentView.frame.size.height,
                                                                               self.contentView.frame.size.height)]];
    [self.checkableButton addTarget:self
                             action:@selector(didCheckCell)
                   forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkableButton];
    
    
    
    //button
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageWithColor:[UIColor blackColor]
                                             size:CGSizeMake(self.contentView.frame.size.height,
                                                             self.contentView.frame.size.height)]
                 forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self
                    action:@selector(didClickButton)
          forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
  }
  return self;
}


#pragma mark - Layout

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  self.backgroundColor              = [UIColor whiteColor];
  self.contentView.backgroundColor  = [UIColor clearColor];
  
  self.checkableButton.frame = CGRectMake(0, 0,
                                          self.contentView.frame.size.height,
                                          self.contentView.frame.size.height);
  self.button.frame = CGRectMake(self.contentView.frame.size.width - 50,
                                 0,
                                 self.contentView.frame.size.height,
                                 self.contentView.frame.size.height);
}




#pragma mark - State

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
  [super willTransitionToState:state];
  if (state == UITableViewCellStateShowingEditControlMask) {
    self.checkableButton.hidden = FALSE;
  }
  else if (state == UITableViewCellStateDefaultMask) {
    self.checkableButton.hidden = TRUE;
  }
}



#pragma mark - UI action

- (void)didCheckCell
{
  self.isChecked = !self.isChecked;
  if (self.isChecked) {
    if ([self.rootTableView respondsToSelector:@selector(didCheckCell:)]) {
      [(UITableViewEx *)self.rootTableView didCheckCell:self];
    }
  }
  else {
    if ([self.rootTableView respondsToSelector:@selector(didUnCheckCell:)]) {
      [(UITableViewEx *)self.rootTableView didUnCheckCell:self];
    }
  }
}

- (void)reset
{
  if (!self.rootTableView.editing) {
    self.checkableButton.hidden = TRUE;
  }
  else {
    self.checkableButton.hidden = FALSE;
  }
  self.isChecked = FALSE;
  [self.checkableButton unCheck];
}

- (void)setChecked
{
  if (!self.rootTableView.editing) {
    self.checkableButton.hidden = TRUE;
  }
  else {
    self.checkableButton.hidden = FALSE;
  }
  self.isChecked = TRUE;
  [self.checkableButton check];
}

- (void)didClickButton
{
  //call root view method
  if ([self.rootTableView respondsToSelector:@selector(didClickButtonWithCell:)]) {
    [(UITableViewEx *)self.rootTableView didClickButtonWithCell:self];
  }
}

@end