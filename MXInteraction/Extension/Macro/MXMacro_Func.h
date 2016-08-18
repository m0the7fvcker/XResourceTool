//
//  MXMacro_Func.h
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#ifndef MXMacro_Func_h
#define MXMacro_Func_h

/// NSLog，relase状态就不打印
#ifndef __OPTIMIZE__
#define NSLog(fmt,...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

// weakSelf
#define MXWeakSelf __weak typeof(self) weakSelf = self

// 得到AppDelegate实例
#define MXAppDelegateAccessor ((YBFAppDelegate *)[[UIApplication sharedApplication] delegate])

// 操作系统版本判断
#define MX_OSV_LaterIOS7 MX_OSVLater(7.0)
#define MX_OSV_LaterIOS8 MX_OSVLater(8.0)
#define MX_OSV_LaterIOS9 MX_OSVLater(9.0)
#define MX_OSVLater(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)

// 设备尺寸
#define MXScreen_Bounds [UIScreen mainScreen].bounds
#define MXScreen_Height [UIScreen mainScreen].bounds.size.height
#define MXScreen_Width [UIScreen mainScreen].bounds.size.width

#define GET_STATE_BAR_HEIGHT (MXDevice_Is_iPhone6P ? 20:(MX_OSV_LaterIOS7 ? 20 : 0))
#define GET_NAV_BAR_HEIGHT (MXDevice_Is_iPhone6P ? 44:44)
#define MX_NAV_HEIGHT 64

#define MXDevice_Is_iPhone4 (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
#define MXDevice_Is_iPhone5 (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
#define MXDevice_Is_iPhone6 (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
#define MXDevice_Is_iPhone6P (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))

// 状态栏高度
#define MXStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

// 字体颜色
#define MXColor(hexString) [UIColor mx_colorWithHexString:hexString]
#define MXFont(size) [UIFont systemFontOfSize:size]
#define MXFontName(name,size) [UIFont fontWithName:name size:size]

// 调用主线程同步
#define MX_Dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

// 调用主线程异步
#define MX_Dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

// 国际化
#define MXLocalized(x) [MXLanguage stringWithKey:@#x]

#endif /* MXMacro_Func_h */
