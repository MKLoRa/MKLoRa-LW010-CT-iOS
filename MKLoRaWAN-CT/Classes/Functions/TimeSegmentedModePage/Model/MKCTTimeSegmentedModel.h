//
//  MKCTTimeSegmentedModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/11/21.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTTimeSegmentedTimePeriodModel : NSObject<mk_ct_timeSegmentedModeTimePeriodSettingProtocol>

/// 0~23
@property (nonatomic, assign)NSInteger startHour;

/// 0-59
@property (nonatomic, assign)NSInteger startMinuteGear;

/// 0~23
@property (nonatomic, assign)NSInteger endHour;

/// 0-59
@property (nonatomic, assign)NSInteger endMinuteGear;

/// Report Interval   30s - 86400s
@property (nonatomic, assign)NSInteger interval;

@end

@interface MKCTTimeSegmentedModel : NSObject

/*
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 4:BLE&GPS
 */
@property (nonatomic, assign)NSInteger strategy;

@property (nonatomic, strong)NSArray <MKCTTimeSegmentedTimePeriodModel *>*pointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configData:(NSArray <MKCTTimeSegmentedTimePeriodModel *>*)pointList
          sucBlock:(void (^)(void))sucBlock
       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
