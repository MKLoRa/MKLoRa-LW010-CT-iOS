//
//  Target_LoRaWANCT_Module.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANCT_Module.h"

#import "MKCTScanController.h"

#import "MKCTAboutController.h"

@implementation Target_LoRaWANCT_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANCT_Module_ScanController:(NSDictionary *)params {
    return [[MKCTScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANCT_Module_AboutController:(NSDictionary *)params {
    return [[MKCTAboutController alloc] init];
}

@end
