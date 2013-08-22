//
//  NSDate+Additions.m
//  MFSC
//
//  Created by Jiehao YUAN on 01/07/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (NSInteger)year
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSYearCalendarUnit fromDate:[NSDate date]];
  return dateComponents.year;
}

- (NSInteger)month
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSMonthCalendarUnit fromDate:self];
  return dateComponents.month;
}

- (NSString *)frMonthWithFirstLetterCapital:(BOOL)capital
{
  NSString * month = nil;
  switch ([self month]) {
    case 1:
      month = capital?@"Janvier":@"janvier";
      break;
    case 2:
      month = capital?@"Février":@"février";
      break;
    case 3:
      month = capital?@"Mars":@"mars";
      break;
    case 4:
      month = capital?@"Avril":@"avril";
      break;
    case 5:
      month = capital?@"Mai":@"mai";
      break;
    case 6:
      month = capital?@"Juin":@"juin";
      break;
    case 7:
      month = capital?@"Juillet":@"Juillet";
      break;
    case 8:
      month = capital?@"Août":@"août";
      break;
    case 9:
      month = capital?@"Septembre":@"septembre";
      break;
    case 10:
      month = capital?@"Octobre":@"octobre";
      break;
    case 11:
      month = capital?@"Novembre":@"novembre";
      break;
    case 12:
      month = capital?@"Décembre":@"décembre";
      break;
    default:
      break;
  }
  return month;
}

- (NSInteger)day
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSEraCalendarUnit
                                       | NSYearCalendarUnit
                                       | NSMonthCalendarUnit
                                       | NSDayCalendarUnit fromDate:self];
  return dateComponents.day;
}

- (NSInteger)hour
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSHourCalendarUnit fromDate:self];
  return dateComponents.hour;
}

- (NSInteger)minute
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSMinuteCalendarUnit fromDate:self];
  return dateComponents.minute;
}

- (NSInteger)second
{
  NSDateComponents * dateComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]
                                       components:NSSecondCalendarUnit fromDate:self];
  return dateComponents.second;
}

@end