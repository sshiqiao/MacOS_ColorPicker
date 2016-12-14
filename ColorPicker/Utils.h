//
//  Utils.h
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface Utils : NSObject

+(NSInteger)RGBToDec:(NSString *)red green:(NSString*)green bule:(NSString*)bule;

+(NSString *)RGBToHex:(NSInteger)colorSize;

+(NSArray *)NSColorToRGB:(NSColor *)color;

+(NSColor *)RGBToNSColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+(NSColor *)HSBToNSColor:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

+(NSColor*)DecToNSColor:(NSInteger)hexValue;

+(NSArray *)NSColorToHSB:(NSColor *)color;

+(NSInteger)HexToDec:(NSString *)hexValue;

+(NSImage *)NSUrlToNSImage:(NSURL *)url;

+(NSColor *)NSImageToNSColor:(NSImage *)image;

+(NSDictionary*)getObjectData:(id)obj;

@end

