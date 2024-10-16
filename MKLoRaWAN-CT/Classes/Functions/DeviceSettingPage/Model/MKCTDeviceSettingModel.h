//
//  MKCTDeviceSettingModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTDeviceSettingModel : NSObject

/// 0: No 1:Alarm 2:Normal
@property (nonatomic, assign)NSInteger buzzer;

@property (nonatomic, assign)NSInteger timeZone;

@property (nonatomic, assign)BOOL lowPowerPayload;

/// 0:10%  1:20% 2:30% 3:40% 4:50% 5:60%
@property (nonatomic, assign)NSInteger prompt;

@property (nonatomic, copy)NSString *interval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
