//
//  MKCTTempMonitorSettingsModel.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCTTempMonitorSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCTInterface.h"
#import "MKCTInterface+MKCTConfig.h"

@interface MKCTTempMonitorSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCTTempMonitorSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readMonitorStatus]) {
            [self operationFailedBlockWithMsg:@"Read Temperatureing Monitor Status Error" block:failedBlock];
            return;
        }
        if (![self readSampleRate]) {
            [self operationFailedBlockWithMsg:@"Read Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self readTemperatureThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Temperature Threshold Error" block:failedBlock];
            return;
        }
        if (![self readTemperature]) {
            [self operationFailedBlockWithMsg:@"Read Temperature Error" block:failedBlock];
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
            [self operationFailedBlockWithMsg:@"Config Temperatureing Monitor Status Error" block:failedBlock];
            return;
        }
        if (![self configSampleRate]) {
            [self operationFailedBlockWithMsg:@"Config Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self configTemperatureThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Temperature Threshold Error" block:failedBlock];
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
    [MKCTInterface ct_readTemperatureMonitorNotifyStatusWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKCTInterface ct_configTemperatureMonitorNotifyStatus:self.isOn alarmSwicth:self.alarmSwitch sucBlock:^{
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
    [MKCTInterface ct_readTemperatureDataSampleRateIntervalWithSucBlock:^(id  _Nonnull returnData) {
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
    [MKCTInterface ct_configTemperatureDataSampleRateInterval:[self.sampleRate integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTemperatureThreshold {
    __block BOOL success = NO;
    [MKCTInterface ct_readTemperatureThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.maxThreshold = returnData[@"result"][@"max"];
        self.minThreshold = returnData[@"result"][@"min"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTemperatureThreshold {
    __block BOOL success = NO;
    [MKCTInterface ct_configTemperatureThreshold:[self.maxThreshold integerValue] min:[self.minThreshold integerValue]  sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTemperature {
    __block BOOL success = NO;
    [MKCTInterface ct_readTemperatureWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.temperature = returnData[@"result"][@"temperature"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"TempMonitorSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.sampleRate) || [self.sampleRate integerValue] < 1 || [self.sampleRate integerValue] > 3600) {
        return NO;
    }
    if (!ValidStr(self.maxThreshold) || [self.maxThreshold integerValue] < -20 || [self.maxThreshold integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.minThreshold) || [self.minThreshold integerValue] < -20 || [self.minThreshold integerValue] > 60) {
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
        _readQueue = dispatch_queue_create("TempMonitorSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
