#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKCTCentralManager

typedef NS_ENUM(NSInteger, mk_ct_centralConnectStatus) {
    mk_ct_centralConnectStatusUnknow,                                           //未知状态
    mk_ct_centralConnectStatusConnecting,                                       //正在连接
    mk_ct_centralConnectStatusConnected,                                        //连接成功
    mk_ct_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_ct_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_ct_centralManagerStatus) {
    mk_ct_centralManagerStatusUnable,                           //不可用
    mk_ct_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_ct_deviceMode) {
    mk_ct_deviceMode_standbyMode,         //Standby mode
    mk_ct_deviceMode_periodicMode,        //Periodic mode
    mk_ct_deviceMode_timingMode,          //Timing mode
    mk_ct_deviceMode_motionMode,          //Motion Mode
};

typedef NS_ENUM(NSInteger, mk_ct_lowPowerPrompt) {
    mk_ct_lowPowerPrompt_tenPercent,
    mk_ct_lowPowerPrompt_twentyPercent,
    mk_ct_lowPowerPrompt_thirtyPercent,
    mk_ct_lowPowerPrompt_fortyPercent,
    mk_ct_lowPowerPrompt_fiftyPercent,
    mk_ct_lowPowerPrompt_sixtyPercent,
};

typedef NS_ENUM(NSInteger, mk_ct_buzzerSoundType) {
    mk_ct_buzzerSoundType_no,
    mk_ct_buzzerSoundType_alarm,
    mk_ct_buzzerSoundType_normal,
};

typedef NS_ENUM(NSInteger, mk_ct_positioningStrategy) {
    mk_ct_positioningStrategy_ble,      //BLE
    mk_ct_positioningStrategy_gps,      //GPS
    mk_ct_positioningStrategy_bleAndGps_1,  //BLE + GPS
    mk_ct_positioningStrategy_bleAndGps_2,  //BLE * GPS
    mk_ct_positioningStrategy_bleAndGps_3,  //BLE & GPS
};

typedef NS_ENUM(NSInteger, mk_ct_alarmType) {
    mk_ct_alarmType_no,
    mk_ct_alarmType_alert,
    mk_ct_alarmType_sos
};

typedef NS_ENUM(NSInteger, mk_ct_alertAlarmTriggerMode) {
    mk_ct_alertAlarmTriggerMode_singleClick,
    mk_ct_alertAlarmTriggerMode_doubleClick,
    mk_ct_alertAlarmTriggerMode_longPressOneSecond,
    mk_ct_alertAlarmTriggerMode_longPressTwoSeconds,
    mk_ct_alertAlarmTriggerMode_longPressThreeSeconds
};

typedef NS_ENUM(NSInteger, mk_ct_filterRelationship) {
    mk_ct_filterRelationship_null,
    mk_ct_filterRelationship_mac,
    mk_ct_filterRelationship_advName,
    mk_ct_filterRelationship_rawData,
    mk_ct_filterRelationship_advNameAndRawData,
    mk_ct_filterRelationship_macAndadvNameAndRawData,
    mk_ct_filterRelationship_advNameOrRawData,
};

typedef NS_ENUM(NSInteger, mk_ct_filterByTLMVersion) {
    mk_ct_filterByTLMVersion_null,             //Do not filter data.
    mk_ct_filterByTLMVersion_0,                //Unencrypted TLM data.
    mk_ct_filterByTLMVersion_1,                //Encrypted TLM data.
};

typedef NS_ENUM(NSInteger, mk_ct_filterByOther) {
    mk_ct_filterByOther_A,                 //Filter by A condition.
    mk_ct_filterByOther_AB,                //Filter by A & B condition.
    mk_ct_filterByOther_AOrB,              //Filter by A | B condition.
    mk_ct_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_ct_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_ct_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_ct_dataFormat) {
    mk_ct_dataFormat_DAS,
    mk_ct_dataFormat_Customer,
};

typedef NS_ENUM(NSInteger, mk_ct_positioningSystem) {
    mk_ct_positioningSystem_GPS,
    mk_ct_positioningSystem_Beidou,
    mk_ct_positioningSystem_GPSAndBeidou
};

