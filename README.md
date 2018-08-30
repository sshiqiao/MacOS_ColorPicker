# MacOS_ColorPicker
A custom colorPicker that runs on MacOS.

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

![image](https://github.com/sshiqiao/MacOS_ColorPicker/blob/master/ColorPicker/demo_colorpicker.gif)
