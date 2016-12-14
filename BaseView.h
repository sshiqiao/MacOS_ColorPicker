//
//  BaseView.h
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommonMacro.h"
@interface BaseView : NSView

- (NSButton *)addButton:(NSView *)container setTitle:(NSString *)title setTag:(NSInteger)tag;

- (NSTextField *)addTextField:(NSView *)container setPlaceHolderString:(NSString *)placeHolderString;

- (NSTextView *)addTextView:(NSView *)container setFont:(NSFont *)font setString:(NSString *)string;

- (NSTrackingArea *)setTrackingArea:(NSTrackingArea *)trackingArea setView:(NSView *)view setTag:(NSInteger)tag;

@end
