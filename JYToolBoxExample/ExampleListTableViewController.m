//
//  ExampleListTableViewController.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/11/2013.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "ExampleListTableViewController.h"

#import "Common.h"

#import "UITextFieldExExampleViewController.h"

@interface ExampleListTableViewController ()

@end

@implementation ExampleListTableViewController





#pragma mark - View life Cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                 STATUS_BAR_HEIGHT,
                                                                 SCREEN_WIDTH,
                                                                 SCREEN_HEIGHT)
                                                style:UITableViewStylePlain];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * cellID = @"cell";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  if (indexPath.row == 0) {
    cell.textLabel.text = @"UITextFieldEx";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    self.textFieldExExampleViewController = [[UITextFieldExExampleViewController alloc] init];
    [self.navigationController pushViewController:self.textFieldExExampleViewController animated:TRUE];
  }
}

@end