//
//  MKCTInterface.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTInterface.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKCTCentralManager.h"
#import "MKCTOperationID.h"
#import "MKCTOperation.h"
#import "CBPeripheral+MKCTAdd.h"
#import "MKCTSDKDataAdopter.h"

#define centralManager [MKCTCentralManager shared]
#define peripheral ([MKCTCentralManager shared].peripheral)

@implementation MKCTInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)ct_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ct_taskReadDeviceModelOperation
                           characteristic:peripheral.ct_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ct_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ct_taskReadFirmwareOperation
                           characteristic:peripheral.ct_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ct_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ct_taskReadHardwareOperation
                           characteristic:peripheral.ct_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ct_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ct_taskReadSoftwareOperation
                           characteristic:peripheral.ct_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)ct_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_ct_taskReadManufacturerOperation
                           characteristic:peripheral.ct_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************System************************************************
+ (void)ct_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMacAddressOperation
                     cmdFlag:@"0015"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTimeZoneOperation
                     cmdFlag:@"0021"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"0022"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadIndicatorSettingsOperation
                     cmdFlag:@"0023"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readHallPowerOffStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadHallPowerOffStatusOperation
                     cmdFlag:@"0025"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShutdownPayloadStatusOperation
                     cmdFlag:@"0026"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBuzzerSoundTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBuzzerSoundTypeOperation
                     cmdFlag:@"0027"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadThreeAxisWakeupConditionsOperation
                     cmdFlag:@"0028"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadThreeAxisMotionParametersOperation
                     cmdFlag:@"0029"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBatteryVoltageOperation
                     cmdFlag:@"0040"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPCBAStatusOperation
                     cmdFlag:@"0041"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadSelftestStatusOperation
                     cmdFlag:@"0042"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTemperatureWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTemperatureOperation
                     cmdFlag:@"0043"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLightIlluminationIntensityWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLightIlluminationIntensityOperation
                     cmdFlag:@"0044"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ***************************************电池相关参数************************************************
+ (void)ct_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAllCycleBatteryInformationOperation
                     cmdFlag:@"0103"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLowPowerPromptOperation
                     cmdFlag:@"0104"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"0106"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLowPowerPayloadIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLowPowerPayloadIntervalOperation
                     cmdFlag:@"0107"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAutoPowerOnAfterChargingWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAutoPowerOnAfterChargingOperation
                     cmdFlag:@"0108"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙相关参数************************************************
+ (void)ct_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"0200"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPasswordOperation
                     cmdFlag:@"0201"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"0202"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBeaconStatusOperation
                     cmdFlag:@"0203"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAdvIntervalOperation
                     cmdFlag:@"0204"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTxPowerOperation
                     cmdFlag:@"0205"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadDeviceNameOperation
                     cmdFlag:@"0206"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************模式相关参数************************************************
+ (void)ct_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadWorkModeOperation
                     cmdFlag:@"0300"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readStandbyModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadStandbyModePositioningStrategyOperation
                     cmdFlag:@"0310"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPeriodicModePositioningStrategyOperation
                     cmdFlag:@"0320"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPeriodicModeReportIntervalOperation
                     cmdFlag:@"0321"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTimingModePositioningStrategyOperation
                     cmdFlag:@"0330"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTimingModeReportingTimePointOperation
                     cmdFlag:@"0331"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsNotifyEventOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsNotifyEventOnStartOperation
                     cmdFlag:@"0340"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsFixOnStartOperation
                     cmdFlag:@"0341"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModePosStrategyOnStartOperation
                     cmdFlag:@"0342"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeNumberOfFixOnStartOperation
                     cmdFlag:@"0343"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsNotifyEventInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsNotifyEventInTripOperation
                     cmdFlag:@"0350"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsFixInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsFixInTripOperation
                     cmdFlag:@"0351"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModePosStrategyInTripOperation
                     cmdFlag:@"0352"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeReportIntervalInTripOperation
                     cmdFlag:@"0353"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsNotifyEventOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsNotifyEventOnEndOperation
                     cmdFlag:@"0360"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsFixOnEndOperation
                     cmdFlag:@"0361"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModePosStrategyOnEndOperation
                     cmdFlag:@"0362"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeReportIntervalOnEndOperation
                     cmdFlag:@"0363"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeNumberOfFixOnEndOperation
                     cmdFlag:@"0364"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeTripEndTimeoutOperation
                     cmdFlag:@"0365"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readMotionModeEventsFixOnStationaryStateWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadMotionModeEventsFixOnStationaryStateOperation
                     cmdFlag:@"0370"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPosStrategyOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPosStrategyOnStationaryOperation
                     cmdFlag:@"0371"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readReportIntervalOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadReportIntervalOnStationaryOperation
                     cmdFlag:@"0372"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTimeSegmentedModeStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTimeSegmentedModeStrategyOperation
                     cmdFlag:@"0380"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTimeSegmentedModeTimePeriodSettingWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTimeSegmentedModeTimePeriodSettingOperation
                     cmdFlag:@"0381"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙扫描过滤参数************************************************

