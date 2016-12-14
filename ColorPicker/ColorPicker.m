//
//  ColorPicker.m
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <QuartzCore/CAGradientLayer.h>
#import "ColorPicker.h"
#define CLICK_PRECOLOR_BUTTON_TAG 100
#define CLICK_CURCOLOR_BUTTON_TAG 200

@interface ColorPicker (){
    NSTrackingArea *_preColorButtonTrackingArea;
    NSTrackingArea *_curColorButtonTrackingArea;
    BOOL           _isMoveEntredPreColorButton;
    BOOL           _isMoveEntredCurColorButton;
}
@property NSImageView *colorPickerCircleImageView;
@property NSImageView *selectedColorImageView;
@property CGPoint centerPoint;
@property CGFloat circleRadius;
@property NSButton *selectedColorButton;
@property NSButton *preSelectedColorButton;
@property NSImageView *selectedSStripColorImageView;
@property NSImageView *selectedBStripColorImageView;
@property NSImageView *selectedAStripColorImageView;
@property NSView *colorPickerSStripView;
@property NSView *colorPickerBStripView;
@property NSView *colorPickerAStripView;

@property NSTextView *HTextView;
@property NSTextField *HTextField;
@property NSTextView *STextView;
@property NSTextField *STextField;
@property NSTextView *BTextView;
@property NSTextField *BTextField;
@property NSTextView *ATextView;
@property NSTextField *ATextField;

@property NSTextView *ColorTextView;
@property NSTextField *ColorTextField;
@property NSTextView *RTextView;
@property NSTextField *RTextField;
@property NSTextView *GTextView;
@property NSTextField *GTextField;
@property NSTextView *B2TextView;
@property NSTextField *B2TextField;

@end
@implementation ColorPicker
- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _viewModel = [[ColorPickerViewModel alloc]init];
        _hueColors = [NSMutableArray array];
        for (int i = 0 ; i < 360; i++) {
            NSColor *color = [NSColor colorWithHue:i/360.0 saturation:1.0 brightness:1.0 alpha:1.0];
            [_hueColors addObject:color];
        }
        if([self readDataFromUserDefaults]){
            _curColor = [self readDataFromUserDefaults];
        }else{
            _curColor = [[Color alloc]init];
            _curColor.angleValue = 150.0;
            _curColor.HValue = (CGFloat)_curColor.angleValue/360.0;
            _curColor.SValue = 1.0;
            _curColor.BValue = 1.0;
            _curColor.AValue = 1.0;
            _curColor.NSColor = [_curColor HSBAToNSColor];
            [_curColor updateColorValue];
        }
        _preColor = [_curColor mutableCopy];
        [self setUpView];
    }
    return self;
}

