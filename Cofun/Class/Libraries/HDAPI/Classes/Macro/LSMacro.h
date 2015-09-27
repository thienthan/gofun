//
//  LSMacro.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#ifndef LSMacro_h
#define LSMacro_h

///---------------------------------------------------------------------------------------
/// Path
///---------------------------------------------------------------------------------------
#pragma mark - Path

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

///---------------------------------------------------------------------------------------
/// File Path
///---------------------------------------------------------------------------------------
#pragma mark - File Path

#define PATH_OF_PNG(NAME)           [[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]
#define PATH_OF_JPG(NAME)           [[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]
#define PATH_OF_FILE(NAME, EXT)     [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]


///---------------------------------------------------------------------------------------
/// Image
///---------------------------------------------------------------------------------------
#pragma mark - Image

#define IMAGE_PNG(NAME)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define IMAGE_JPG(NAME)     [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

///---------------------------------------------------------------------------------------
/// String
///---------------------------------------------------------------------------------------
#pragma mark - String

#define TRIM(x)         [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#define ENCODE_URI(x)   [x stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
#define DECODE_URI(x)   [x stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define IS_NULL(x)      [x isKindOfClass:[NSNull class]]

///---------------------------------------------------------------------------------------
/// Screen Frame
///---------------------------------------------------------------------------------------
#pragma mark - Screen Frame

#define APPLICATION_FRAME       [[UIScreen mainScreen] applicationFrame]
#define APPLICATION_HEIGHT      [[UIScreen mainScreen] applicationFrame].size.height
#define APPLICATION_WIDTH       [[UIScreen mainScreen] applicationFrame].size.width

#define SCREEN_FRAME            [[UIScreen mainScreen] bounds]
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width

///---------------------------------------------------------------------------------------
/// View Frame
///---------------------------------------------------------------------------------------

#pragma mark - View Frame

#define X(v)            (v).frame.origin.x
#define Y(v)            (v).frame.origin.y
#define WIDTH(v)        (v).frame.size.width
#define HEIGHT(v)       (v).frame.size.height

#define MIN_X(v)        CGRectGetMinX((v).frame)
#define MIN_Y(v)        CGRectGetMinY((v).frame)

#define MID_X(v)        CGRectGetMidX((v).frame)
#define MID_Y(v)        CGRectGetMidY((v).frame)

#define MAX_X(v)        CGRectGetMaxX((v).frame)
#define MAX_Y(v)        CGRectGetMaxY((v).frame)

///---------------------------------------------------------------------------------------
/// View Radius & Border
///---------------------------------------------------------------------------------------

#pragma mark - View Radius & Border

#define VIEW_BORDER_RADIUS(v, RADIUS, WIDTH, COLOR)\
\
[v.layer setCornerRadius:(RADIUS)];\
[v.layer setMasksToBounds:YES];\
[v.layer setBorderWidth:(WIDTH)];\
[v.layer setBorderColor:[COLOR CGColor]]

#define VIEW_RADIUS(v, RADIUS)\
\
[v.layer setCornerRadius:(RADIUS)];\
[v.layer setMasksToBounds:YES]

///---------------------------------------------------------------------------------------
/// Constants
///---------------------------------------------------------------------------------------

#pragma mark - Constants

#define SECOND_OF_DAY               (24.f * 60.f * 60.f)
#define SECONDS(DAYS)               (24.f * 60.f * 60.f * (DAYS))
#define MILLISECONDS_OF_DAY         (24.f * 60.f * 60.f * 1000.f)
#define MILLISECONDS(DAYS)          (24.f * 60.f * 60.f * 1000.f * (DAYS))

///---------------------------------------------------------------------------------------
/// Font
///---------------------------------------------------------------------------------------

#pragma mark - Font

#define BOLD_SYSTEM_FONT(FONT_SIZE)  [UIFont boldSystemFontOfSize:FONT_SIZE]
#define SYSTEM_FONT(FONT_SIZE)       [UIFont systemFontOfSize:FONT_SIZE]
#define FONT(NAME, FONT_SIZE)        [UIFont fontWithName:(NAME) size:(FONT_SIZE)]

///---------------------------------------------------------------------------------------
/// Color
///---------------------------------------------------------------------------------------

#pragma mark - Color

#define RGB_COLOR(r, g, b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBA_COLOR(r, g, b, a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB_COLOR_V(rgb)            [UIColor colorWithRed:((float)(((rgb) & 0xFF0000) >> 16))/255.0f green:((float)(((rgb) & 0xFF00) >> 8))/255.0f blue:((float)((rgb) & 0xFF))/255.0f alpha:1.0];

///---------------------------------------------------------------------------------------
/// Device
///---------------------------------------------------------------------------------------
#pragma mark - Device

#define IS_RETINA_DISPLAY   ([[UIScreen mainScreen] scale] >= 2)
#define IS_PHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPHONE_4S        (CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size))
#define IS_IPHONE_5         (CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size))
#define IS_IPHONE_6         (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size))
#define IS_IPHONE_6_PLUS    (CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size))

#define IS_REAL_DEVICE      (TARGET_OS_IPHONE)
#define IS_SIMULATOR        (TARGET_IPHONE_SIMULATOR)

#define DEVICE_NAME                 ([[UIDevice currentDevice] name])
#define DEVICE_MODEL                ([[UIDevice currentDevice] model])
#define DEVICE_MODEL_LOCALIZED      ([[UIDevice currentDevice] localizedModel])

