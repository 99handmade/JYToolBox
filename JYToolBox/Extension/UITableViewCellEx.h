//
//  UITableViewCellEx.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 16/05/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCellEx : UITableViewCell

@property (nonatomic, unsafe_unretained) UITableView *    rootTableView;

- (void)reset;

- (void)setChecked;

@end