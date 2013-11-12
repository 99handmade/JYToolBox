//
//  UITextFieldExExampleViewController.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/11/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UITextFieldExExampleViewController.h"

#import "UIImage+Additions.h"

#import "UITextFieldEx.h"

@interface UITextFieldExExampleViewController ()

@end

@implementation UITextFieldExExampleViewController




#pragma mark - View life cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.textField1 = [[UITextFieldEx alloc] init];
  self.textField1.frame = CGRectMake(10, 160, 300, 40);
  self.textField1.rightView = [[UIImageView alloc] initWithImage:
                              [UIImage imageWithColor:[UIColor grayColor] size:CGSizeMake(30, 30)]];
  self.textField1.borderStyle = UITextBorderStyleRoundedRect;
  self.textField1.rightViewMode = UITextFieldViewModeAlways;
  self.textField1.helpInfo = @"this is a help info.";
  [self.view addSubview:self.textField1];
  
  self.textField2 = [[UITextFieldEx alloc] init];
  self.textField2.frame = CGRectMake(10, 260, 300, 40);
  self.textField2.rightView = [[UIImageView alloc] initWithImage:
                               [UIImage imageWithColor:[UIColor grayColor] size:CGSizeMake(30, 30)]];
  self.textField2.borderStyle = UITextBorderStyleRoundedRect;
  self.textField2.rightViewMode = UITextFieldViewModeAlways;
  
  NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
  NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                NSFontAttributeName:[UIFont systemFontOfSize:15]};
  NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]
                                                initWithString:@"this is a help info with attributed text, the height of the pop up will change with the text"
                                                attributes:attributes];
  
  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9, 11)];

  self.textField2.attributedHelpInfo = attributedText;
  [self.view addSubview:self.textField2];
}

@end