#pragma init view
- (void)setUpView
{
    [self setWantsLayer:YES];
    [self.layer setBackgroundColor:WhiteSmokeColor.CGColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:nil];
    
    [self addColorPickerCircle];
    [self addColorPickerStrip];
    [self addPropertiesView];
    [self setColorPickerValue];
}
- (void)addColorPickerCircle{
    _colorPickerCircleImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(20, NSViewHeight(self)-200-40, 200, 200)];
    NSImage *image = [NSImage imageNamed:@"color_picker_hue"];
    [image setSize:NSMakeSize(200, 200)];
    _colorPickerCircleImageView.image = image;
    [_colorPickerCircleImageView setWantsLayer:YES];
    [_colorPickerCircleImageView.layer setBackgroundColor:WhiteColor.CGColor];
    [_colorPickerCircleImageView.layer setCornerRadius:200/2];
    [_colorPickerCircleImageView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    [self addSubview:_colorPickerCircleImageView];
    _centerPoint = CGPointMake(NSViewMidX(_colorPickerCircleImageView),NSViewMidY(_colorPickerCircleImageView));
    _circleRadius = 200/2;
    
    _selectedColorImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(0 ,0, 30, 30)];
    _selectedColorImageView.image = [NSImage imageNamed:@"color_picker_crosshair"];
    [self addSubview:_selectedColorImageView];
    
    _selectedColorButton = [self addButton:self setTitle:@"" setTag:CLICK_CURCOLOR_BUTTON_TAG];
    [_selectedColorButton setAction:@selector(clickButtonEvent:)];
    [_selectedColorButton setFrame:NSMakeRect(NSViewMidX(_colorPickerCircleImageView)-40, NSViewMidY(_colorPickerCircleImageView)-40, 80, 80)];
    [_selectedColorButton.layer setCornerRadius:40];
    [_selectedColorButton setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    
    _preSelectedColorButton = [self addButton:self setTitle:@"" setTag:CLICK_PRECOLOR_BUTTON_TAG];
    [_preSelectedColorButton setAction:@selector(clickButtonEvent:)];
    [_preSelectedColorButton setFrame:NSMakeRect(NSViewMaxX(_colorPickerCircleImageView)-30, NSViewMaxY(_colorPickerCircleImageView)-34, 34, 34)];
    [_preSelectedColorButton.layer setCornerRadius:17];
    [_preSelectedColorButton.layer setBackgroundColor:_curColor.NSColor.CGColor];
    [_preSelectedColorButton setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
}
- (void)addColorPickerStrip{
    _colorPickerSStripView = [[NSView alloc]initWithFrame:NSMakeRect(20, NSViewMinY(_colorPickerCircleImageView)-8-20, 200, 8)];
    [_colorPickerSStripView setWantsLayer:YES];
    [_colorPickerSStripView.layer setBackgroundColor:WhiteColor.CGColor];
    [_colorPickerSStripView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    [self addSubview:_colorPickerSStripView];
    _selectedSStripColorImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(NSViewMinX(_colorPickerSStripView)-5+_curColor.SValue*NSViewWidth(_colorPickerSStripView), NSViewMidY(_colorPickerSStripView)-10, 10, 20)];
    NSImage *image = [NSImage imageNamed:@"color_picker_slider_bar"];
    [image setSize:NSMakeSize(10, 20)];
    _selectedSStripColorImageView.image = image;
    [self addSubview:_selectedSStripColorImageView];
    [_selectedSStripColorImageView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    
    _colorPickerBStripView = [[NSView alloc]initWithFrame:NSMakeRect(20, NSViewMinY(_colorPickerSStripView)-8-20, 200, 8)];
    [_colorPickerBStripView setWantsLayer:YES];
    [_colorPickerBStripView.layer setBackgroundColor:WhiteColor.CGColor];
    [_colorPickerBStripView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    [self addSubview:_colorPickerBStripView];
    _selectedBStripColorImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(NSViewMinX(_colorPickerBStripView)-5+(1.0-_curColor.BValue)*NSViewWidth(_colorPickerBStripView), NSViewMidY(_colorPickerBStripView)-10, 10, 20)];
    _selectedBStripColorImageView.image = image;
    [self addSubview:_selectedBStripColorImageView];
    [_selectedBStripColorImageView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    
    _colorPickerAStripView = [[NSView alloc]initWithFrame:NSMakeRect(20, NSViewMinY(_colorPickerBStripView)-8-20, 200, 8)];
    [_colorPickerAStripView setWantsLayer:YES];
    NSColor *color = [NSColor colorWithPatternImage:[NSImage imageNamed:@"color_picker_checkered"]];;
    [_colorPickerAStripView.layer setBackgroundColor:color.CGColor];
    [_colorPickerAStripView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
    [self addSubview:_colorPickerAStripView];
    _selectedAStripColorImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(NSViewMinX(_colorPickerAStripView)-5+(1.0-_curColor.AValue)*NSViewWidth(_colorPickerAStripView), NSViewMidY(_colorPickerAStripView)-10, 10, 20)];
    _selectedAStripColorImageView.image = image;
    [self addSubview:_selectedAStripColorImageView];
    [_selectedAStripColorImageView setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
}
- (void)addPropertiesView {
    NSView *propertiesContainerView = [[NSView alloc]initWithFrame:NSMakeRect(NSViewMaxX(_colorPickerCircleImageView)+10, 0, 220, NSViewHeight(self))];
    [propertiesContainerView setWantsLayer:YES];
    [self addSubview:propertiesContainerView];
    
    _HTextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"H"];
    [_HTextView setFrame:NSMakeRect(0, NSViewHeight(propertiesContainerView)-25-45, 30, 22)];
    _HTextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_HTextField setFrame:NSMakeRect(NSViewMaxX(_HTextView), NSViewHeight(propertiesContainerView)-25-45, 60, 25)];
    
    _STextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"S"];
    [_STextView setFrame:NSMakeRect(0, NSViewMaxY(_HTextView)-25-30, 30, 22)];
    _STextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_STextField setFrame:NSMakeRect(NSViewMaxX(_STextView), NSViewMaxY(_HTextView)-25-30, 60, 25)];
    
    _BTextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"B"];
    [_BTextView setFrame:NSMakeRect(0, NSViewMaxY(_STextView)-25-30, 30, 22)];
    _BTextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_BTextField setFrame:NSMakeRect(NSViewMaxX(_BTextView), NSViewMaxY(_STextView)-25-30, 60, 25)];
    
    _ATextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"A"];
    [_ATextView setFrame:NSMakeRect(0, NSViewMaxY(_BTextView)-25-30, 30, 22)];
    _ATextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_ATextField setFrame:NSMakeRect(NSViewMaxX(_ATextView), NSViewMaxY(_BTextView)-25-30, 60, 25)];
    
    
    _RTextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"R"];
    [_RTextView setFrame:NSMakeRect(0, NSViewMaxY(_ATextView)-25-50, 30, 22)];
    _RTextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_RTextField setFrame:NSMakeRect(NSViewMaxX(_RTextView), NSViewMaxY(_ATextView)-25-50, 60, 25)];
    
    _GTextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"G"];
    [_GTextView setFrame:NSMakeRect(0, NSViewMaxY(_RTextView)-25-30, 30, 22)];
    _GTextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_GTextField setFrame:NSMakeRect(NSViewMaxX(_GTextView), NSViewMaxY(_RTextView)-25-30, 60, 25)];
    
    _B2TextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"B"];
    [_B2TextView setFrame:NSMakeRect(0, NSViewMaxY(_GTextView)-25-30, 30, 22)];
    _B2TextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_B2TextField setFrame:NSMakeRect(NSViewMaxX(_B2TextView), NSViewMaxY(_GTextView)-25-30, 60, 25)];
    
    _ColorTextView = [self addTextView:propertiesContainerView setFont:MediumSystemFont setString:@"#"];
    [_ColorTextView setFrame:NSMakeRect(0, NSViewMaxY(_B2TextView)-25-30, 30, 22)];
    _ColorTextField = [self addTextField:propertiesContainerView setPlaceHolderString:@""];
    [_ColorTextField setFrame:NSMakeRect(NSViewMaxX(_ColorTextView), NSViewMaxY(_B2TextView)-25-30, 60, 25)];
}
#pragma processing colorPicker value
- (void)setColorPickerValue{
    _curColor.HSBColorVaule.H=_curColor.HSBColorVaule.H<0?0:_curColor.HSBColorVaule.H>360?360:_curColor.HSBColorVaule.H;
    _curColor.HSBColorVaule.S=_curColor.HSBColorVaule.S<0?0:_curColor.HSBColorVaule.S>100?100:_curColor.HSBColorVaule.S;
    _curColor.HSBColorVaule.B=_curColor.HSBColorVaule.B<0?0:_curColor.HSBColorVaule.B>100?100:_curColor.HSBColorVaule.B;
    _curColor.RGBColorVaule.A=_curColor.HSBColorVaule.A=_curColor.HSBColorVaule.A<0?0:_curColor.HSBColorVaule.A>255?255:_curColor.HSBColorVaule.A;
    _curColor.RGBColorVaule.R=_curColor.RGBColorVaule.R<0?0:_curColor.RGBColorVaule.R>255?255:_curColor.RGBColorVaule.R;
    _curColor.RGBColorVaule.G=_curColor.RGBColorVaule.G<0?0:_curColor.RGBColorVaule.G>255?255:_curColor.RGBColorVaule.G;
    _curColor.RGBColorVaule.B=_curColor.RGBColorVaule.B<0?0:_curColor.RGBColorVaule.B>255?255:_curColor.RGBColorVaule.B;
    [_HTextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.HSBColorVaule.H]];
    [_STextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.HSBColorVaule.S]];
    [_BTextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.HSBColorVaule.B]];
    [_ATextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.HSBColorVaule.A]];
    
    [_RTextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.RGBColorVaule.R]];
    [_GTextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.RGBColorVaule.G]];
    [_B2TextField setStringValue:[NSString stringWithFormat:@"%d",_curColor.RGBColorVaule.B]];
    [_ColorTextField setStringValue:_curColor.HEXColorVaule];
    [_selectedColorButton.layer setBackgroundColor:_curColor.NSColor.CGColor];
    
    [_selectedColorImageView setFrameOrigin:NSMakePoint([_viewModel getSelectedCirclePositionByAngle:_centerPoint angle:_curColor.angleValue].x-15 ,[_viewModel getSelectedCirclePositionByAngle:_centerPoint angle:_curColor.angleValue].y-15)];
    
    [_colorPickerSStripView.layer addSublayer:[_viewModel addGradientLayer:CGRectMake(0, 0, NSViewWidth(_colorPickerSStripView), NSViewHeight(_colorPickerSStripView)) startColor:WhiteColor stopColor:[_hueColors objectAtIndex:_curColor.angleValue]]];
    [_selectedSStripColorImageView setFrameOrigin:NSMakePoint(NSViewMinX(_colorPickerSStripView)-5+NSViewWidth(_colorPickerSStripView)*_curColor.SValue, NSViewMinY(_selectedSStripColorImageView))];
    [_colorPickerBStripView.layer addSublayer:[_viewModel addGradientLayer:CGRectMake(0, 0, NSViewWidth(_colorPickerBStripView), NSViewHeight(_colorPickerBStripView)) startColor:[_hueColors objectAtIndex:_curColor.angleValue] stopColor:BlackColor]];
    [_selectedBStripColorImageView setFrameOrigin:NSMakePoint(NSViewMinX(_colorPickerBStripView)-5+NSViewWidth(_colorPickerBStripView)*(1.0-_curColor.BValue), NSViewMinY(_selectedBStripColorImageView))];
    CAGradientLayer *alphaGradientLayer = [_viewModel addGradientLayer:CGRectMake(0, 0, NSViewWidth(_colorPickerAStripView), NSViewHeight(_colorPickerAStripView)) startColor:[_hueColors objectAtIndex:_curColor.angleValue] stopColor:[NSColor colorWithHue:_curColor.HValue saturation:1.0 brightness:1.0 alpha:0.0]];
    [alphaGradientLayer setName:@"alphaGradientLayer"];
    for(CALayer *layer in [_colorPickerAStripView.layer sublayers]){
        if([[layer name] compare:[alphaGradientLayer name]]==NSOrderedSame){
            [layer removeFromSuperlayer];
        }
    }
    [_colorPickerAStripView.layer addSublayer:alphaGradientLayer];
    [_selectedAStripColorImageView setFrameOrigin:NSMakePoint(NSViewMinX(_colorPickerAStripView)-5+NSViewWidth(_colorPickerAStripView)*(1.0-_curColor.AValue), NSViewMinY(_selectedAStripColorImageView))];
}

