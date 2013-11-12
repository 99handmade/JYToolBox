//
//  AppDelegate.h
//  JYToolBoxExample
//
//  Created by Jiehao YUAN on 12/11/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleListTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *  window;

@property (strong, nonatomic) UINavigationController *  navController;

@property (strong, nonatomic) ExampleListTableViewController *    exampleListTableViewController;

@end