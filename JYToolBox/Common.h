//
//  Common.h
//  JYToolBox
//
//  Created by Jiehao YUAN on 13/05/13.
//  Copyright (c) 2013 yuan.idea. All rights reserved.
//

#ifndef JYTOOLBOX_Common_h
#define JYTOOLBOX_Common_h





////////////////////////////////////////////////////////////////////////////////
//////////MACRO
////////////////////////////////////////////////////////////////////////////////

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#define PROJECT_NAME      (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

#define DOCUMENT_DIRECTORY_URL \
[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

#define SCREEN_WIDTH      [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT     [[UIScreen mainScreen] bounds].size.height

#define NAVIGATION_BAR_HEIGHT             44
#define TAB_BAR_HEIGHT                    49
#define STATUS_BAR_HEIGHT                 [[UIApplication sharedApplication] statusBarFrame].size.height



////////////////////////////////////////////////////////////////////////////////
//////////Web Service
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//////////Notification
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//////////GOOGLE ANALYTICS
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//////////Color
////////////////////////////////////////////////////////////////////////////////

#define COLOR_RGBA(x, y, z, a)                  [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:a]

#define COLOR_GRAY(x)                           [UIColor colorWithRed:x/255.0f green:x/255.0f blue:x/255.0f alpha:1]

#define COLOR_RGB(x, y, z)                      [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1]

#define COLOR_TRANSPARENT_BLACK(x)              [UIColor colorWithWhite:0 alpha:x]

#define COLOR_COMMON_RED                        COLOR_RGB(226.0f, 0, 25.0f)
         

////////////////////////////////////////////////////////////////////////////////
//////////Font
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
//////////Notification
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
//////////Other
////////////////////////////////////////////////////////////////////////////////

void fillMatrix(int ** matrix, int size) {
  
  int line = 0;
  int row = 0;
  int origin = 0;
  int length = size - 1;
  
  for (int number = 1; number <= size * size; number++) {
    
    matrix[line][row] = number;
    
    if (line == origin + 1 && row == origin) {
      origin = origin + 1;
      length = length - 1;
    }
    
    if (line == origin && row != length) {
      row++;
    }
    else if (row == length && line != length) {
      line++;
    }
    else if (line == length && row != origin) {
      row--;
    }
    else if (row == origin && line != origin) {
      line--;
    }
  }
}

#endif