//
//  MXHomeQRCodeVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>

@interface MXHomeQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) UIImageView *scannerView;

@end

@implementation MXHomeQRCodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initScanner];
    [self initUI];
}

- (void)initScanner
{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [self.session startRunning];
}

- (void)initUI
{
    UIImageView *scannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
    scannerView.image = [UIImage imageNamed:@"home_scanner"];
    scannerView.centerX = self.view.centerX;
    scannerView.centerY = self.view.centerY - 64;
    self.scannerView = scannerView;
    [self.view addSubview:scannerView];
}

#pragma mark - delegete
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
    }
}
@end
