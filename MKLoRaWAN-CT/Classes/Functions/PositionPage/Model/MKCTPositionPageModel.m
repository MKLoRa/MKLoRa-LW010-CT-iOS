//
//  MKCTPositionPageModel.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/12/7.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCTPositionPageModel.h"

#import "MKMacroDefines.h"

#import "MKCTInterface.h"
#import "MKCTInterface+MKCTConfig.h"

@interface MKCTPositionPageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCTPositionPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readGpsLimitUploadStatus]) {
            [self operationFailedBlockWithMsg:@"Read Gps Limit Upload Status Error" block:failedBlock];
            return;
        }
        if (![self readBluetoothFix]) {
            [self operationFailedBlockWithMsg:@"Read Beacon Voltage Report in Bluetooth Fix Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configGpsLimitUploadStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configGpsLimitUploadStatus:isOn]) {
            [self operationFailedBlockWithMsg:@"Config Gps Limit Upload Status Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configBeaconVoltageStatus:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configBluetoothFix:isOn]) {
            [self operationFailedBlockWithMsg:@"Config Beacon Voltage Report in Bluetooth Fix Error" block:failedBlock];
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

- (BOOL)readGpsLimitUploadStatus {
    __block BOOL success = NO;
    [MKCTInterface ct_readGpsLimitUploadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.gpsExtremeMode = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configGpsLimitUploadStatus:(BOOL)isOn {
    __block BOOL success = NO;
    [MKCTInterface ct_configGpsLimitUploadStatus:isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readBluetoothFix {
    __block BOOL success = NO;
    [MKCTInterface ct_readBeaconVoltageReportInBleFixWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.bleFix = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configBluetoothFix:(BOOL)isOn {
    __block BOOL success = NO;
    [MKCTInterface ct_configBeaconVoltageReportInBleFixStatus:isOn sucBlock:^{
        success = YES;
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
        NSError *error = [[NSError alloc] initWithDomain:@"PositioningStrategy"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
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
        _readQueue = dispatch_queue_create("PositioningStrategyQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
