//
//  Color.m
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import "Color.h"

@implementation Color
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _HSBColorVaule = [[HSB alloc]initWithDict:(NSDictionary *)_HSBColorVaule];
        _RGBColorVaule = [[RGB alloc]initWithDict:(NSDictionary *)_RGBColorVaule];
        _NSColor = [Utils HSBToNSColor:_HSBColorVaule.H/360.0 saturation:_HSBColorVaule.S/100.0 brightness:_HSBColorVaule.B/100.0 alpha:_HSBColorVaule.A/255.0];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if(self){
        _HSBColorVaule = [[HSB alloc]init];
        _RGBColorVaule = [[RGB alloc]init];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[Utils getObjectData:self] forKey:@"color"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self = [[Color alloc]initWithDict:[aDecoder decodeObjectForKey:@"color"]];
    }
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    Color *color = [Color allocWithZone:zone];
    color.angleValue = _angleValue;
    color.HValue = _HValue;
    color.SValue = _SValue;
    color.BValue = _BValue;
    color.AValue = _AValue;
    color.NSColor = [Utils HSBToNSColor:_HSBColorVaule.H/360.0 saturation:_HSBColorVaule.S/100.0 brightness:_HSBColorVaule.B/100.0 alpha:_HSBColorVaule.A/255.0];
    color.HSBColorVaule = [self NSColorToHSB];
    color.RGBColorVaule = [self NSColorToRGB];
    color.HEXColorVaule = [self NSColorToHex];
    return color;
}
-(void)updateColorValue {
    _HSBColorVaule = [self NSColorToHSB];
    _RGBColorVaule = [self NSColorToRGB];
    _HEXColorVaule = [self NSColorToHex];
    _HValue = _HSBColorVaule.H/360.0;
    _SValue = _HSBColorVaule.S/100.0;
    _BValue = _HSBColorVaule.B/100.0;
    _AValue = _HSBColorVaule.A/255.0;
    _angleValue = _HSBColorVaule.H==360?0:_HSBColorVaule.H;
}
-(void)updateColorValueWithHSB {
    _RGBColorVaule = [self NSColorToRGB];
    _HEXColorVaule = [self NSColorToHex];
    _HValue = _HSBColorVaule.H/360.0;
    _SValue = _HSBColorVaule.S/100.0;
    _BValue = _HSBColorVaule.B/100.0;
    _AValue = _HSBColorVaule.A/255.0;
    _angleValue = _HSBColorVaule.H==360?0:_HSBColorVaule.H;
}
-(void)updateColorValueWithRGB {
    _HSBColorVaule = [self NSColorToHSB];
    _HEXColorVaule = [self NSColorToHex];
    _HValue = _HSBColorVaule.H/360.0;
    _SValue = _HSBColorVaule.S/100.0;
    _BValue = _HSBColorVaule.B/100.0;
    _AValue = _HSBColorVaule.A/255.0;
    _angleValue = _HSBColorVaule.H==360?0:_HSBColorVaule.H;
}
-(void)updateColorValueWithHEX {
    _HSBColorVaule = [self NSColorToHSB];
    _RGBColorVaule = [self NSColorToRGB];
    _HValue = _HSBColorVaule.H/360.0;
    _SValue = _HSBColorVaule.S/100.0;
    _BValue = _HSBColorVaule.B/100.0;
    _AValue = _HSBColorVaule.A/255.0;
    _angleValue = _HSBColorVaule.H==360?0:_HSBColorVaule.H;
}
-(NSColor *) HSBAToNSColor {
    _NSColor = [Utils HSBToNSColor:_HValue saturation:_SValue brightness:_BValue alpha:_AValue];
    return _NSColor;
}
-(HSB *) NSColorToHSB {
    NSArray *HSBArray = [Utils NSColorToHSB:_NSColor];
    _HSBColorVaule.H = [[HSBArray objectAtIndex:0] intValue]==360?0:[[HSBArray objectAtIndex:0] intValue];
    _HSBColorVaule.S = [[HSBArray objectAtIndex:1] intValue];
    _HSBColorVaule.B = [[HSBArray objectAtIndex:2] intValue];
    _HSBColorVaule.A = [[HSBArray objectAtIndex:3] intValue];
    return _HSBColorVaule;
}
-(RGB *) NSColorToRGB {
    NSArray *RGBArray = [Utils NSColorToRGB:_NSColor];
    _RGBColorVaule.R = [[RGBArray objectAtIndex:0] intValue];
    _RGBColorVaule.G = [[RGBArray objectAtIndex:1] intValue];
    _RGBColorVaule.B = [[RGBArray objectAtIndex:2] intValue];
    _RGBColorVaule.A = [[RGBArray objectAtIndex:3] intValue];
    return _RGBColorVaule;
}
-(NSString *) NSColorToHex {
    RGB *RGB = [self NSColorToRGB];
    _HEXColorVaule = [Utils RGBToHex:[Utils RGBToDec:[NSString stringWithFormat:@"%d",RGB.R] green:[NSString stringWithFormat:@"%d",RGB.G] bule:[NSString stringWithFormat:@"%d",RGB.B]]];
    return _HEXColorVaule;
}
-(NSColor *) HSBToNSColor {
    _NSColor = [Utils HSBToNSColor:_HSBColorVaule.H/360.0 saturation:_HSBColorVaule.S/100.0 brightness:_HSBColorVaule.B/100.0 alpha:_HSBColorVaule.A/255.0];
    return _NSColor;
}
-(NSColor *) RGBToNSColor {
    _NSColor = [Utils RGBToNSColor:_RGBColorVaule.R/255.0 green:_RGBColorVaule.G/255.0 blue:_RGBColorVaule.B/255.0 alpha:_RGBColorVaule.A/255.0];
    return _NSColor;
}
-(NSColor *) HexToNSColor {
    _NSColor = [Utils DecToNSColor:[Utils HexToDec:_HEXColorVaule]];
    return _NSColor;
}
@end

@implementation HSB
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end

@implementation RGB
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
