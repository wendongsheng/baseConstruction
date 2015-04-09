//
//  EWCommon.h
//  BaseFramework
//
//  Created by wendongsheng on 15/4/3.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

/**
 *  打印
 */
#ifdef DEBUG
#define CLog(format, ...) NSLog(format,##__VA_ARGS__)
#else
#define CLog(format, ...)
#endif

/**
 *  color
 */
#define BLACK_COLOR         [UIColor blackColor]
#define DARKGRAY_COLOR      [UIColor darkGrayColor]
#define LIGHTGRAY_COLOR     [UIColor lightGrayColor]
#define WHITE_COLOR         [UIColor whiteColor]
#define GRAY_COLOR          [UIColor grayColor]
#define RED_COLOR           [UIColor redColor]
#define GREEN_COLOR         [UIColor greenColor]
#define BLUE_COLOR          [UIColor blueColor]
#define CYAN_COLOR          [UIColor cyanColor]
#define YELLOW_COLOR        [UIColor yellowColor]
#define MAGENTA_COLOR       [UIColor magentaColor]
#define ORANGE_COLOR        [UIColor orangeColor]
#define PURPLE_COLOR        [UIColor purpleColor]
#define BROWN_COLOR         [UIColor brownColor]
#define CLEAR_COLOR         [UIColor clearColor]

#define RGB_COLOR(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBA_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0  alpha:A]

#define COLOR_N(INT)        [UIColor colorWithRed:(INT/255.0f) green:(INT/255.0f) blue:(INT/255.0f) alpha:1]
#define COLOR_F(Float)      [UIColor colorWithRed:(Float) green:(Float) blue:(Float) alpha:1]

/**
 *  screen size
 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  font
 */
#define FONT(A)  [UIFont systemFontOfSize:(A)]

/**
 *  设备
 */
#define iPad    ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?YES:NO
#define iPhone  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?YES:NO

/**
 *  sdk version
 */
#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define AppVersion    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

/**
 *  IOS7
 */
#define IOS7Later ([SystemVersion floatValue] >=7.0)
#define IOS7AndLater (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? YES : NO)
/**
 *  坐标
 */
//计算相邻坐标
#define NextView_X(view)  (view.frame.origin.x + view.frame.size.width)  //view右侧边缘的x坐标
#define NextView_Y(view)  (view.frame.origin.y + view.frame.size.height)  //view下方边缘的y坐标
#define ViewOX(view) (view.frame.origin.x)
#define ViewOY(view) (view.frame.origin.y)
#define ViewFW(view) (view.frame.size.width)
#define ViewFH(view) (view.frame.size.height)

/**
 *  图片
 */
#define ImageWithFile(name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]])
#define ImageNamed(name) [UIImage imageNamed:name]

/**
 *  string
 */
#define Str(str)  (str ? [NSString stringWithFormat:@"%@", str] : nil)

/**
 *  appdelegate
 */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


