//
//  ColorPicker.h
//  ColorPicker
//
//  Created by Start on 2016/10/31.
//  Copyright © 2016年 Start. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BaseView.h"
#import "ColorPickerViewModel.h"
#import "Color.h"
typedef void (^SelectedColorHandler)(Color *color);
@interface ColorPicker : BaseView
@property (nonatomic, strong) ColorPickerViewModel *viewModel;
@property (nonatomic, strong) Color *curColor;
@property (nonatomic, strong) Color *preColor;
@property (nonatomic, strong) NSMutableArray *hueColors;
@property (nonatomic, copy) SelectedColorHandler selectedColorHandler;
@end
