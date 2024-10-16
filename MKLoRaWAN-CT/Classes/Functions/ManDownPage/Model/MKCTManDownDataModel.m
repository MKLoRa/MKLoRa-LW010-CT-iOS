//
//  MKCTManDownDataModel.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCTManDownDataModel.h"

#import "MKMacroDefines.h"

#import "MKCTInterface.h"
#import "MKCTInterface+MKCTConfig.h"

@interface MKCTManDownDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCTManDownDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readManDownDetection]) {
            [self operationFailedBlockWithMsg:@"Read Man Down Detection Error" block:failedBlock];
            return;
        }
        if (![self readStrategy]) {
            [self operationFailedBlockWithMsg:@"Read Man Down Strategy Error" block:failedBlock];
            return;
        }
        if (![self readDetectionTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Man Down Detection Timeout Error" block:failedBlock];
            return;
        }
        if (![self readDetectionReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Man Down Detection Report Interval Error" block:failedBlock];
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
        if (![self checkParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configManDownDetection]) {
            [self operationFailedBlockWithMsg:@"Config Man Down Detection Error" block:failedBlock];
            return;
        }
        if (![self configStrategy]) {
            [self operationFailedBlockWithMsg:@"Config Man Down Strategy Error" block:failedBlock];
            return;
        }
        if (![self configDetectionTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Man Down Detection Timeout Error" block:failedBlock];
            return;
        }
        if (![self configDetectionReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Man Down Detection Report Interval Error" block:failedBlock];
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
- (BOOL)readManDownDetection {
    __block BOOL success = NO;
    [MKCTInterface ct_readManDownDetectionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.startIsOn = [returnData[@"result"][@"notifyEventOnManDownStart"] boolValue];
        self.endIsOn = [returnData[@"result"][@"notifyEventOnManDownEnd"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configManDownDetection {
    __block BOOL success = NO;
    [MKCTInterface ct_configManDownDetectionStatus:self.isOn notifyEventOnManDownStart:self.startIsOn notifyEventOnManDownEnd:self.endIsOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readStrategy {
    __block BOOL success = NO;
    [MKCTInterface ct_readManDownDetectionStrategyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.strategy = [returnData[@"result"][@"strategy"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configStrategy {
    __block BOOL success = NO;
    [MKCTInterface ct_configManDownPositioningStrategy:self.strategy sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDetectionTimeout {
    __block BOOL success = NO;
    [MKCTInterface ct_readManDownDetectionTimeoutWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeout = returnData[@"result"][@"timeout"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDetectionTimeout {
    __block BOOL success = NO;
    [MKCTInterface ct_configManDownDetectionTimeout:[self.timeout integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDetectionReportInterval {
    __block BOOL success = NO;
    [MKCTInterface ct_readManDownDetectionReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDetectionReportInterval {
    __block BOOL success = NO;
    [MKCTInterface ct_configManDownDetectionReportInterval:[self.interval integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"manDownParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)checkParams {
    if (!ValidStr(self.timeout) || [self.timeout integerValue] < 1 || [self.timeout integerValue] > 120) {
        return NO;
    }
    if (!ValidStr(self.interval) || [self.interval integerValue] < 10 || [self.interval integerValue] > 600) {
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
        _readQueue = dispatch_queue_create("manDownQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
