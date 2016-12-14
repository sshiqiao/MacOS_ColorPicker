//
//  Utils.m
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//
#import "CommonMacro.h"
#import "Utils.h"
#import<objc/runtime.h>
@implementation Utils

+(NSInteger)RGBToDec:(NSString *)red green:(NSString*)green bule:(NSString*)bule {
    NSInteger Red = [red integerValue];
    NSInteger Green = [green integerValue];
    NSInteger Bule = [bule integerValue];
    NSInteger colorsize = Red<<16 | Green << 8 | Bule;
    return colorsize;
}
+(NSString *)RGBToHex:(NSInteger)colorSize {
    return [NSString stringWithFormat:@"%06lx",colorSize];
}
+(NSArray *)NSColorToRGB:(NSColor *)color{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r=components[0]*255.0,g=components[1]*255.0,b=components[2]*255.0,a=components[3]*255.0;
    return @[@(r),@(g),@(b),@(a)];
}
+(NSColor *)RGBToNSColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
}
+(NSColor *)HSBToNSColor:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha{
    NSColor *color = [NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    return color;
}
+(NSColor*)DecToNSColor:(NSInteger)decValue{
    return [NSColor colorWithRed:((float)((decValue & 0xFF0000) >> 16))/255.0
                           green:((float)((decValue & 0xFF00) >> 8))/255.0
                            blue:((float)(decValue & 0xFF))/255.0 alpha:1.0];
}
+(NSArray *)NSColorToHSB:(NSColor *)color {
    CGFloat h=0,s=0,b=0,a=0;
    if ([color respondsToSelector:@selector(getHue:saturation:brightness:alpha:)]) {
        [color getHue:&h saturation:&s brightness:&b alpha:&a];
    }
    h = (int)(h*360.0),s = (int)(s*100.0),b = (int)(b*100.0),a = (int)(a*255.0);
    return @[@(h),@(s),@(b),@(a)];
}
+(NSInteger)HexToDec:(NSString *)hexValue {
    unsigned long dec = strtoul([hexValue UTF8String],0,16);
    return dec;
}
+(NSImage *)NSUrlToNSImage:(NSURL *)url {
    NSImage *image = [[NSImage alloc]initWithContentsOfURL:url];
    return image;
}
+(NSColor *)NSImageToNSColor:(NSImage *)image {
    return [NSColor colorWithPatternImage:image];
}
+(NSDictionary*)getObjectData:(id)obj{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil){
            value = [NSNull null];
        }else{
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+(id)getObjectInternal:(id)obj{
    if([obj isKindOfClass:[NSString class]]||[obj isKindOfClass:[NSNumber class]]||[obj isKindOfClass:[NSNull class]]){
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]){
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++){
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys){
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}
@end
