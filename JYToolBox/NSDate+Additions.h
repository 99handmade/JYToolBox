//
//  NSDate+Additions.h
//  MFSC
//
//  Created by Jiehao YUAN on 01/07/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

- (NSInteger)year;

- (NSInteger)month;

- (NSString *)frMonthWithFirstLetterCapital:(BOOL)capital;

- (NSInteger)day;

- (NSInteger)hour;

- (NSInteger)minute;

- (NSInteger)second;

@end