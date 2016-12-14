//
//  ColorPickerViewModel.m
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import "ColorPickerViewModel.h"

@implementation ColorPickerViewModel
-(NSShadow *)addShadow:(CGFloat)radius setShadowColor:(NSColor *)color{
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowBlurRadius:radius];
    [shadow setShadowColor:color];
    return shadow;
}
-(CAGradientLayer *)addGradientLayer:(NSRect)frame startColor:(NSColor *)startColor stopColor:(NSColor *)stopColor{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = frame;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint   = CGPointMake(1, 0);
    layer.colors = @[(id)startColor.CGColor, (id)stopColor.CGColor];
    return layer;
}
-(BOOL)isInCircleRing:(CGPoint)centerPoint movePoint:(CGPoint)movePoint outRadius:(CGFloat)outRadius innerRadius:(CGFloat)innerRadius{
    BOOL isInCircleRing = NO;
    if(pow((movePoint.x-centerPoint.x),2)+pow((movePoint.y-centerPoint.y),2)<pow(outRadius,2)){
        if(pow((movePoint.x-centerPoint.x),2)+pow((movePoint.y-centerPoint.y),2)>pow(innerRadius,2)){
            isInCircleRing = YES;
        }
    }
    return isInCircleRing;
}
-(BOOL)isInRect:(NSView *)view movePoint:(CGPoint)movePoint {
    BOOL isInRect = NO;
    if((NSViewMinX(view)-1)<=movePoint.x&&movePoint.x<=(NSViewMaxX(view)+1)&&(NSViewMinY(view)-5)<=movePoint.y&&movePoint.y<=(NSViewMaxY(view)+5)){
        isInRect = YES;
    }
    return isInRect;
}
-(CGPoint)getSelectedCirclePosition:(CGPoint)centerPoint movePoint:(CGPoint)movePoint{
    CGFloat r = sqrt(pow((movePoint.x-centerPoint.x),2)+pow((movePoint.y-centerPoint.y),2));
    CGFloat x = centerPoint.x - 75*(centerPoint.x-movePoint.x)/r;
    CGFloat y = centerPoint.y - 75*(centerPoint.y-movePoint.y)/r;
    return CGPointMake(x, y);
}
-(int)getSelectedCircleAngle:(CGPoint)centerPoint movePoint:(CGPoint)movePoint{
    int angle = 180*atan2(movePoint.y-centerPoint.y,centerPoint.x-movePoint.x)/M_PI;
    if(angle<0){
        angle+=360;
    }
    if(angle==360){
        angle=0;
    }
    return angle;
}
-(CGPoint)getSelectedCirclePositionByAngle:(CGPoint)centerPoint angle:(int)angle{
    CGFloat x = -cos(angle*M_PI/180)*75+centerPoint.x;
    CGFloat y = sin(angle*M_PI/180)*75+centerPoint.y;
    return CGPointMake(x, y);
}
@end
