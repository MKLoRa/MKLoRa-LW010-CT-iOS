//
//  MKCTPositionPageModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/12/7.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTPositionPageModel : NSObject

@property (nonatomic, assign)BOOL gpsExtremeMode;

@property (nonatomic, assign)BOOL bleFix;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configGpsLimitUploadStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configBeaconVoltageStatus:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