#pragma mouseDown event
- (void)mouseDown:(NSEvent *)event{
    BOOL moveInCircle = NO;
    BOOL moveInSStrip = NO;
    BOOL moveInBStrip = NO;
    BOOL moveInAStrip = NO;
    while (YES) {
        NSEvent *newEvent = [self.window nextEventMatchingMask:(NSEventMaskLeftMouseDragged | NSEventMaskLeftMouseUp)];
        CGPoint movePoint = newEvent.locationInWindow;
        if(([_viewModel isInCircleRing:_centerPoint movePoint:movePoint outRadius:_circleRadius innerRadius:50]&&(!moveInSStrip&&!moveInBStrip&&!moveInAStrip))||moveInCircle){
            moveInCircle = YES;
            _curColor.angleValue = [_viewModel getSelectedCircleAngle:_centerPoint movePoint:movePoint];
            _curColor.HValue = _curColor.angleValue/360.0;
            _curColor.HSBColorVaule.H = _curColor.angleValue;
            _curColor.NSColor = [NSColor colorWithHue:_curColor.HValue saturation:_curColor.SValue brightness:_curColor.BValue alpha:_curColor.AValue];
            [_curColor updateColorValueWithHSB];
            [self setColorPickerValue];
        }
        if(([_viewModel isInRect:_colorPickerSStripView movePoint:movePoint]&&(!moveInCircle&&!moveInBStrip&&!moveInAStrip))||moveInSStrip){
            moveInSStrip = YES;
            CGFloat value = (movePoint.x-NSViewMinX(_colorPickerSStripView))/NSViewWidth(_colorPickerSStripView);
            value = value<0.0?0.0:value>1.0?1.0:value;
            [_curColor setSValue:value];
            _curColor.HSBColorVaule.S = _curColor.SValue*100;
            _curColor.NSColor = [NSColor colorWithHue:_curColor.HValue saturation:_curColor.SValue brightness:_curColor.BValue alpha:_curColor.AValue];
            [_curColor updateColorValueWithHSB];
            [self setColorPickerValue];
        }
        if(([_viewModel isInRect:_colorPickerBStripView movePoint:movePoint]&&(!moveInCircle&&!moveInSStrip&&!moveInAStrip))||moveInBStrip){
            moveInBStrip = YES;
            CGFloat value = 1.0-(movePoint.x-NSViewMinX(_colorPickerBStripView))/NSViewWidth(_colorPickerBStripView);
            value = value<0.0?0.0:value>1.0?1.0:value;
            [_curColor setBValue:value];
            _curColor.HSBColorVaule.B = _curColor.BValue*100;
            _curColor.NSColor = [NSColor colorWithHue:_curColor.HValue saturation:_curColor.SValue brightness:_curColor.BValue alpha:_curColor.AValue];
            [_curColor updateColorValueWithHSB];
            [self setColorPickerValue];
        }
        if(([_viewModel isInRect:_colorPickerAStripView movePoint:movePoint]&&(!moveInCircle&&!moveInSStrip&&!moveInBStrip))||moveInAStrip){
            moveInAStrip = YES;
            CGFloat value = 1.0-(movePoint.x-NSViewMinX(_colorPickerAStripView))/NSViewWidth(_colorPickerAStripView);
            value = value<0.0?0.0:value>1.0?1.0:value;
            [_curColor setAValue:value];
            _curColor.HSBColorVaule.A = _curColor.AValue*255.0;
            _curColor.NSColor = [NSColor colorWithHue:_curColor.HValue saturation:_curColor.SValue brightness:_curColor.BValue alpha:_curColor.AValue];
            [_curColor updateColorValueWithHSB];
            [self setColorPickerValue];
        }
        if ([newEvent type] == NSEventTypeLeftMouseUp) {
            moveInCircle = moveInSStrip = moveInBStrip = moveInAStrip = NO;
            [self updateTrackingAreas];
            break;
        }
    }
}
#pragma processing textField change event
- (void)controlTextDidChange:(NSNotification *)obj{
    if ([obj object]==_HTextField){
        _curColor.HSBColorVaule.H = [_HTextField.stringValue intValue];
        [_curColor HSBToNSColor];
        [_curColor updateColorValueWithHSB];
    }
    if ([obj object]==_STextField){
        _curColor.HSBColorVaule.S = [_STextField.stringValue intValue];
        [_curColor HSBToNSColor];
        [_curColor updateColorValueWithHSB];
    }
    if ([obj object]==_BTextField){
        _curColor.HSBColorVaule.B = [_BTextField.stringValue intValue];
        [_curColor HSBToNSColor];
        [_curColor updateColorValueWithHSB];
    }
    if ([obj object]==_ATextField){
        _curColor.HSBColorVaule.A = [_ATextField.stringValue intValue];
        _curColor.RGBColorVaule.A = _curColor.HSBColorVaule.A;
        [_curColor HSBToNSColor];
        [_curColor updateColorValue];
    }
    if ([obj object]==_RTextField){
        _curColor.RGBColorVaule.R = [_RTextField.stringValue intValue];
        [_curColor RGBToNSColor];
        [_curColor updateColorValueWithRGB];
    }
    if ([obj object]==_GTextField){
        _curColor.RGBColorVaule.G = [_GTextField.stringValue intValue];
        [_curColor RGBToNSColor];
        [_curColor updateColorValueWithRGB];
    }
    if ([obj object]==_B2TextField){
        _curColor.RGBColorVaule.B = [_B2TextField.stringValue intValue];
        [_curColor RGBToNSColor];
        [_curColor updateColorValueWithRGB];
    }
    if ([obj object]==_ColorTextField){
        _curColor.HEXColorVaule = _ColorTextField.stringValue;
        _curColor.HEXColorVaule = _curColor.HEXColorVaule.length>6?[_curColor.HEXColorVaule substringToIndex:6]:_curColor.HEXColorVaule;
        [_curColor HexToNSColor];
        [_curColor updateColorValueWithHEX];
    }
    [self setColorPickerValue];
}

