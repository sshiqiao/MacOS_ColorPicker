//
//  ColorPickerWindowController.h
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommonMacro.h"
#import "Color.h"
typedef void (^SelectedColorHandler)(Color *color);
@interface ColorPickerWindowController : NSWindowController
@property (nonatomic, copy) SelectedColorHandler selectedColorHandler;
@end
