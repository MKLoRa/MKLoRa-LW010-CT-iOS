//
//  MKCTLightMonitorSettingsModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/14.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTLightMonitorSettingsModel : NSObject


@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *sampleRate;

@property (nonatomic, copy)NSString *intensity;

@property (nonatomic, assign)BOOL alarmSwitch;

@property (nonatomic, copy)NSString *lightThreshold;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