typedef NS_ENUM(NSInteger, mk_ct_loraWanRegion) {
    mk_ct_loraWanRegionAS923,
    mk_ct_loraWanRegionAU915,
    mk_ct_loraWanRegionEU868,
    mk_ct_loraWanRegionKR920,
    mk_ct_loraWanRegionIN865,
    mk_ct_loraWanRegionUS915,
    mk_ct_loraWanRegionRU864,
    mk_ct_loraWanRegionAS923_1,
    mk_ct_loraWanRegionAS923_2,
    mk_ct_loraWanRegionAS923_3,
    mk_ct_loraWanRegionAS923_4,
};

typedef NS_ENUM(NSInteger, mk_ct_loraWanModem) {
    mk_ct_loraWanModemABP,
    mk_ct_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_ct_loraWanMessageType) {
    mk_ct_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_ct_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_ct_txPower) {
    mk_ct_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_ct_txPowerNeg20dBm,   //-20dBm
    mk_ct_txPowerNeg16dBm,   //-16dBm
    mk_ct_txPowerNeg12dBm,   //-12dBm
    mk_ct_txPowerNeg8dBm,    //-8dBm
    mk_ct_txPowerNeg4dBm,    //-4dBm
    mk_ct_txPower0dBm,       //0dBm
    mk_ct_txPower3dBm,       //3dBm
    mk_ct_txPower4dBm,       //4dBm
};

typedef NS_ENUM(NSInteger, mk_ct_bluetoothFixMechanism) {
    mk_ct_bluetoothFixMechanism_timePriority,
    mk_ct_bluetoothFixMechanism_rssiPriority,
};

typedef NS_ENUM(NSInteger, mk_ct_detectionStatus) {
    mk_ct_detectionStatus_noMotionDetected,
    mk_ct_detectionStatus_motionDetected,
    mk_ct_detectionStatus_all
};

typedef NS_ENUM(NSInteger, mk_ct_sensorSensitivity) {
    mk_ct_sensorSensitivity_low,
    mk_ct_sensorSensitivity_medium,
    mk_ct_sensorSensitivity_high,
    mk_ct_sensorSensitivity_all
};

typedef NS_ENUM(NSInteger, mk_ct_doorStatus) {
    mk_ct_doorStatus_close,
    mk_ct_doorStatus_open,
    mk_ct_doorStatus_all
};

typedef NS_ENUM(NSInteger, mk_ct_delayResponseStatus) {
    mk_ct_delayResponseStatus_low,
    mk_ct_delayResponseStatus_medium,
    mk_ct_delayResponseStatus_high,
    mk_ct_delayResponseStatus_all
};

@protocol mk_ct_indicatorSettingsProtocol <NSObject>

@property (nonatomic, assign)BOOL DeviceState;
@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL Charging;
@property (nonatomic, assign)BOOL FullCharge;
@property (nonatomic, assign)BOOL Broadcast;
@property (nonatomic, assign)BOOL NetworkCheck;
@property (nonatomic, assign)BOOL InFix;
@property (nonatomic, assign)BOOL FixSuccessful;
@property (nonatomic, assign)BOOL FailToFix;

@end

@protocol mk_ct_timingModeReportingTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end

@protocol mk_ct_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, assign)BOOL fixOnStationaryState;

@end

@protocol mk_ct_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. If minIndex==0,maxIndex must be 0.The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_ct_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
/*
 @{
 @"rssi":@(-55),
 @"peripheral":peripheral,
 @"deviceName":@"LW008-MT",
 
 @"deviceType":@"00",           //@"00"
 @"txPower":@(-55),             //dBm
 @"workMode":@"0",           //0 (Standby Mode), 1 (Timing Mode), 2 (Periodic Mode), 3 (Motion Mode) 4(Self-test failed)
 @"needPassword":@(YES),
 @"lightOverThreshold":@(NO),               //Whether the light is over threshold.
 @"highTemperatureOverThreshold":@(YES),               //Whether over the temperature limits threshold.
 @"lowTemperatureBelowThreshold":@(YES),               //Whether below the temperature limits threshold.
 @"alarm":@(NO),        //Whether alarm,
 @"manDown":@(YES),
 @"vibrate":@(NO),
 @"downLink":@(YES),
 @"voltage":@"3.333",           //V
 @"macAddress":@"AA:BB:CC:DD:EE:FF",
 @"connectable":advDic[CBAdvertisementDataIsConnectable],
 }
 */
- (void)mk_ct_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_ct_startScan;

/// Stops scanning equipment.
- (void)mk_ct_stopScan;

@end


@protocol mk_ct_centralManagerLogDelegate <NSObject>

- (void)mk_ct_receiveLog:(NSString *)deviceLog;

@end
