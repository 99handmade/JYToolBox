//
//  UIViewControllerEx.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 29/10/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UIViewControllerEx.h"

@interface UIViewControllerEx ()

@end

@implementation UIViewControllerEx


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //for iOS < 7, set view full screen
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
    self.wantsFullScreenLayout = TRUE;
  }
  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  self.navigationController.navigationBar.translucent = TRUE;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  
  if ([self isViewLoaded] && [self.view window] == nil)
  {
    // Add code to preserve data stored in the views that might be
    // needed later.
    // Add code to clean up other strong references to the view in
    // the view hierarchy.
    self.view = nil;
  }
}

- (BOOL)shouldAutorotate
{
  return FALSE;
}

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskAll;
}

@end