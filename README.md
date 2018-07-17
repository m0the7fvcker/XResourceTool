# XResourceTools

[![CI Status](https://img.shields.io/travis/Poly.ma/XResourceTools.svg?style=flat)](https://travis-ci.org/Poly.ma/XResourceTools)
[![Version](https://img.shields.io/cocoapods/v/XResourceTools.svg?style=flat)](https://cocoapods.org/pods/XResourceTools)
[![License](https://img.shields.io/cocoapods/l/XResourceTools.svg?style=flat)](https://cocoapods.org/pods/XResourceTools)
[![Platform](https://img.shields.io/cocoapods/p/XResourceTools.svg?style=flat)](https://cocoapods.org/pods/XResourceTools)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XResourceTools is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XResourceTools'
```
## 使用方法

初始化时选择对应的bundle，当前framework使用当前类所在的bundle，主bundle使用mainbundle

OC:
```objective-c
@import XResourceTools;

@interface XBaseImageManager: YSImageManager

+ (instancetype)shared;

@end

@implementation XBaseImageManager

static id instance = nil;
+ (instancetype)mgr {
    if (!instance) {
        instance = [[XBaseImageManager alloc] initWithBundle:[NSBundle bundleForClass:self.class]];
    }
    return instance;
}

@end
```

```swift
import XResourceTool

class BundleClass: NSObject {

}

class BaseImageTool: YSImageManager {

    static let sharedManager: BaseImageTool = BaseImageTool()
    private override init() {
    let bundle = Bundle(for: BundleClass.init().classForCoder)
        super.init(bundle: bundle)
}

public override func imageNamed(_ imageName: String!) -> UIImage! {
    return super.imageNamed(imageName)
    }
}
```

## Author

ge3kxm@gmail.com

## License

XResourceTools is available under the MIT license. See the LICENSE file for more info.
