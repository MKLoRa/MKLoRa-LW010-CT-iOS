//
//  CBPeripheral+MKCTAdd.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKCTAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_seriesNumber;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *ct_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ct_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ct_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *ct_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *ct_log;

- (void)ct_updateCharacterWithService:(CBService *)service;

- (void)ct_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)ct_connectSuccess;

- (void)ct_setNil;

@end

NS_ASSUME_NONNULL_END