+ (void)ct_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadRssiFilterValueOperation
                     cmdFlag:@"0401"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterRelationshipOperation
                     cmdFlag:@"0402"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterTypeStatusOperation
                     cmdFlag:@"0403"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByMacPreciseMatchOperation
                     cmdFlag:@"0410"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByMacReverseFilterOperation
                     cmdFlag:@"0411"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterMACAddressListOperation
                     cmdFlag:@"0412"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByAdvNamePreciseMatchOperation
                     cmdFlag:@"0418"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByAdvNameReverseFilterOperation
                     cmdFlag:@"0419"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ee00041a00";
    [centralManager addTaskWithTaskID:mk_ct_taskReadFilterAdvNameListOperation
                       characteristic:peripheral.ct_custom
                          commandData:commandString
                         successBlock:^(id  _Nonnull returnData) {
        NSArray *advList = [MKCTSDKDataAdopter parseFilterAdvNameList:returnData[@"result"]];
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":@{
                                        @"nameList":advList,
                                    },
                                    };
        MKBLEBase_main_safe(^{
            if (sucBlock) {
                sucBlock(resultDic);
            }
        });
        
    } failureBlock:failedBlock];
}



+ (void)ct_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBeaconStatusOperation
                     cmdFlag:@"0420"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBeaconMajorRangeOperation
                     cmdFlag:@"0421"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBeaconMinorRangeOperation
                     cmdFlag:@"0422"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBeaconUUIDOperation
                     cmdFlag:@"0423"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByUIDStatusOperation
                     cmdFlag:@"0428"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByUIDNamespaceIDOperation
                     cmdFlag:@"0429"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByUIDInstanceIDOperation
                     cmdFlag:@"042a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByURLStatusOperation
                     cmdFlag:@"0430"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByURLContentOperation
                     cmdFlag:@"0431"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByTLMStatusOperation
                     cmdFlag:@"0438"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByTLMVersionOperation
                     cmdFlag:@"0439"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBXPBeaconStatusOperation
                     cmdFlag:@"0440"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBXPBeaconMajorRangeOperation
                     cmdFlag:@"0441"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBXPBeaconMinorRangeOperation
                     cmdFlag:@"0442"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBXPBeaconUUIDOperation
                     cmdFlag:@"0443"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBXPAccFilterStatusOperation
                     cmdFlag:@"0450"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBXPTHFilterStatusOperation
                     cmdFlag:@"0458"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPDeviceInfoStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBXPDeviceInfoFilterStatusOperation
                     cmdFlag:@"0460"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBXPButtonFilterStatusOperation
                     cmdFlag:@"0468"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBXPButtonAlarmFilterStatusOperation
                     cmdFlag:@"0469"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByBXPTagIDStatusOperation
                     cmdFlag:@"0470"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPreciseMatchTagIDStatusOperation
                     cmdFlag:@"0471"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadReverseFilterTagIDStatusOperation
                     cmdFlag:@"0472"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterBXPTagIDListOperation
                     cmdFlag:@"0473"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterBXPTofStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterBXPTofStatusOperation
                     cmdFlag:@"0478"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterBXPTofMfgCodeListWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterBXPTofMfgCodeListOperation
                     cmdFlag:@"0479"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirStatusOperation
                     cmdFlag:@"0480"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirDetectionStatusOperation
                     cmdFlag:@"0481"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirSensorSensitivityOperation
                     cmdFlag:@"0482"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirDoorStatusOperation
                     cmdFlag:@"0483"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirDelayResponseStatusOperation
                     cmdFlag:@"0484"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirMajorRangeOperation
                     cmdFlag:@"0485"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByPirMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByPirMinorRangeOperation
                     cmdFlag:@"0486"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByOtherStatusOperation
                     cmdFlag:@"04f8"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByOtherRelationshipOperation
                     cmdFlag:@"04f9"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadFilterByOtherConditionsOperation
                     cmdFlag:@"04fa"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)ct_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"0500"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanRegionOperation
                     cmdFlag:@"0501"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanModemOperation
                     cmdFlag:@"0502"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"0503"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"0504"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"0505"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanDEVADDROperation
                     cmdFlag:@"0506"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"0507"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"0508"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanADRACKLimitOperation
                     cmdFlag:@"050a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanADRACKDelayOperation
                     cmdFlag:@"050b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanCHOperation
                     cmdFlag:@"0520"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanDROperation
                     cmdFlag:@"0521"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"0522"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"0523"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"0540"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"0541"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readDeviceInfoPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadDeviceInfoPayloadDataOperation
                     cmdFlag:@"0550"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readHeartbeatPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadHeartbeatPayloadDataOperation
                     cmdFlag:@"0551"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLowPowerPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLowPowerPayloadDataOperation
                     cmdFlag:@"0552"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readEventPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadEventPayloadDataOperation
                     cmdFlag:@"0554"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readPositioningPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadPositioningPayloadDataOperation
                     cmdFlag:@"0555"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShockPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShockPayloadDataOperation
                     cmdFlag:@"0557"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readManDownDetectionPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadManDownDetectionPayloadDataOperation
                     cmdFlag:@"0558"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}



