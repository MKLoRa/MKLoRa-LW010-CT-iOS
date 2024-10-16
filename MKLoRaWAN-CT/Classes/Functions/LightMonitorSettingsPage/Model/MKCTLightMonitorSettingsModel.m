//
//  MKCTLightMonitorSettingsModel.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCTLightMonitorSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCTInterface.h"
#import "MKCTInterface+MKCTConfig.h"

@interface MKCTLightMonitorSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCTLightMonitorSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMonitorStatus]) {
            [self operationFailedBlockWithMsg:@"Read Lighting Monitor Status Error" block:failedBlock];
            return;
        }
        if (![self readSampleRate]) {
            [self operationFailedBlockWithMsg:@"Read Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self readLightThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Light Threshold Error" block:failedBlock];
            return;
        }
        if (![self readLightIntensity]) {
            [self operationFailedBlockWithMsg:@"Read illumination intensity Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configMonitorStatus]) {
            [self operationFailedBlockWithMsg:@"Config Lighting Monitor Status Error" block:failedBlock];
            return;
        }
        if (![self configSampleRate]) {
            [self operationFailedBlockWithMsg:@"Config Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self configLightThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Light Threshold Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface

- (BOOL)readMonitorStatus {
    __block BOOL success = NO;
    [MKCTInterface ct_readLightMonitorNotifyStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.alarmSwitch = [returnData[@"result"][@"alarmSwicth"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMonitorStatus {
    __block BOOL success = NO;
    [MKCTInterface ct_configLightMonitorNotifyStatus:self.isOn alarmSwicth:self.alarmSwitch sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSampleRate {
    __block BOOL success = NO;
    [MKCTInterface ct_readLightDataSampleRateIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleRate = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSampleRate {
    __block BOOL success = NO;
    [MKCTInterface ct_configLightDataSampleRateInterval:[self.sampleRate integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLightThreshold {
    __block BOOL success = NO;
    [MKCTInterface ct_readLightThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.lightThreshold = returnData[@"result"][@"threshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configLightThreshold {
    __block BOOL success = NO;
    [MKCTInterface ct_configLightThreshold:[self.lightThreshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readLightIntensity {
    __block BOOL success = NO;
    [MKCTInterface ct_readLightIlluminationIntensityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.intensity = returnData[@"result"][@"intensity"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"LightMonitorSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.sampleRate) || [self.sampleRate integerValue] < 1 || [self.sampleRate integerValue] > 3600) {
        return NO;
    }
    if (!ValidStr(self.lightThreshold) || [self.lightThreshold integerValue] < 10 || [self.lightThreshold integerValue] > 300) {
        return NO;
    }
    
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("LightMonitorSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
