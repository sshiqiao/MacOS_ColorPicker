//
//  Color.h
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Utils.h"

@class HSB;
@class RGB;

@interface Color : NSObject

@property (nonatomic) CGFloat angleValue;//0-360
@property (nonatomic) CGFloat HValue;//0-1.0
@property (nonatomic) CGFloat SValue;//0-1.0
@property (nonatomic) CGFloat BValue;//0-1.0
@property (nonatomic) CGFloat AValue;//0-1.0
@property (nonatomic, strong) NSColor *NSColor;

@property (nonatomic, strong) HSB *HSBColorVaule;
@property (nonatomic, strong) RGB *RGBColorVaule;
@property (nonatomic, strong) NSString *HEXColorVaule;
- (instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)init;
-(void)updateColorValue;
-(void)updateColorValueWithHSB;
-(void)updateColorValueWithRGB;
-(void)updateColorValueWithHEX;
-(NSColor *) HSBAToNSColor;
-(HSB *) NSColorToHSB;
-(RGB *) NSColorToRGB;
-(NSString *) NSColorToHex;
-(NSColor *)HSBToNSColor;
-(NSColor *) RGBToNSColor;
-(NSColor *) HexToNSColor;
@end

@interface HSB : NSObject
@property (nonatomic) int H;//0-360
@property (nonatomic) int S;//0-100
@property (nonatomic) int B;//0-100
@property (nonatomic) int A;//0-255
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface RGB : NSObject
@property (nonatomic) int R;//0-255
@property (nonatomic) int G;//0-255
@property (nonatomic) int B;//0-255
@property (nonatomic) int A;//0-255
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
