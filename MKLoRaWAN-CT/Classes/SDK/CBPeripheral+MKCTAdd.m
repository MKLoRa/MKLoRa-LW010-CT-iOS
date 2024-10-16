//
//  CBPeripheral+MKCTAdd.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKCTAdd.h"

#import <objc/runtime.h>

static const char *ct_manufacturerKey = "ct_manufacturerKey";
static const char *ct_seriesNumberKey = "ct_seriesNumberKey";
static const char *ct_deviceModelKey = "ct_deviceModelKey";
static const char *ct_hardwareKey = "ct_hardwareKey";
static const char *ct_softwareKey = "ct_softwareKey";
static const char *ct_firmwareKey = "ct_firmwareKey";

static const char *ct_passwordKey = "ct_passwordKey";
static const char *ct_disconnectTypeKey = "ct_disconnectTypeKey";
static const char *ct_customKey = "ct_customKey";
static const char *ct_logKey = "ct_logKey";

static const char *ct_passwordNotifySuccessKey = "ct_passwordNotifySuccessKey";
static const char *ct_disconnectTypeNotifySuccessKey = "ct_disconnectTypeNotifySuccessKey";
static const char *ct_customNotifySuccessKey = "ct_customNotifySuccessKey";

@implementation CBPeripheral (MKCTAdd)

- (void)ct_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &ct_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A25"]]) {
                objc_setAssociatedObject(self, &ct_seriesNumberKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &ct_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &ct_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &ct_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &ct_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &ct_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &ct_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &ct_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &ct_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)ct_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &ct_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &ct_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &ct_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)ct_connectSuccess {
    if (![objc_getAssociatedObject(self, &ct_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ct_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &ct_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.ct_manufacturer || !self.ct_deviceModel || !self.ct_hardware || !self.ct_software || !self.ct_firmware) {
        return NO;
    }
    if (!self.ct_password || !self.ct_disconnectType || !self.ct_custom || !self.ct_log) {
        return NO;
    }
    return YES;
}

- (void)ct_setNil {
    objc_setAssociatedObject(self, &ct_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_seriesNumberKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ct_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &ct_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &ct_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)ct_manufacturer {
    return objc_getAssociatedObject(self, &ct_manufacturerKey);
}

- (CBCharacteristic *)ct_seriesNumber {
    return objc_getAssociatedObject(self, &ct_seriesNumberKey);
}

- (CBCharacteristic *)ct_deviceModel {
    return objc_getAssociatedObject(self, &ct_deviceModelKey);
}

- (CBCharacteristic *)ct_hardware {
    return objc_getAssociatedObject(self, &ct_hardwareKey);
}

- (CBCharacteristic *)ct_software {
    return objc_getAssociatedObject(self, &ct_softwareKey);
}

- (CBCharacteristic *)ct_firmware {
    return objc_getAssociatedObject(self, &ct_firmwareKey);
}

- (CBCharacteristic *)ct_password {
    return objc_getAssociatedObject(self, &ct_passwordKey);
}

- (CBCharacteristic *)ct_disconnectType {
    return objc_getAssociatedObject(self, &ct_disconnectTypeKey);
}

- (CBCharacteristic *)ct_custom {
    return objc_getAssociatedObject(self, &ct_customKey);
}

- (CBCharacteristic *)ct_log {
    return objc_getAssociatedObject(self, &ct_logKey);
}

@end