#define SYSTEM_NAME             ([[UIDevice currentDevice ] systemName])
#define SYSTEM_VERSION          ([[UIDevice currentDevice ] systemVersion])
#define SYSTEM_VERSION_VALUE    ([[[UIDevice currentDevice ] systemVersion] floatValue])

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

///---------------------------------------------------------------------------------------
/// Condition
///---------------------------------------------------------------------------------------
#pragma mark - Condition
//
#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
/** iOS 6 or later */
#else
/** iOS 5, 4.3, ... */
#endif

///---------------------------------------------------------------------------------------
/// Text Alignment
///---------------------------------------------------------------------------------------

#pragma mark - Text Alignment

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0
# define LINE_BREAK_MODE_WORD_WRAP  NSLineBreakByWordWrapping
# define TEXT_ALIGNMENT_LEFT        NSTextAlignmentLeft
# define TEXT_ALIGNMENT_CENTER      NSTextAlignmentCenter
# define TEXT_ALIGNMENT_RIGHT       NSTextAlignmentRight

#else
# define LINE_BREAK_MODE_WORD_WRAP  UILineBreakModeWordWrap
# define TEXT_ALIGNMENT_LEFT        UITextAlignmentLeft
# define TEXT_ALIGNMENT_CENTER      UITextAlignmentCenter
# define TEXT_ALIGNMENT_RIGHT       UITextAlignmentRight

#endif

///---------------------------------------------------------------------------------------
/// Log
///---------------------------------------------------------------------------------------

#pragma mark - Log

#define LOG(x) NSLog(@"%@",x)
#define LOGI(x) NSLog(@"%d",x)
#define LOGF(x) NSLog(@"%f",x)

#if RELEASE
#define LLOG(content, ...) // Comment
#else
#define LLOG(content, ...) NSLog(content, ##__VA_ARGS__)
#endif

///---------------------------------------------------------------------------------------
/// Convert
///---------------------------------------------------------------------------------------

#pragma mark - Convert

#define DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

///---------------------------------------------------------------------------------------
/// Random
///---------------------------------------------------------------------------------------

#pragma mark - Random

#define RAND_UINT_MAX		0xFFFFFFFF
#define RAND_INT_MAX		0x7FFFFFFF

// RAND_UINT() positive unsigned integer from 0 to RAND_UINT_MAX
// RAND_INT() positive integer from 0 to RAND_INT_MAX
// RAND_INT_VAL(a,b) integer on the interval [a,b] (includes a and b)
#define RAND_UINT()				arc4random()
#define RAND_INT()				((int)(arc4random() & 0x7FFFFFFF))
#define RAND_INT_VAL(a,b)		((arc4random() % ((b)-(a)+1)) + (a))

// RAND_FLOAT() float between 0 and 1 (including 0 and 1)
// RAND_FLOAT_VAL(a,b) float between a and b (including a and b)
#define RAND_FLOAT()			(((float)arc4random()) / RAND_UINT_MAX)
#define RAND_FLOAT_VAL(a,b)		(((((float)arc4random()) * ((b)-(a))) / RAND_UINT_MAX) + (a))

// note: Random doubles will contain more precision than floats, but will NOT utilize the
//        full precision of the double. They are still limited to the 32-bit precision of arc4random
// RAND_DOUBLE() double between 0 and 1 (including 0 and 1)
// RAND_DOUBLE_VAL(a,b) double between a and b (including a and b)
#define RAND_DOUBLE()			(((double)arc4random()) / RAND_UINT_MAX)
#define RAND_DOUBLE_VAL(a,b)	(((((double)arc4random()) * ((b)-(a))) / RAND_UINT_MAX) + (a))

// RAND_BOOL() a random boolean (0 or 1)
// RAND_DIRECTION() -1 or +1 (usage: int steps = 10*RAND_DIRECTION();  will get you -10 or 10)
#define RAND_BOOL()				(arc4random() & 1)
#define RAND_DIRECTION()		(RAND_BOOL() ? 1 : -1)

///---------------------------------------------------------------------------------------
/// General
///---------------------------------------------------------------------------------------

#pragma mark - General

#define APPLICATION_DELEGATE                ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define USER_DEFAULTS                       [NSUserDefaults standardUserDefaults]
#define SHARED_APPLICATION                  [UIApplication sharedApplication]
#define BUNDLE                              [NSBundle mainBundle]
#define MAIN_SCREEN                         [UIScreen mainScreen]
#define SHOW_NETWORK_ACTIVITY()             [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HIDE_NETWORK_ACTIVITY()             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NETWORK_ACTIVITY_VISIBLE(x)         [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NAV_BAR                             self.navigationController.navigationBar
#define TAB_BAR                             self.tabBarController.tabBar
#define NAV_BAR_HEIGHT                      self.navigationController.navigationBar.bounds.size.height
#define TAB_BAR_HEIGHT                      self.tabBarController.tabBar.bounds.size.height

#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define DATE_TIME_COMPONENTS                NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit



#pragma mark -
//
#define SHOW_ALERT(title,msg,del,cancel,other,...) { \
UIAlertView *_alert = [[[UIAlertView alloc] initWithTitle:title message:msg delegate:del cancelButtonTitle:cancel otherButtonTitles:other, ##__VA_ARGS__] autorelease]; \
[_alert show]; \
}

#pragma mark -
//

#endif
