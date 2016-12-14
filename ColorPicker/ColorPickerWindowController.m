//
//  ColorPickerWindowController.m
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import "ColorPickerWindowController.h"
#import "ColorPicker.h"
@interface ColorPickerWindowController (){
    CGFloat      _currentWindowWidth;
    CGFloat      _currentWindowHeight;
}
@end

@implementation ColorPickerWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    _currentWindowWidth = 350;
    _currentWindowHeight = 350;
    [self.window setFrame:NSMakeRect(SCREEN_WIDTH/2-_currentWindowWidth/2, SCREENH_HEIGHT/2-_currentWindowHeight/2, _currentWindowWidth, _currentWindowHeight) display:YES];
    [self.window setTitle:@""];
    ColorPicker *colorPicker = [[ColorPicker alloc]initWithFrame:NSMakeRect(0, 0, NSViewWidth(self.window), NSViewHeight(self.window))];
    colorPicker.selectedColorHandler = ^(Color *color){
        if(self.selectedColorHandler){
            self.selectedColorHandler(color);
        }
    };
    [self.window setContentView:colorPicker];
}
- (void)windowWillClose:(NSNotification *)notification {
    [NSApp stopModalWithCode:0];
}

@end
