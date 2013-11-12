//
//  ExampleListTableViewController.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/11/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewControllerEx.h"
#import "UITextFieldExExampleViewController.h"

@interface ExampleListTableViewController : UIViewControllerEx <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *       tableView;

@property (nonatomic, strong) UITextFieldExExampleViewController *  textFieldExExampleViewController;

@end