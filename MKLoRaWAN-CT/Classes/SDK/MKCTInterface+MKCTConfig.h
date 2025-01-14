//
//  MKCTInterface+MKCTConfig.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTInterface (MKCTConfig)

#pragma mark ****************************************System************************************************

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_powerOffWithSucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/// @param interval 1min~14400mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configHeartbeatInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Indicator Settings.
/// @param protocol protocol.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configIndicatorSettings:(id <mk_ct_indicatorSettingsProtocol>)protocol
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

///  Hall Power Off Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configHallPowerOffStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Shutdown Payload Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShutdownPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Buzzer sound selection.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBuzzerSoundType:(mk_ct_buzzerSoundType)type
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure three-axis sensor wake-up conditions.
/// @param threshold 1 x 16ms ~20 x 16ms
/// @param duration 1 x 10ms ~ 10 x 10ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configThreeAxisWakeupConditions:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure three-axis data motion detection judgment parameters.
/// @param threshold 10 x 2mg ~ 250 x 2mg
/// @param duration 1 x 5ms ~ 50 x 5ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configThreeAxisMotionParameters:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ***************************************电池相关参数************************************************
/// Battery Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_batteryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/// @param prompt prompt
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLowPowerPrompt:(mk_ct_lowPowerPrompt)prompt
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to trigger a heartbeat when the device is low on battery.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLowPowerPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power information packet reporting interval in low power state.
/// @param interval 1×30mins ~ 255×30mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLowPowerPayloadInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Automatically power on after charging.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAutoPowerOnAfterCharging:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙相关参数************************************************

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast timeout time in Bluetooth configuration mode.
/// @param timeout 1Min~60Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBroadcastTimeout:(NSInteger)timeout
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBeaconStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Adv interval of the device.
/// @param interval 1~100(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTxPower:(mk_ct_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 0~16 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************模式相关参数************************************************

