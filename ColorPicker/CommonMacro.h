//
//  CommonMacro.h
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


//Size
#define SCREEN_WIDTH   NSScreen.mainScreen.frame.size.width
#define SCREENH_HEIGHT NSScreen.mainScreen.frame.size.height

#define NSViewWidth(view) CGRectGetWidth(view.frame)
#define NSViewHeight(view) CGRectGetHeight(view.frame)

#define NSViewMinX(view) CGRectGetMinX(view.frame)
#define NSViewMinY(view) CGRectGetMinY(view.frame)

#define NSViewMidX(view) CGRectGetMidX(view.frame)
#define NSViewMidY(view) CGRectGetMidY(view.frame)

#define NSViewMaxX(view) CGRectGetMaxX(view.frame)
#define NSViewMaxY(view) CGRectGetMaxY(view.frame)

//Color
#define WhiteColor [NSColor whiteColor]
#define BlackColor [NSColor blackColor]
#define YellowColor [NSColor yellowColor]
#define GrayColor [NSColor grayColor]
#define ClearColor [NSColor clearColor]
#define RedColor [NSColor redColor]

#define TransparentBlackColor [NSColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:0.5]
#define LightLightGrayColor [NSColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:0.7]
#define LightGrayColor [NSColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:0.75]
#define GrayDarkColor [NSColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1]
#define SnowColor [NSColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1]
#define GhostWhiteColor [NSColor colorWithRed:248.0 / 255.0 green:248.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define WhiteSmokeColor [NSColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1]
#define GainsboroColor [NSColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1]
#define FloralWhiteColor [NSColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:220.0 / 240.0 alpha:1]
#define ThemeColor [NSColor colorWithRed:253.0 / 255.0 green:245.0 / 255.0 blue:230.0 / 255.0 alpha:0.75]
#define ThemeLightColor [NSColor colorWithRed:253.0 / 255.0 green:245.0 / 255.0 blue:230.0 / 255.0 alpha:0.5]
#define ThemeDarkColor [NSColor colorWithRed:255.0 / 255.0 green:242.0 / 255.0 blue:204.0 / 255.0 alpha:0.9]
//Font
#define SmallSystemFont [NSFont systemFontOfSize:12.0f]
#define BoldSmallSystemFont [NSFont boldSystemFontOfSize:12]

#define MediumSystemFont [NSFont systemFontOfSize:14.0f]
#define BoldMediumSystemFont [NSFont boldSystemFontOfSize:14.0f]

#define BigSystemFont [NSFont systemFontOfSize:17.0f]
#define BoldBigSystemFont [NSFont boldSystemFontOfSize:17.0f]

#endif /* CommonMacro_h */
