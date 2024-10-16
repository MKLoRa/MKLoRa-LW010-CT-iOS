//
//  MKCTIndicatorSettingsModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTIndicatorSettingsModel : NSObject<mk_ct_indicatorSettingsProtocol>

@property (nonatomic, assign)BOOL DeviceState;
@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL Charging;
@property (nonatomic, assign)BOOL FullCharge;
@property (nonatomic, assign)BOOL Broadcast;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL InFix;
@property (nonatomic, assign)BOOL FixSuccessful;
@property (nonatomic, assign)BOOL FailToFix;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
