//
//  MXAuthorizationVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAuthorizationVC.h"

@interface MXAuthorizationVC ()

@property (nonatomic, weak) UIImageView *codeView;
@end

@implementation MXAuthorizationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.title = @"授权管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 30)];
    headerLabel.text = @"二维码一旦使用或者10小时候自动失效";
    headerLabel.backgroundColor = [UIColor mx_colorWithHexString:@"ECECEC"];
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headerLabel];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, MXScreen_Width, MXScreen_Height - 30)];
    [self.view addSubview:containerView];
    
    UIImageView *codeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 150, 150)];
    codeView.centerX = self.view.centerX;
    codeView.image = [self getQRImageWithSize:CGSizeMake(150, 150)];
    self.codeView = codeView;
    [containerView addSubview:codeView];
    
    UILabel *bottomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, MXScreen_Width, 20)];
    bottomeLabel.textAlignment = NSTextAlignmentCenter;
    bottomeLabel.font = [UIFont systemFontOfSize:13];
    bottomeLabel.text = @"手机登录APP，给予授权权限";
    [containerView addSubview:bottomeLabel];
}

- (UIImage *)getQRImageWithSize:(CGSize)size
{
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    
    // 3.将字符串转换成NSdata
    NSData *data  = [[MXComUserDefault getUserQRCode] dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 6.处理二维码图片使变清晰
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
