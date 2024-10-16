//
//  MKCTIndicatorSettingsModel.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCTIndicatorSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKCTInterface.h"
#import "MKCTInterface+MKCTConfig.h"

@interface MKCTIndicatorSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCTIndicatorSettingsModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readIndicatorSettings]) {
            [self operationFailedBlockWithMsg:@"Read Indicator Settings Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configIndicatorSettings]) {
            [self operationFailedBlockWithMsg:@"Config Indicator Settings Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)readIndicatorSettings {
    __block BOOL success = NO;
    [MKCTInterface ct_readIndicatorSettingsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.DeviceState = [returnData[@"result"][@"indicatorSettings"][@"deviceState"] boolValue];
        self.LowPower = [returnData[@"result"][@"indicatorSettings"][@"lowPower"] boolValue];
        self.Charging = [returnData[@"result"][@"indicatorSettings"][@"charging"] boolValue];
        self.FullCharge = [returnData[@"result"][@"indicatorSettings"][@"fullCharge"] boolValue];
        self.NetworkCheck = [returnData[@"result"][@"indicatorSettings"][@"networkCheck"] boolValue];
        self.InFix = [returnData[@"result"][@"indicatorSettings"][@"inFix"] boolValue];
        self.FixSuccessful = [returnData[@"result"][@"indicatorSettings"][@"fixSuccessful"] boolValue];
        self.FailToFix = [returnData[@"result"][@"indicatorSettings"][@"failToFix"] boolValue];
        self.Broadcast = [returnData[@"result"][@"indicatorSettings"][@"broadcast"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configIndicatorSettings {
    __block BOOL success = NO;
    [MKCTInterface ct_configIndicatorSettings:self sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"indicatorSettingsParams"
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
        _readQueue = dispatch_queue_create("indicatorSettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