/// Configure the working mode of the device.
/// @param deviceMode device mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configWorkMode:(mk_ct_deviceMode)deviceMode
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Standby Mode positioning strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configStandbyModePositioningStrategy:(mk_ct_positioningStrategy)strategy
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Periodic Mode positioning strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPeriodicModePositioningStrategy:(mk_ct_positioningStrategy)strategy
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Periodic Mode reporting interval.
/// @param interval 1min~14400mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPeriodicModeReportInterval:(long long)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Timing Mode positioning strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimingModePositioningStrategy:(mk_ct_positioningStrategy)strategy
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Timing Mode Reporting Time Point.
/// @param dataList up to 10 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimingModeReportingTimePoint:(NSArray <mk_ct_timingModeReportingTimePointProtocol>*)dataList
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Notify Event On Start.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsNotifyEventOnStart:(BOOL)isOn
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix On Start.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsFixOnStart:(BOOL)isOn
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy On Start.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModePosStrategyOnStart:(mk_ct_positioningStrategy)strategy
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Number Of Fix On Start.
/// @param number 1~10
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeNumberOfFixOnStart:(NSInteger)number
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Notify Event In Trip.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsNotifyEventInTrip:(BOOL)isOn
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix In Trip.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsFixInTrip:(BOOL)isOn
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy In Trip.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModePosStrategyInTrip:(mk_ct_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Report Interval In Trip.
/// @param interval 10s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeReportIntervalInTrip:(long long)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Notify Event On End.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsNotifyEventOnEnd:(BOOL)isOn
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix On End.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsFixOnEnd:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Pos-Strategy On End.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModePosStrategyOnEnd:(mk_ct_positioningStrategy)strategy
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Report Interval On End.
/// @param interval 10s~300s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeReportIntervalOnEnd:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Number Of Fix On End.
/// @param number 1~10
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeNumberOfFixOnEnd:(NSInteger)number
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Motion Mode Trip End Timeout.
/// @param time 1~180(Unit:10s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeTripEndTimeout:(NSInteger)time
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Fix On Stationary State.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configMotionModeEventsFixOnStationaryState:(BOOL)isOn
                                             sucBlock:(void (^)(void))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Pos-Strategy On Stationary.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPosStrategyOnStationary:(mk_ct_positioningStrategy)strategy
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Report Interval On Stationary.
/// @param interval 1Min~14400Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configReportIntervalOnStationary:(NSInteger)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time-Segmented Mode Positioning Strategy.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimeSegmentedModeStrategy:(mk_ct_positioningStrategy)strategy
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time-Segmented Mode Time Period Setting.
/// @param dataList up to 10 groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimeSegmentedModeTimePeriodSetting:(NSArray <mk_ct_timeSegmentedModeTimePeriodSettingProtocol>*)dataList
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;


#pragma mark ****************************************蓝牙扫描过滤参数************************************************

/// The device will uplink valid ADV data with RSSI no less than rssi dBm.
/// @param rssi -127 dBm ~ 0 dBm.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configRssiFilterValue:(NSInteger)rssi
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterRelationship:(mk_ct_filterRelationship)relationship
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByMacPreciseMatch:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByMacReverseFilter:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterMACAddressList:(NSArray <NSString *>*)macList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByAdvNamePreciseMatch:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByAdvNameReverseFilter:(BOOL)isOn
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of Adv Name.
/// @param nameList You can set up to 10 filters.1-20 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterAdvNameList:(NSArray <NSString *>*)nameList
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBeaconStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBeaconMajorWithMinValue:(NSInteger)minValue
                                        maxValue:(NSInteger)maxValue
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBeaconMinorWithMinValue:(NSInteger)minValue
                                        maxValue:(NSInteger)maxValue
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBeaconUUID:(NSString *)uuid
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByUIDStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/// @param namespaceID 0~10 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByUIDNamespaceID:(NSString *)namespaceID
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/// @param instanceID 0~6 Bytes
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByUIDInstanceID:(NSString *)instanceID
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByURLStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/// @param content 0~100 Characters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByURLContent:(NSString *)content
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByTLMStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/// @param version version
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByTLMVersion:(mk_ct_filterByTLMVersion)version
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPBeaconStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPBeaconMajorWithMinValue:(NSInteger)minValue
                                           maxValue:(NSInteger)maxValue
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/// @param minValue 0~65535(isOn=YES)
/// @param maxValue minValue~65535(isOn=YES)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPBeaconMinorWithMinValue:(NSInteger)minValue
                                           maxValue:(NSInteger)maxValue
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/// @param uuid 0~16 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPBeaconUUID:(NSString *)uuid
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-ACC device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBXPAccFilterStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The filter status of the BeaconX Pro-T&H device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBXPTHFilterStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Device Info.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPDeviceInfoStatus:(BOOL)isOn
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP Button.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPButtonStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-Button type filter content.
/// @param singlePress Filter Single Press alarm message switch.
/// @param doublePress Filter Double Press alarm message switch
/// @param longPress Filter Long Press alarm message switch
/// @param abnormalInactivity Abnormal Inactivity
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPButtonAlarmStatus:(BOOL)singlePress
                                  doublePress:(BOOL)doublePress
                                    longPress:(BOOL)longPress
                           abnormalInactivity:(BOOL)abnormalInactivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-T&S TagID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByBXPTagIDStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPreciseMatchTagIDStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configReverseFilterTagIDStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-T&S TagID.
/// @param macList You can set up to 10 filters.1-6 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterBXPTagIDList:(NSArray <NSString *>*)tagIDList
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-Tof.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByTofStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-Tof.
/// @param codeList You can set up to 10 filters.1-2 Bytes.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterBXPTofList:(NSArray <NSString *>*)codeList
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-PIR.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Detection Status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirDetectionStatus:(mk_ct_detectionStatus)status
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Sensor Sensitivity of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirSensorSensitivity:(mk_ct_sensorSensitivity)sensitivity
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Door status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirDoorStatus:(mk_ct_doorStatus)status
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Delay response status of filter by MK-PIR.
/// @param status status
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirDelayResponseStatus:(mk_ct_delayResponseStatus)status
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of MK-PIR.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirMajorMinValue:(NSInteger)minValue
                                 maxValue:(NSInteger)maxValue
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of MK-PIR.
/// @param minValue 0~65535
/// @param maxValue minValue~65535
/// @param failedBlock Failure callback
+ (void)ct_configFilterByPirMinorMinValue:(NSInteger)minValue
                                 maxValue:(NSInteger)maxValue
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByOtherStatus:(BOOL)isOn
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/// @param relationship relationship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByOtherRelationship:(mk_ct_filterByOther)relationship
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter conditions.
/// @param conditions conditions
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configFilterByOtherConditions:(NSArray <mk_ct_BLEFilterRawDataProtocol>*)conditions
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configRegion:(mk_ct_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configModem:(mk_ct_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK LIMIT Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLorawanADRACKLimit:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The ADR ACK DELAY Of Lorawan.
/// @param value 1~255
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLorawanADRACKDelay:(NSInteger)value
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)ct_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param transmissions 1/2
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configUplinkStrategy:(BOOL)isOn
                  transmissions:(NSInteger)transmissions
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Device Information Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDeviceInfoPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                              retransmissionTimes:(NSInteger)times
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configHeartbeatPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                             retransmissionTimes:(NSInteger)times
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Low-Power Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLowPowerPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                            retransmissionTimes:(NSInteger)times
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Event Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configEventPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                         retransmissionTimes:(NSInteger)times
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configPositioningPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                               retransmissionTimes:(NSInteger)times
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Shock Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShockPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                         retransmissionTimes:(NSInteger)times
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Man Down Detection Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configManDownDetectionPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                                    retransmissionTimes:(NSInteger)times
                                               sucBlock:(void (^)(void))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// GPS Limit Payload Type.
/// @param type type
/// @param times Max Retransmission Times.(1~4)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configGPSLimitPayloadWithMessageType:(mk_ct_loraWanMessageType)type
                            retransmissionTimes:(NSInteger)times
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************辅助功能************************************************

/// Configure the Positioning Strategy Downlink  For Position.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configDownlinkPositioningStrategy:(mk_ct_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the state of the Shock detection switch.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShockDetectionStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Shock detection threshold.
/// @param threshold 10 x 10mg ~ 255 x 10mg
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShockThresholds:(NSInteger)threshold
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the report interval of the Shock detection.
/// @param interval 3s~255s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShockDetectionReportInterval:(NSInteger)interval
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Shock Timeout.
/// @param interval 1s~20s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configShockTimeout:(NSInteger)interval
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Lighting Monitor Notify Status.
/// @param isOn Lighting Monitor Status.
/// @param alarmSwicth Alarm Swicth Status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLightMonitorNotifyStatus:(BOOL)isOn
                              alarmSwicth:(BOOL)alarmSwicth
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Lighting data simple rate interval.
/// @param interval 1s~3600s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLightDataSampleRateInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Lighting Threshold.
/// @param threshold 10Lux~200Lux.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configLightThreshold:(NSInteger)threshold
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature Monitor Notify Status.
/// @param isOn Lighting Monitor Status.
/// @param alarmSwicth Alarm Swicth Status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTemperatureMonitorNotifyStatus:(BOOL)isOn
                                    alarmSwicth:(BOOL)alarmSwicth
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature data simple rate interval.
/// @param interval 1s~3600s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTemperatureDataSampleRateInterval:(NSInteger)interval
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature Threshold.
/// @param max -20℃~60℃.
/// @param min -20℃~60℃.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configTemperatureThreshold:(NSInteger)max
                                  min:(NSInteger)min
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Type of Alarm Function.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAlarmType:(mk_ct_alarmType)type
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// The time required to press and hold the button to exit the alarm.
/// @param time 5s~15s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configExitAlarmTypeTime:(NSInteger)time
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Mode Of Alert Alarm.
/// @param mode mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAlertAlarmTriggerMode:(mk_ct_alertAlarmTriggerMode)mode
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Strategy  For Alert Alarm.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAlertAlarmPositioningStrategy:(mk_ct_positioningStrategy)strategy
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Notify Event On Alert Start/End For Alert Alarm.
/// @param start Notify Event On Alert Start.
/// @param end Notify Event On Alert End.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configAlertAlarmNotifyEventWithStart:(BOOL)start
                                            end:(BOOL)end
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Mode Of SOS Alarm.
/// @param mode mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configSosAlarmTriggerMode:(mk_ct_alertAlarmTriggerMode)mode
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Strategy  For SOS Alarm.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configSosAlarmPositioningStrategy:(mk_ct_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Report Interval For SOS Alarm.
/// @param interval 10s~600s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configSosAlarmReportInterval:(NSInteger)interval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Notify Event On Alert Start/End For SOS Alarm.
/// @param start Notify Event On Alert Start.
/// @param end Notify Event On Alert End.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configSosAlarmNotifyEventWithStart:(BOOL)start
                                          end:(BOOL)end
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure  Man Down Detection.
/// @param isOn isOn
/// @param notifyEventOnManDownStart Notify Event On Man Down Start
/// @param notifyEventOnManDownEnd Notify Event On Man Down End
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configManDownDetectionStatus:(BOOL)isOn
              notifyEventOnManDownStart:(BOOL)notifyEventOnManDownStart
                notifyEventOnManDownEnd:(BOOL)notifyEventOnManDownEnd
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure ManDown Detection Timeout.
/// @param timeout 1Min~120Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configManDownDetectionTimeout:(NSInteger)timeout
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the Positioning Strategy for ManDown Detection.
/// @param strategy strategy
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configManDownPositioningStrategy:(mk_ct_positioningStrategy)strategy
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure ManDown Detection Report Interval.
/// @param interval 10s~600s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configManDownDetectionReportInterval:(NSInteger)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************定位参数************************************************
/// GPS limit upload switch.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configGpsLimitUploadStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Outdoor BLE Report Interval.
/// - Parameters:
///   - interval: 1min~100min.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ct_configOutdoorBLEReportInterval:(NSInteger)interval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Outdoor GPS Report Interval.
/// - Parameters:
///   - interval: 1min~14400min.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ct_configOutdoorGPSReportInterval:(NSInteger)interval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Bluetooth Fix Mechanism.
/// @param priority priority
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBluetoothFixMechanism:(mk_ct_bluetoothFixMechanism)priority
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Timeout Of Ble.
/// @param timeout 1s~10s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBlePositioningTimeout:(NSInteger)timeout
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// The number of MACs for Bluetooth positioning.
/// @param number 1~15
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBlePositioningNumberOfMac:(NSInteger)number
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon Voltage Report in Bluetooth Fix.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_configBeaconVoltageReportInBleFixStatus:(BOOL)isOn
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// L76K GPS Fix Positioning Timeout.
/// - Parameters:
///   - timeout: 30s~600s.
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ct_configGPSFixPositioningTimeout:(NSInteger)timeout
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// L76K GPS Fix PDOP.
/// - Parameters:
///   - pdop: 25~100
///   - sucBlock: Success callback
///   - failedBlock: Failure callback
+ (void)ct_configGPSFixPDOP:(NSInteger)pdop
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
