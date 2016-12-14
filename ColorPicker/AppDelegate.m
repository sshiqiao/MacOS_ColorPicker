//
//  AppDelegate.m
//  ColorPicker
//
//  Created by Start on 2016/10/30.
//  Copyright © 2016年 Start. All rights reserved.
//

#import "AppDelegate.h"
#import "ColorPickerWindowController.h"
#import "Color.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    ColorPickerWindowController *colorPickerWindow = [[ColorPickerWindowController alloc] initWithWindowNibName:@"ColorPickerWindowController"];
    colorPickerWindow.selectedColorHandler = ^(Color *color){
        NSLog(@"SelectedColor:#%@",color.HEXColorVaule);
    };
    [NSApp runModalForWindow:[colorPickerWindow window]];
}

@end
