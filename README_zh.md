# RateKit
[![Travis](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/HsiangHo/RateKit)
[![Jenkins](https://img.shields.io/badge/license-GPL3-red.svg)](https://github.com/HsiangHo/RateKit/blob/master/LICENSE)
[![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/HsiangHo/RateKit/issues)
[![Platform](https://img.shields.io/badge/platform-macOS-yellow.svg)]()
[![Language](https://img.shields.io/badge/Language-Objective--C%20%7C%20Swift-yellowgreen.svg)]()  

RateKit 是一个方便开发者请求用户评分和评论的组件
[中文版](https://github.com/HsiangHo/RateKit/blob/master/README_zh.md)  

![](https://github.com/HsiangHo/RateKit/blob/master/doc/gif.gif?raw=true "Optional Title")

## 如何安装
克隆仓库到本地，将RateKit工程加入到你的项目。
  
## 功能
- [x] 根据你的需要进行自定义
- [x] 非常好看的UI来请求用户进行评论和评分
- [x] 动画显示请求评分窗口

## 栗子

在工程文件里，编译执行'RateKitDemo'这个目标程序，方可见demo.

## 如何使用
- 如何创建评分窗口的配置
```

    RateConfigure *configure = [[RateConfigure alloc] init];
    [configure setName:@"Love Ratekit?"];
    [configure setIcon:[NSImage imageNamed:@"demo-icon"]];
    [configure setDetailText:@"We look forward to your Star and Pull Request to make Ratekit better and better : )\n⭐️⭐️⭐️⭐️⭐️"];
    [configure setLikeButtonTitle:@"Star Now!"];
    [configure setIgnoreButtonTitle:@"Maybe later"];
    [configure setRateURL:[NSURL URLWithString:@"https://github.com/HsiangHo/RateKit"]];
    
```

- 如何创建评分窗口并请求用户评分
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

## 使用环境
macOS 10.10 and above  
Xcode 8.0+

## 如何贡献
任何问题欢迎issue, PRs 🙌 🤓

## 屏幕截图

![](https://github.com/HsiangHo/RateKit/blob/master/doc/RateKit.png?raw=true "Optional Title")
