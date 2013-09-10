//
//  UITableViewEx.m
//  JYToolBox
//
//  Created by Jiehao YUAN on 12/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "UITableViewEx.h"


@implementation UITableViewEx

@synthesize checkedCellIndexPaths = _checkCellIndexPaths;



#pragma mark - Init & Dealloc

- (id)init
{
  return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _checkCellIndexPaths = [NSMutableArray arrayWithCapacity:0];
  }
  return self;
}




#pragma mark - Delegate method for cell event

- (void)didCheckCell:(UITableViewCell *)cell
{
  NSIndexPath * indexPath = [self indexPathForCell:cell];
  
  BOOL isContained = FALSE;
  for (NSIndexPath * ip in _checkCellIndexPaths) {
    NSComparisonResult result = [ip compare:indexPath];
    if (result == NSOrderedSame) {
      isContained = TRUE;
    }
  }
  
  if (!isContained) {
    [_checkCellIndexPaths addObject:indexPath];
  }

  if ([self.delegate respondsToSelector:@selector(tableView:didCheckCellAtIndexPath:)]) {
    [self.delegate tableView:self didCheckCellAtIndexPath:indexPath];
  }
}

- (void)didUnCheckCell:(UITableViewCell *)cell
{
  NSIndexPath * indexPath = [self indexPathForCell:cell];
  
  for (NSIndexPath * ip in [_checkCellIndexPaths copy]) {
    NSComparisonResult result = [ip compare:indexPath];
    if (result == NSOrderedSame) {
      [_checkCellIndexPaths removeObject:ip];
    }
  }
  
  if ([self.delegate respondsToSelector:@selector(tableView:didUnCheckCellAtIndexPath:)]) {
    [self.delegate tableView:self didUnCheckCellAtIndexPath:indexPath];
  }
}

- (void)beginDraggingCell:(UITableViewCell *)cell
{
  NSIndexPath * indexPath = [self indexPathForCell:cell];
  if ([self.delegate respondsToSelector:@selector(tableView:beginDraggingCellAtIndexPath:)]) {
    [self.delegate tableView:self beginDraggingCellAtIndexPath:indexPath];
  }
}

- (void)endDraggingCell:(UITableViewCell *)cell
{
  NSIndexPath * indexPath = [self indexPathForCell:cell];
  if ([self.delegate respondsToSelector:@selector(tableView:endDraggingCellAtIndexPath:)]) {
    [self.delegate tableView:self endDraggingCellAtIndexPath:indexPath];
  }
}

- (void)didClickButtonWithCell:(UITableViewCell *)cell
{
  NSIndexPath * indexPath = [self indexPathForCell:cell];
  
  if ([self.delegate respondsToSelector:@selector(tableView:didClickPlusButtonAtIndexPath:)]) {
    [self.delegate tableView:self didClickButtonAtIndexPath:indexPath];
  }
}

- (void)clearHistory
{
  [_checkCellIndexPaths removeAllObjects];
}

@end