#pragma tracking area
-(void)updateTrackingAreas
{
    if(_preColorButtonTrackingArea != nil) {
        [self removeTrackingArea:_preColorButtonTrackingArea];
    }
    if(_curColorButtonTrackingArea != nil) {
        [self removeTrackingArea:_curColorButtonTrackingArea];
    }
    _preColorButtonTrackingArea = [self setTrackingArea:_preColorButtonTrackingArea setView:_preSelectedColorButton setTag:CLICK_PRECOLOR_BUTTON_TAG];
    _curColorButtonTrackingArea = [self setTrackingArea:_curColorButtonTrackingArea setView:_selectedColorButton setTag:CLICK_CURCOLOR_BUTTON_TAG];
    [self addTrackingArea:_preColorButtonTrackingArea];
    [self addTrackingArea:_curColorButtonTrackingArea];
    
}
- (void)mouseEntered:(NSEvent *)event{
    int tag = [[event.trackingArea.userInfo valueForKey:@"Tag"] intValue];
    switch(tag){
        case CLICK_CURCOLOR_BUTTON_TAG:
            [_selectedColorButton setShadow:nil];
            break;
        case CLICK_PRECOLOR_BUTTON_TAG:
            [_preSelectedColorButton setShadow:nil];
            break;
    }
}
- (void)mouseExited:(NSEvent *)event{
    int tag = [[event.trackingArea.userInfo valueForKey:@"Tag"] intValue];
    switch(tag){
        case CLICK_CURCOLOR_BUTTON_TAG:
            [_selectedColorButton setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
            break;
        case CLICK_PRECOLOR_BUTTON_TAG:
            [_preSelectedColorButton setShadow:[_viewModel addShadow:5.0 setShadowColor:GrayColor]];
            break;
    }
}
#pragma click button event
- (void)clickButtonEvent:(NSButton *)button {
    switch (button.tag) {
        case CLICK_CURCOLOR_BUTTON_TAG:
            if(_selectedColorHandler){
                _selectedColorHandler(_curColor);
                [self writeDataToUserDefaults];
                [self.window performClose:self];
            }
            break;
        case CLICK_PRECOLOR_BUTTON_TAG:{
            _curColor.NSColor = _preColor.NSColor;
            [_curColor updateColorValue];
            [self setColorPickerValue];
        }
            break;
    }
}

#pragma processing data
- (void)writeDataToUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_curColor];
    [userDefaults setObject:data forKey:@"selectedColor"];
}

- (Color *)readDataFromUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"selectedColor"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
