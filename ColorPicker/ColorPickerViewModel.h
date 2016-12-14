//
//  ColorPickerViewModel.h
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <QuartzCore/CAGradientLayer.h>
#import "CommonMacro.h"
@interface ColorPickerViewModel : NSObject
-(NSShadow *)addShadow:(CGFloat)radius setShadowColor:(NSColor *)color;
-(CAGradientLayer *)addGradientLayer:(NSRect)frame startColor:(NSColor *)startColor stopColor:(NSColor *)stopColor;
-(BOOL)isInCircleRing:(CGPoint)centerPoint movePoint:(CGPoint)movePoint outRadius:(CGFloat)outRadius innerRadius:(CGFloat)innerRadius;
-(BOOL)isInRect:(NSView *)view movePoint:(CGPoint)movePoint;
-(CGPoint)getSelectedCirclePosition:(CGPoint)centerPoint movePoint:(CGPoint)movePoint;
-(int)getSelectedCircleAngle:(CGPoint)centerPoint movePoint:(CGPoint)movePoint;
-(CGPoint)getSelectedCirclePositionByAngle:(CGPoint)centerPoint angle:(int)angle;
@end
