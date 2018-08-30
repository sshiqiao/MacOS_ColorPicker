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
        NSLog(@"Hex Value:#%@",color.HEXColorVaule);
        NSLog(@"H Value:%d",color.HSBColorVaule.H);
        NSLog(@"S Value:%d",color.HSBColorVaule.S);
        NSLog(@"B Value:%d",color.HSBColorVaule.B);
        NSLog(@"R Value:%d",color.RGBColorVaule.R);
        NSLog(@"G Value:%d",color.RGBColorVaule.G);
        NSLog(@"B Value:%d",color.RGBColorVaule.B);
        NSLog(@"A Value:%f",color.AValue);
    };
    [NSApp runModalForWindow:[colorPickerWindow window]];
}

@end
