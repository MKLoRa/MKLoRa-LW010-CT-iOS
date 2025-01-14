//
//  MKCTInterface.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCTSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************System************************************************
/// Read the mac address of the device.
/*
 @{
    @"macAddress":@"AA:BB:CC:DD:EE:FF"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Interval.
/*
 @{
 @"interval":@"720"     //Unit:Min.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Indicator Settings.
/*
 @{
 @"charging":@(YES),
 @"fullCharge":@(YES),
 @"lowPower":@(YES),
 @"networkCheck":@(YES),
 @"inFix":@(YES),
 @"fixSuccessful":@(YES),
 @"failToFix":@(YES),
 @"broadcast":@(YES),
 @"deviceState":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Hall Power Off Status.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readHallPowerOffStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Shutdown Payload Status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Buzzer sound selection.
/*
    @{
    @"buzzer":@"0",     //"0":No  "1":Alarm  "2":Normal
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBuzzerSoundTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read three-axis sensor wake-up conditions.
/*
 @{
     @"threshold":threshold,        //x 16mg
     @"duration":duration,          //x 10ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read three-axis data motion detection judgment parameters.
/*
 @{
     @"threshold":threshold,        //x 2mg
     @"duration":duration,          //x 5ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read battery voltage.
/*
 @{
 @"voltage":@"3000",        //Unit:mV
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the PCBA Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Selftest Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Temperature.If the temperature monitoring function is turned off, the value is 0x80.
/*
    @{
    @"temperature":@"10", //Unit: ℃
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTemperatureWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError * error))failedBlock;

/// illumination intensity.If the light monitoring function is turned off, the value is 0xFFFF.
/*
    @{
    @"intensity":@"10", //Unit: Lux
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLightIlluminationIntensityWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

#pragma mark ***************************************电池相关参数************************************************
/// All Cycles Battery Information.
/*
 @{
     @"workTimes":@"65535",         //Device working times.(Unit:s)
     @"advCount":@"65535",          //The number of Bluetooth broadcasts by the device.
     @"axisWakeupTimes":@"11111",       //Three-axis sensor wake-up times.(Unit:s)
     @"blePostionTimes":@"11111",       //Bluetooth positioning times.(Unit:s)
     @"gpsPostionTimes":@"11111",       //GPS positioning times.(Unit:s)
     @"loraPowerConsumption":@"50000",      //Power consumption of LoRaWAN sending and receiving data.(Unit:mAS)
     @"loraSendCount":@"10000",     //Number of LoRaWAN transmissions.
     @"batteryPower":@"33500"       //Total battery power consumption.(Unit:0.001mAH)
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// When the power of the device is lower than how much, it is judged as a low power state.
/*
    @{
    @"prompt":@"0",         //@"0":10%   @"1":20%   @"2":30%    @"3":40%    @"4":50%    @"5":60%
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to trigger a heartbeat when the device is low on battery.
/*
    @{
    @"isOn":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Low power information packet reporting interval in low power state.
/*
 @{
    @"interval":@"30",  //Unit:x30mins
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLowPowerPayloadIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Automatically power on after charging.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAutoPowerOnAfterChargingWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙相关参数************************************************

/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast timeout time in Bluetooth configuration mode.
/*
 @{
 @"timeout":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon status.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the adv interval of the device.
/*
 @{
    @"interval":@"10", //Unit:100ms
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0dBm"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;


/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************模式相关参数************************************************
/// Read the working mode of the device.
/*
 @{
 @"mode":@"2"
 }
 
 0：Standby mode
 1：Timing mode
 2：Periodic mode
 3：Motion Mode
 4:Time-Segmented Mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Standby Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readStandbyModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Periodic Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 4:BLE&GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Periodic Mode reporting interval.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode Reporting Time Point.
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear: 0-59
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Notify Event On Start.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsNotifyEventOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock;

/// Fix On Start.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On Start.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On Start.
/*
 @{
    @"number":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Notify Event In Trip.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsNotifyEventInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock;

/// Fix In Trip.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsFixInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy In Trip.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 4:BLE&GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval In Trip.
/*
 @{
    @"interval":@"5"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Notify Event On End.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsNotifyEventOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Fix On End.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On End.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval On End.
/*
 @{
 @"interval":@"120"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On End.
/*
 @{
 @"number":@"1"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Trip End Timeout.(Unit:10s)
/*
 @{
    @"time":@"5"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Fix On Stationary State.
/*
 @{
     @"isOn":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readMotionModeEventsFixOnStationaryStateWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Pos-Strategy On Stationary.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPosStrategyOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Report Interval On Stationary.
/*
 @{
 @"interval":@"120"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readReportIntervalOnStationaryWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Time-Segmented Mode Positioning Strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTimeSegmentedModeStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Time-Segmented Mode Time Period Setting.
/*
 
 @{
     @"startHour":@(0),
     @"startMinuteGear":@(0),
     @"endHour":@(1),
     @"endMinuteGear":@(1),
     @"reportInterval":@"50",   //Report Interval. Unit:s
 }
 
 startHour:0~23,
 startMinuteGear:0-59,
 endHour:0~23,
 endMinuteGear:0-59,
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTimeSegmentedModeTimePeriodSettingWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError * error))failedBlock;



#pragma mark ****************************************蓝牙扫描过滤参数************************************************


/// The device will uplink valid ADV data with RSSI no less than xx dBm.
/*
 @{
 @"rssi":@"-127"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readRssiFilterValueWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Broadcast content filtering logic.
/*
 @{
 @"relationship":@"4"
 }
 @"0":Null
 @"1":MAC
 @"2":ADV Name
 @"3":Raw Data
 @"4":ADV Name & Raw Data
 @"5":MAC & ADV Name & Raw Data
 @"6":ADV Name | Raw Data
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read switch status of filtered device types.
/*
 @{
    @"other":@(YES),
    @"iBeacon":@(YES),
    @"uid":@(YES),
    @"url":@(YES),
    @"tlm":@(YES),
    @"bxp_acc":@(YES),
    @"bxp_th":@(YES),
    @"bxp_ts":@(YES),
    @"bxp_deviceInfo":@(YES),
    @"bxp_button":@(YES),
    @"bxp_pir":@(YES),
    @"bxp_tof":@(YES),
    @"bxp_beacon":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterTypeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Mac addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByMacPreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of MAC addresses.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByMacReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"macList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterMACAddressListWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// A switch to accurately filter Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByAdvNamePreciseMatchWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch for reverse filtering of Adv Name.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByAdvNameReverseFilterWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of mac addresses.
/*
 @{
 @"nameList":@[
    @"moko",
 @"LW004-PB",
 @"asdf"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterAdvNameListWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;



/// Switch status of filter by iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by UID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByUIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Namespace ID of filter by UID.
/*
 @{
 @"namespaceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByUIDNamespaceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Instance ID of filter by UID.
/*
 @{
 @"instanceID":@"aabb"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByUIDInstanceIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by URL.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByURLStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Content of filter by URL.
/*
 @{
 @"url":@"moko.com"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByURLContentWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by TLM.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByTLMStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// TLM Version of filter by TLM.
/*
 @{
 @"version":@"0",           //@"0":Null(Do not filter data)   @"1":Unencrypted TLM data. @"2":Encrypted TLM data.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByTLMVersionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-iBeacon.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPBeaconStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPBeaconMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of BXP-iBeacon.
/*
 @{
     @"isOn":@(YES),
     @"minValue":@"00",         //isOn=YES
     @"maxValue":@"11",         //isOn=YES
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPBeaconMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// UUID status of filter by BXP-iBeacon.
/*
 @{
 @"uuid":@"xx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPBeaconUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BeaconX Pro-ACC device.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBXPAccFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BeaconX Pro-T&H device.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBXPTHFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Device Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPDeviceInfoStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filter status of the BXP Button Info.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBXPButtonFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Alarm Filter status of the BXP Button Info.
/*
 @{
     @"singlePresse":@(YES),
     @"doublePresse":@(YES),
     @"longPresse":@(YES),
     @"abnormal":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBXPButtonAlarmFilterStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by BXP-T&S.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByBXPTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Precise Match Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPreciseMatchTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Reverse Filter Tag ID.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readReverseFilterTagIDStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Filtered list of BXP-T&S TagID addresses.
/*
 @{
 @"tagIDList":@[
    @"aabb",
 @"aabbccdd",
 @"ddeeff"
 ],
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterBXPTagIDListWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-TOF equipment filter switch.
/*
    @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterBXPTofStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// BXP-TOF equipment filter MFG code.
/*
    @{
    @"codeList":@[@"AABB",@"CCDD"]
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterBXPTofMfgCodeListWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by MK-PIR.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Detection Status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0: No motion detected  1:Motion detected   2:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Sensor Sensitivity of filter by MK-PIR.
/*
 @{
 @"sensitivity":@"0",            //0:Low 1:Medium 2:High 3:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Door status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0:Close  1:Open  2:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirDoorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Delay response status of filter by MK-PIR.
/*
 @{
 @"status":@"0",            //0:Low delay     1:Medium delay      2:High delay   3:All
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirDelayResponseStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Major filter range of MK-PIR.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirMajorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor filter range of MK-PIR.
/*
 @{
     @"minValue":@"00",
     @"maxValue":@"11",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByPirMinorRangeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Switch status of filter by Other.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByOtherStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Add logical relationships for up to three sets of filter conditions.
/*
 @{
 @"relationship":@"0",
 }
  0:A
  1:A & B
  2:A | B
  3:A & B & C
  4:(A & B) | C
  5:A | B | C
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByOtherRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Current filter.
/*
 @{
    @"conditionList":@[
            @{
                @"type":@"00",
                @"start":@"0"
                @"end":@"3",
                @"data":@"001122"
            },
            @{
                @"type":@"03",
                @"start":@"1"
                @"end":@"2",
                @"data":@"0011"
            }
        ]
    }
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readFilterByOtherConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** LoRaWAN ************************************************
/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 10:AS923-1
 11:AS923-2
 12:AS923-3
 13:AS923-4
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK LIMIT Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanADRACKLimitWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The ADR ACK DELAY Of Lorawan.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanADRACKDelayWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.It is only used for US915,AU915,CN470.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Uplink Strategy  Of Lorawan.
/*
 @{
 @"isOn":@(isOn),
 @"transmissions":transmissions,
 @"DRL":DRL,            //DR For Payload Low.
 @"DRH":DRH,            //DR For Payload High.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.It is only used for EU868,CN779, EU433 and RU864.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan devtime command synchronization interval.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Network Check Interval Of Lorawan.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Device Information Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readDeviceInfoPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Heartbeat Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readHeartbeatPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Low-Power Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLowPowerPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Event Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readEventPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readPositioningPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Shock Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShockPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Man Down Detection Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManDownDetectionPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;



/// GPS Limit Payload Type.
/*
    @{
    @"type":@"0",                   //@"0":Unconfirmed @"1":Confirmed
    @"retransmissionTimes":@"1",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readGPSLimitPayloadDataWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************辅助功能************************************************

/// Read the Positioning Strategy Downlink  For Position.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readDownlinkPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Read the state of the Shock detection switch.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShockDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Shock detection threshold.
/*
 @{
     @"threshold":threshold,        //x 10mg
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShockThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the report interval of the Shock detection.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShockDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Shock Timeout.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readShockTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Lighting Monitor Notify Status.
/*
    @{
    @"isOn":@(YES), //Lighting Monitor Status
    @"alarmSwicth":@(YES),  //Alarm Swicth Status
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLightMonitorNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Lighting data simple rate interval.
/*
    @{
    @"interval":@"60", //Unit: S
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLightDataSampleRateIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Lighting Threshold.
/*
    @{
    @"threshold":@"10", //Unit: Lux
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readLightThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Temperature Monitor Notify Status.
/*
    @{
    @"isOn":@(YES), //Lighting Monitor Status
    @"alarmSwicth":@(YES),  //Alarm Swicth Status
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTemperatureMonitorNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Temperature data simple rate interval.
/*
    @{
    @"interval":@"60", //Unit: S
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTemperatureDataSampleRateIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError * error))failedBlock;

/// Temperature Threshold.
/*
    @{
    @"max":@"10", //Unit: ℃
    @"min":@"-10", //Unit: ℃
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readTemperatureThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Type of Alarm Function.
/*
    @{
    @"type":@"0",       //@"0":NO,  @"1":Alert, @"2":SOS
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAlarmTypeWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// The time required to press and hold the button to exit the alarm.
/*
    @{
    @"time":@"15",      //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readExitAlarmTypeTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Trigger Mode Of Alert Alarm.
/*
    @{
    @"mode":@"0",   //0:Single Click  1:Double Click  2:Long Press 1s 3:Long Press 2s 4:Long Press 3s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAlertAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Strategy  For Alert Alarm.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAlertAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Notify Event On Alert Start/End For Alert Alarm.
/*
    @{
    @"start":@(YES),
    @"end":@(YES)
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readAlertAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock;

/// Trigger Mode Of SOS Alarm.
/*
    @{
    @"mode":@"0",   //0:Single Click  1:Double Click  2:Long Press 1s 3:Long Press 2s 4:Long Press 3s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSosAlarmTriggerModeWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Strategy  For SOS Alarm.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSosAlarmPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Report Interval For SOS Alarm.
/*
    @{
    @"interval":@"10",      //Unit:s
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSosAlarmReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError * error))failedBlock;

/// Notify Event On Alert Start/End For SOS Alarm.
/*
    @{
    @"start":@(YES),
    @"end":@(YES)
 }
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readSosAlarmNotifyStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError * error))failedBlock;

/// Read  Man Down Detection.
/*
 @{
     @"isOn":@(YES),    //Man Down Detection Status
    @"notifyEventOnManDownStart":@(YES),
    @"notifyEventOnManDownEnd":@(YES),
 };
*/
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read ManDown Detection Timeout.(Unit:Minute)
/*
 @{
    @"timeout":@"10",   //Unit:Minute
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManDownDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Positioning Strategy for ManDown Detection.
/*
 @{
 @"strategy":@(1)
 }
 
 0:BLE
 1:GPS
 2:BLE+GPS
 3:BLE*GPS
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManDownDetectionStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Read ManDown Detection Report Interval.
/*
 @{
    @"interval":@"10",   //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readManDownDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************定位参数************************************************
/// GPS limit upload switch.
/*
 @{
    @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readGpsLimitUploadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Outdoor BLE Report Interval.
/*
 @{
 @"interval":@"3",   //Unit:min
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readOutdoorBLEReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Outdoor GPS Report Interval.
/*
 @{
 @"interval":@"3",   //Unit:min
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readOutdoorGPSReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Bluetooth Fix Mechanism.
/*
 @{
    @"priority":@"0",       //@"0":Time Priority, @"1":Rssi Priority.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBluetoothFixMechanismWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Positioning Timeout Of Ble.
/*
 @{
 @"timeout":@"5"            //unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBlePositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// The number of MACs for Bluetooth positioning.
/*
 @{
 @"number":@"3"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBlePositioningNumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Beacon Voltage Report in Bluetooth Fix.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readBeaconVoltageReportInBleFixWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// L76K GPS Fix Positioning Timeout.
/*
 @{
 @"timeout":@"3",   //Unit:s
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readGPSFixPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock;

/// L76K GPS Fix PDOP.
/*
 @{
 @"pdop":@"3",   //Unit:0.1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)ct_readGPSFixPDOPWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
