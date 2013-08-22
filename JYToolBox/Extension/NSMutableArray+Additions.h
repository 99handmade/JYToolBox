//
//  NSMutableArray+Additions.h
//  MFSC
//
//  Created by Jiehao YUAN on 26/06/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Additions)

- (void)addInteger:(NSInteger)number;

- (void)addString:(NSString *)str;

- (void)removeInteger:(NSInteger)number;

- (void)removeString:(NSString *)str;

@end