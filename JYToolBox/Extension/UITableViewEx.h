//
//  UITableViewEx.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UITableViewExDelegate <NSObject, UITableViewDelegate>

@optional

- (void)tableView:(UITableView *)tableView didCheckCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didUnCheckCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView beginDraggingCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView endDraggingCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didClickButtonAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface UITableViewEx : UITableView

@property (nonatomic, unsafe_unretained) id<UITableViewExDelegate>      delegate;

@property (nonatomic, strong, readonly) NSMutableArray *                    checkedCellIndexPaths;

- (void)didCheckCell:(UITableViewCell *)cell;

- (void)didUnCheckCell:(UITableViewCell *)cell;

- (void)beginDraggingCell:(UITableViewCell *)cell;

- (void)endDraggingCell:(UITableViewCell *)cell;

- (void)didClickButtonWithCell:(UITableViewCell *)cell;

- (void)clearHistory;

@end