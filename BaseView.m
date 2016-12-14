//
//  BaseView.m
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (NSButton *)addButton:(NSView *)container setTitle:(NSString *)title setTag:(NSInteger)tag {
    NSButton *button = [[NSButton alloc]init];
    [button setTag:tag];
    [button setBordered:NO];
    [button setWantsLayer:YES];
    [button.layer setBackgroundColor:ThemeColor.CGColor];
    [button.layer setCornerRadius:5.0];
    [button.layer setBorderWidth:0.5];
    [button.layer setBorderColor:ThemeDarkColor.CGColor];
    [button setTitle:title];
    [button setTarget:self];
    [container addSubview:button];
    return button;
}

- (NSTextField *)addTextField:(NSView *)container setPlaceHolderString:(NSString *)placeHolderString {
    NSTextField *textField = [[NSTextField alloc]init];
    [textField setWantsLayer:YES];
    [textField.layer setBorderWidth:1];
    [textField.layer setBorderColor:LightLightGrayColor.CGColor];
    [textField setMaximumNumberOfLines:1];
    [textField setPlaceholderString:placeHolderString];
    [textField setFont:MediumSystemFont];
    [container addSubview:textField];
    return textField;
}

- (NSTextView *)addTextView:(NSView *)container setFont:(NSFont *)font setString:(NSString *)string {
    NSTextView *textView = [[NSTextView alloc]init];
    [textView setBackgroundColor:ClearColor];
    [textView alignLeft:self];
    [textView setEditable:NO];
    [textView setAllowsUndo:NO];
    [textView setFont:font];
    [textView alignCenter:self];
    [textView setString:string];
    [container addSubview:textView];
    return textView;
}

- (NSTrackingArea *)setTrackingArea:(NSTrackingArea *)trackingArea setView:(NSView *)view setTag:(NSInteger)tag{
    trackingArea = [[NSTrackingArea alloc]initWithRect:[view frame] options:NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways
                                                 owner:self userInfo:@{@"Tag":@(tag)}];
    return trackingArea;
}

@end
