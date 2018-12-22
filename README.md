# RateKit
[![Travis](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/HsiangHo/RateKit)
[![Jenkins](https://img.shields.io/badge/license-GPL3-red.svg)](https://github.com/HsiangHo/RateKit/blob/master/LICENSE)
[![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/HsiangHo/RateKit/issues)
[![Platform](https://img.shields.io/badge/platform-macOS-yellow.svg)]()
[![Language](https://img.shields.io/badge/Language-Objective--C%20%7C%20Swift-yellowgreen.svg)]()  

RateKit is a easy way for developers to request ratings and reviews for macOS.  
[中文版](https://github.com/HsiangHo/RateKit/blob/master/README_zh.md)  

![](https://github.com/HsiangHo/RateKit/blob/master/doc/gif.gif?raw=true "Optional Title")

## Installation
Clone the rep, build the RateKit or copy all the source files into your project.
  
## Features
- [x] Customization and Configuration to your needs
- [x] Awesome UI to request users to rate app in Mac App Store
- [x] Display rate window with animations

## Example

To run the example project, clone the repo, build and run the target 'RateKitDemo'.

## Getting started  
- Create rate window configuration
```

    RateConfigure *configure = [[RateConfigure alloc] init];
    [configure setName:@"Love Ratekit?"];
    [configure setIcon:[NSImage imageNamed:@"demo-icon"]];
    [configure setDetailText:@"We look forward to your Star and Pull Request to make Ratekit better and better : )\n⭐️⭐️⭐️⭐️⭐️"];
    [configure setLikeButtonTitle:@"Star Now!"];
    [configure setIgnoreButtonTitle:@"Maybe later"];
    [configure setRateURL:[NSURL URLWithString:@"https://github.com/HsiangHo/RateKit"]];
    
```

- Make a rate window and request users to rate app.
```
    RateWindowController *rateWindowController = [[RateWindowController alloc] initWithConfigure:configure];
    //Set a timeout for rate window to close itself automatically.
    [rateWindowController setRateTimeout:10];
    //Request rate window
    [rateWindowController requestRateWindow:RateWindowPositionTopRight withRateCompletionCallback:^(RateResult rlst) {
        switch (rlst) {
            case RateResultRated:
                // User clicked 'Rate' button
                break;
                
            case RateResultLater:
                // User clicked 'Later' button
                break;
                
            case RateResultTimeout:
                // User did nothing
                break;
                
            default:
                break;
        }
    }];
```

## Requirements
macOS 10.10 and above  
Xcode 8.0+

## Contributing
Contributions are very welcome 🙌 🤓

## Screenshots

![](https://github.com/HsiangHo/RateKit/blob/master/doc/RateKit.png?raw=true "Optional Title")