+ (void)ct_readGPSLimitPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadGPSLimitPayloadDataOperation
                     cmdFlag:@"055b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************辅助功能************************************************

+ (void)ct_readDownlinkPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadDownlinkPositioningStrategyOperation
                     cmdFlag:@"0600"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShockDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShockDetectionStatusOperation
                     cmdFlag:@"0610"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShockThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShockThresholdsOperation
                     cmdFlag:@"0611"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShockDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShockDetectionReportIntervalOperation
                     cmdFlag:@"0612"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readShockTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadShockTimeoutOperation
                     cmdFlag:@"0613"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLightMonitorNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLightMonitorNotifyStatusOperation
                     cmdFlag:@"0640"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLightDataSampleRateIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLightDataSampleRateIntervalOperation
                     cmdFlag:@"0641"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readLightThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadLightThresholdOperation
                     cmdFlag:@"0642"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTemperatureMonitorNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTemperatureMonitorNotifyStatusOperation
                     cmdFlag:@"0650"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTemperatureDataSampleRateIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTemperatureDataSampleRateIntervalOperation
                     cmdFlag:@"0651"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readTemperatureThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadTemperatureThresholdOperation
                     cmdFlag:@"0652"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAlarmTypeWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAlarmTypeOperation
                     cmdFlag:@"0660"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readExitAlarmTypeTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadExitAlarmTypeTimeOperation
                     cmdFlag:@"0661"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAlertAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAlertAlarmTriggerModeOperation
                     cmdFlag:@"0662"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAlertAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAlertAlarmPositioningStrategyOperation
                     cmdFlag:@"0663"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readAlertAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadAlertAlarmNotifyStatusOperation
                     cmdFlag:@"0664"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readSosAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadSosAlarmTriggerModeOperation
                     cmdFlag:@"0665"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readSosAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadSosAlarmPositioningStrategyOperation
                     cmdFlag:@"0666"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readSosAlarmReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadSosAlarmReportIntervalOperation
                     cmdFlag:@"0667"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readSosAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadSosAlarmNotifyStatusOperation
                     cmdFlag:@"0668"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadManDownDetectionOperation
                     cmdFlag:@"0670"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readManDownDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadManDownDetectionTimeoutOperation
                     cmdFlag:@"0671"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readManDownDetectionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadManDownDetectionStrategyOperation
                     cmdFlag:@"0672"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readManDownDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadManDownDetectionReportIntervalOperation
                     cmdFlag:@"0673"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙定位参数************************************************
+ (void)ct_readGpsLimitUploadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadGpsLimitUploadStatusOperation
                     cmdFlag:@"0801"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readOutdoorBLEReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadOutdoorBLEReportIntervalOperation
                     cmdFlag:@"0808"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readOutdoorGPSReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadOutdoorGPSReportIntervalOperation
                     cmdFlag:@"0809"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBluetoothFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBluetoothFixMechanismOperation
                     cmdFlag:@"0820"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBlePositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBlePositioningTimeoutOperation
                     cmdFlag:@"0821"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBlePositioningNumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBlePositioningNumberOfMacOperation
                     cmdFlag:@"0822"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readBeaconVoltageReportInBleFixWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadBeaconVoltageReportInBleFixOperation
                     cmdFlag:@"0823"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readGPSFixPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadGPSFixPositioningTimeoutOperation
                     cmdFlag:@"0830"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)ct_readGPSFixPDOPWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_ct_taskReadGPSFixPDOPOperation
                     cmdFlag:@"0831"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_ct_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.ct_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
