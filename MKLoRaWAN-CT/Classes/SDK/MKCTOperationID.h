
typedef NS_ENUM(NSInteger, mk_ct_taskOperationID) {
    mk_ct_defaultTaskOperationID,
    
#pragma mark - Read
    mk_ct_taskReadDeviceModelOperation,        //读取产品型号
    mk_ct_taskReadFirmwareOperation,           //读取固件版本
    mk_ct_taskReadHardwareOperation,           //读取硬件类型
    mk_ct_taskReadSoftwareOperation,           //读取软件版本
    mk_ct_taskReadManufacturerOperation,       //读取厂商信息
    mk_ct_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 系统参数读取
    mk_ct_taskReadTimeZoneOperation,            //读取时区
    mk_ct_taskReadWorkModeOperation,            //读取工作模式
    mk_ct_taskReadIndicatorSettingsOperation,   //读取指示灯开关状态
    mk_ct_taskReadHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_ct_taskReadShutdownPayloadStatusOperation,   //读取关机信息上报状态
    mk_ct_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_ct_taskReadLowPowerPromptOperation,          //读取低电百分比
    mk_ct_taskReadHallPowerOffStatusOperation,      //读取霍尔关机功能
    mk_ct_taskReadBatteryVoltageOperation,          //读取电池电量
    mk_ct_taskReadMacAddressOperation,              //读取mac地址
    mk_ct_taskReadPCBAStatusOperation,              //读取产测状态
    mk_ct_taskReadSelftestStatusOperation,          //读取自检故障原因
    mk_ct_taskReadAutoPowerOnAfterChargingOperation,    //读取充电自动开机功能
    mk_ct_taskReadLowPowerPayloadIntervalOperation,     //读取低电状态下低电信息包上报间隔
    mk_ct_taskReadGpsLimitUploadStatusOperation,        //读取GPS极限上传开关
    mk_ct_taskReadBuzzerSoundTypeOperation,         //读取蜂鸣器声效选择
    
#pragma mark - 蓝牙参数读取
    mk_ct_taskReadConnectationNeedPasswordOperation,    //读取连接是否需要密码
    mk_ct_taskReadPasswordOperation,                    //读取连接密码
    mk_ct_taskReadBroadcastTimeoutOperation,            //读取蓝牙广播超时时间
    mk_ct_taskReadTxPowerOperation,                     //读取蓝牙TX Power
    mk_ct_taskReadDeviceNameOperation,                  //读取广播名称
    mk_ct_taskReadAdvIntervalOperation,                 //读取广播间隔
    mk_ct_taskReadBeaconStatusOperation,                //读取Beacon模式开关
    
#pragma mark - 模式相关参数读取
    mk_ct_taskReadStandbyModePositioningStrategyOperation,          //读取待机模式定位策略
    mk_ct_taskReadPeriodicModePositioningStrategyOperation,         //读取定期模式定位策略
    mk_ct_taskReadPeriodicModeReportIntervalOperation,              //读取定期模式上报间隔
    mk_ct_taskReadTimingModePositioningStrategyOperation,           //读取定时模式定位策略
    mk_ct_taskReadTimingModeReportingTimePointOperation,            //读取定时模式时间点
    mk_ct_taskReadMotionModeEventsOperation,                        //读取运动模式事件
    mk_ct_taskReadMotionModeNumberOfFixOnStartOperation,            //读取运动开始定位上报次数
    mk_ct_taskReadMotionModePosStrategyOnStartOperation,            //读取运动开始定位策略
    mk_ct_taskReadMotionModeReportIntervalInTripOperation,          //读取运动中定位间隔
    mk_ct_taskReadMotionModePosStrategyInTripOperation,             //读取运动中定位策略
    mk_ct_taskReadMotionModeTripEndTimeoutOperation,                //读取运动结束判断时间
    mk_ct_taskReadMotionModeNumberOfFixOnEndOperation,              //读取运动结束定位次数
    mk_ct_taskReadMotionModeReportIntervalOnEndOperation,           //读取运动结束定位间隔
    mk_ct_taskReadMotionModePosStrategyOnEndOperation,              //读取运动结束定位策略
    mk_ct_taskReadPosStrategyOnStationaryOperation,                 //读取运动静止状态定位策略
    mk_ct_taskReadReportIntervalOnStationaryOperation,              //读取运动禁止状态上报间隔
    
#pragma mark - 蓝牙扫描过滤参数读取
    mk_ct_taskReadRssiFilterValueOperation,             //读取RSSI过滤规则
    mk_ct_taskReadFilterRelationshipOperation,          //读取广播内容过滤逻辑
    mk_ct_taskReadFilterByMacPreciseMatchOperation, //读取精准过滤MAC开关
    mk_ct_taskReadFilterByMacReverseFilterOperation,    //读取反向过滤MAC开关
    mk_ct_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_ct_taskReadFilterByAdvNamePreciseMatchOperation, //读取精准过滤ADV Name开关
    mk_ct_taskReadFilterByAdvNameReverseFilterOperation,    //读取反向过滤ADV Name开关
    mk_ct_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_ct_taskReadFilterTypeStatusOperation,            //读取过滤设备类型开关
    mk_ct_taskReadFilterByBeaconStatusOperation,        //读取iBeacon类型过滤开关
    mk_ct_taskReadFilterByBeaconMajorRangeOperation,    //读取iBeacon类型Major范围
    mk_ct_taskReadFilterByBeaconMinorRangeOperation,    //读取iBeacon类型Minor范围
    mk_ct_taskReadFilterByBeaconUUIDOperation,          //读取iBeacon类型UUID
    mk_ct_taskReadFilterByUIDStatusOperation,                //读取UID类型过滤开关
    mk_ct_taskReadFilterByUIDNamespaceIDOperation,           //读取UID类型过滤的Namespace ID
    mk_ct_taskReadFilterByUIDInstanceIDOperation,            //读取UID类型过滤的Instance ID
    mk_ct_taskReadFilterByURLStatusOperation,               //读取URL类型过滤开关
    mk_ct_taskReadFilterByURLContentOperation,              //读取URL过滤的内容
    mk_ct_taskReadFilterByTLMStatusOperation,               //读取TLM过滤开关
    mk_ct_taskReadFilterByTLMVersionOperation,              //读取TLM过滤类型
    mk_ct_taskReadFilterByBXPBeaconStatusOperation,      //读取BXP-iBeacon类型过滤开关
    mk_ct_taskReadFilterByBXPBeaconMajorRangeOperation,    //读取BXP-iBeacon类型Major范围
    mk_ct_taskReadFilterByBXPBeaconMinorRangeOperation,    //读取BXP-iBeacon类型Minor范围
    mk_ct_taskReadFilterByBXPBeaconUUIDOperation,          //读取BXP-iBeacon类型UUID
    mk_ct_taskReadBXPDeviceInfoFilterStatusOperation,       //读取BXP-DeviceInfo过滤条件开关
    mk_ct_taskReadBXPAccFilterStatusOperation,          //读取BeaconX Pro-ACC设备过滤开关
    mk_ct_taskReadBXPTHFilterStatusOperation,           //读取BeaconX Pro-T&H设备过滤开关
    mk_ct_taskReadBXPButtonFilterStatusOperation,           //读取BXP-Button过滤条件开关
    mk_ct_taskReadBXPButtonAlarmFilterStatusOperation,      //读取BXP-Button报警过滤开关
    mk_ct_taskReadFilterByBXPTagIDStatusOperation,         //读取BXP-TagID类型开关
    mk_ct_taskReadPreciseMatchTagIDStatusOperation,        //读取BXP-TagID类型精准过滤tagID开关
    mk_ct_taskReadReverseFilterTagIDStatusOperation,    //读取读取BXP-TagID类型反向过滤tagID开关
    mk_ct_taskReadFilterBXPTagIDListOperation,             //读取BXP-TagID过滤规则
    mk_ct_taskReadFilterByPirStatusOperation,           //读取PIR过滤开关
    mk_ct_taskReadFilterByPirDetectionStatusOperation,  //读取PIR设备过滤sensor_detection_status
    mk_ct_taskReadFilterByPirSensorSensitivityOperation,    //读取PIR设备过滤sensor_sensitivity
    mk_ct_taskReadFilterByPirDoorStatusOperation,           //读取PIR设备过滤door_status
    mk_ct_taskReadFilterByPirDelayResponseStatusOperation,  //读取PIR设备过滤delay_response_status
    mk_ct_taskReadFilterByPirMajorRangeOperation,           //读取PIR设备Major过滤范围
    mk_ct_taskReadFilterByPirMinorRangeOperation,           //读取PIR设备Minor过滤范围
    mk_ct_taskReadFilterBXPTofStatusOperation,              //读取BXP-TOF设备过滤开关
    mk_ct_taskReadFilterBXPTofMfgCodeListOperation,         //读取BXP-TOF设备过滤MFG code
    mk_ct_taskReadBXPSensorInfoFilterByTagIDStatusOperation,    //读取BXP-SensorInfo设备过滤开关
    mk_ct_taskReadBXPSensorInfoPreciseMatchTagIDStatusOperation,    //读取BXP-SensorInfo类型精准过滤Tag-ID开关
    mk_ct_taskReadBXPSensorInfoReverseFilterTagIDStatusOperation,   //读取BXP-SensorInfo类型反向过滤Tag-ID开关
    mk_ct_taskReadBXPSensorInfoFilterBXPTagIDListOperation,         //读取BXP-SensorInfo类型设备Tag-ID过滤规则
    mk_ct_taskReadFilterByOtherStatusOperation,         //读取Other过滤条件开关
    mk_ct_taskReadFilterByOtherRelationshipOperation,   //读取Other过滤条件的逻辑关系
    mk_ct_taskReadFilterByOtherConditionsOperation,     //读取Other的过滤条件列表
    
#pragma mark - 蓝牙定位参数读取
    mk_ct_taskReadBluetoothFixMechanismOperation,   //读取蓝牙定位机制
    mk_ct_taskReadBlePositioningTimeoutOperation,   //读取蓝牙定位超时时间
    mk_ct_taskReadBlePositioningNumberOfMacOperation,   //读取蓝牙定位成功MAC数量
    
#pragma mark - GPS定位参数读取
    mk_ct_taskReadGPSFixPositioningTimeoutOperation,    //读取GPS定位超时时间
    mk_ct_taskReadGPSFixPDOPOperation,                  //读取GPS定位PDOP
    mk_ct_taskReadOutdoorBLEReportIntervalOperation,    //读取室外蓝牙定位上报间隔
    mk_ct_taskReadOutdoorGPSReportIntervalOperation,    //读取室外GPS定位上报间隔
    
#pragma mark - 设备控制参数配置
    mk_ct_taskPowerOffOperation,                        //关机
    mk_ct_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_ct_taskFactoryResetOperation,                    //设备恢复出厂设置
    mk_ct_taskConfigDeviceTimeOperation,                //配置时间戳
    mk_ct_taskConfigTimeZoneOperation,                  //配置时区
    mk_ct_taskConfigWorkModeOperation,                  //配置工作模式
    mk_ct_taskConfigIndicatorSettingsOperation,         //配置指示灯开关状态
    mk_ct_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_ct_taskConfigShutdownPayloadStatusOperation,     //配置关机信息上报状态
    mk_ct_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_ct_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_ct_taskConfigHallPowerOffStatusOperation,        //配置霍尔关机功能
    mk_ct_taskConfigAutoPowerOnAfterChargingOperation,  //配置充电自动开机功能
    mk_ct_taskConfigLowPowerPayloadIntervalOperation,   //配置低电状态下低电信息包上报间隔
    mk_ct_taskConfigGpsLimitUploadStatusOperation,      //配置GPS极限上传开关
    mk_ct_taskConfigBuzzerSoundTypeOperation,           //配置蜂鸣器声效选择
    
#pragma mark - 蓝牙参数配置
    mk_ct_taskConfigNeedPasswordOperation,              //配置是否需要连接密码
    mk_ct_taskConfigPasswordOperation,                  //配置连接密码
    mk_ct_taskConfigBroadcastTimeoutOperation,          //配置蓝牙广播超时时间
    mk_ct_taskConfigTxPowerOperation,                   //配置蓝牙TX Power
    mk_ct_taskConfigDeviceNameOperation,                //配置蓝牙广播名称
    mk_ct_taskConfigAdvIntervalOperation,               //配置广播间隔
    mk_ct_taskConfigBeaconStatusOperation,              //配置Beacon模式开关
    
#pragma mark - 配置模式相关参数
    mk_ct_taskConfigStandbyModePositioningStrategyOperation,        //配置待机模式定位策略
    mk_ct_taskConfigPeriodicModePositioningStrategyOperation,       //配置定期模式定位策略
    mk_ct_taskConfigPeriodicModeReportIntervalOperation,            //配置定期模式上报间隔
    mk_ct_taskConfigTimingModePositioningStrategyOperation,         //配置定时模式定位策略
    mk_ct_taskConfigTimingModeReportingTimePointOperation,          //配置定时模式时间点
    mk_ct_taskConfigMotionModeEventsOperation,                      //配置运动模式事件
    mk_ct_taskConfigMotionModeNumberOfFixOnStartOperation,          //配置运动开始定位上报次数
    mk_ct_taskConfigMotionModePosStrategyOnStartOperation,          //配置运动开始定位策略
    mk_ct_taskConfigMotionModeReportIntervalInTripOperation,        //配置运动中定位间隔
    mk_ct_taskConfigMotionModePosStrategyInTripOperation,           //配置运动中定位策略
    mk_ct_taskConfigMotionModeTripEndTimeoutOperation,              //配置运动结束判断时间
    mk_ct_taskConfigMotionModeNumberOfFixOnEndOperation,            //配置运动结束定位次数
    mk_ct_taskConfigMotionModeReportIntervalOnEndOperation,         //配置运动结束定位间隔
    mk_ct_taskConfigMotionModePosStrategyOnEndOperation,            //配置运动结束定位策略
    mk_ct_taskConfigPosStrategyOnStationaryOperation,               //配置运动静止状态定位策略
    mk_ct_taskConfigReportIntervalOnStationaryOperation,            //配置运动禁止状态上报间隔

#pragma mark - 蓝牙扫描过滤参数配置
    mk_ct_taskConfigRssiFilterValueOperation,           //配置rssi过滤规则
    mk_ct_taskConfigFilterRelationshipOperation,        //配置广播内容过滤逻辑
    mk_ct_taskConfigFilterByMacPreciseMatchOperation,   //配置精准过滤MAC开关
    mk_ct_taskConfigFilterByMacReverseFilterOperation,  //配置反向过滤MAC开关
    mk_ct_taskConfigFilterMACAddressListOperation,      //配置MAC过滤规则
    mk_ct_taskConfigFilterByAdvNamePreciseMatchOperation,   //配置精准过滤Adv Name开关
    mk_ct_taskConfigFilterByAdvNameReverseFilterOperation,  //配置反向过滤Adv Name开关
    mk_ct_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_ct_taskConfigFilterByBeaconStatusOperation,          //配置iBeacon类型过滤开关
    mk_ct_taskConfigFilterByBeaconMajorOperation,           //配置iBeacon类型过滤的Major范围
    mk_ct_taskConfigFilterByBeaconMinorOperation,           //配置iBeacon类型过滤的Minor范围
    mk_ct_taskConfigFilterByBeaconUUIDOperation,            //配置iBeacon类型过滤的UUID
    mk_ct_taskConfigFilterByUIDStatusOperation,                 //配置UID类型过滤的开关状态
    mk_ct_taskConfigFilterByUIDNamespaceIDOperation,            //配置UID类型过滤的Namespace ID
    mk_ct_taskConfigFilterByUIDInstanceIDOperation,             //配置UID类型过滤的Instance ID
    mk_ct_taskConfigFilterByURLStatusOperation,                 //配置URL类型过滤的开关状态
    mk_ct_taskConfigFilterByURLContentOperation,                //配置URL类型过滤的内容
    mk_ct_taskConfigFilterByTLMStatusOperation,                 //配置TLM过滤开关
    mk_ct_taskConfigFilterByTLMVersionOperation,                //配置TLM过滤数据类型
    mk_ct_taskConfigFilterByBXPBeaconStatusOperation,          //配置BXP-iBeacon类型过滤开关
    mk_ct_taskConfigFilterByBXPBeaconMajorOperation,           //配置BXP-iBeacon类型过滤的Major范围
    mk_ct_taskConfigFilterByBXPBeaconMinorOperation,           //配置BXP-iBeacon类型过滤的Minor范围
    mk_ct_taskConfigFilterByBXPBeaconUUIDOperation,            //配置BXP-iBeacon类型过滤的UUID
    mk_ct_taskConfigFilterByBXPDeviceInfoStatusOperation,       //配置BXP-DeviceInfo过滤开关
    mk_ct_taskConfigBXPAccFilterStatusOperation,            //配置BeaconX Pro-ACC设备过滤开关
    mk_ct_taskConfigBXPTHFilterStatusOperation,             //配置BeaconX Pro-TH设备过滤开关
    mk_ct_taskConfigFilterByBXPButtonStatusOperation,           //配置BXP-Button过滤开关
    mk_ct_taskConfigFilterByBXPButtonAlarmStatusOperation,      //配置BXP-Button类型过滤内容
    mk_ct_taskConfigFilterByBXPTagIDStatusOperation,            //配置BXP-TagID类型过滤开关
    mk_ct_taskConfigPreciseMatchTagIDStatusOperation,           //配置BXP-TagID类型精准过滤Tag-ID开关
    mk_ct_taskConfigReverseFilterTagIDStatusOperation,          //配置BXP-TagID类型反向过滤Tag-ID开关
    mk_ct_taskConfigFilterBXPTagIDListOperation,                //配置BXP-TagID过滤规则
    mk_ct_taskConfigFilterByPirStatusOperation,             //配置PIR设备过滤开关
    mk_ct_taskConfigFilterByPirDetectionStatusOperation,    //配置PIR设备过滤sensor_detection_status
    mk_ct_taskConfigFilterByPirSensorSensitivityOperation,  //配置PIR设备过滤sensor_sensitivity
    mk_ct_taskConfigFilterByPirDoorStatusOperation,         //配置PIR设备过滤door_status
    mk_ct_taskConfigFilterByPirDelayResponseStatusOperation,    //配置PIR设备过滤delay_response_status
    mk_ct_taskConfigFilterByPirMajorOperation,                  //配置PIR设备Major过滤范围
    mk_ct_taskConfigFilterByPirMinorOperation,                  //配置PIR设备Minor过滤范围
    mk_ct_taskConfigFilterByTofStatusOperation,                 //配置BXP-TOF设备过滤开关
    mk_ct_taskConfigFilterBXPTofListOperation,                  //配置BXP-TOF设备过滤开关
    mk_ct_taskConfigBXPSensorInfoFilterByTagIDStatusOperation,  //配置BXP-SensorInfo设备过滤开关
    mk_ct_taskConfigBXPSensorInfoPreciseMatchTagIDStatusOperation,  //配置BXP-SensorInfo类型精准过滤Tag-ID开关
    mk_ct_taskConfigBXPSensorInfoReverseFilterTagIDStatusOperation, //配置BXP-SensorInfo类型反向过滤Tag-ID开关
    mk_ct_taskConfigBXPSensorInfoFilterBXPTagIDListOperation,       //配置BXP-SensorInfo类型设备Tag-ID过滤规则
    mk_ct_taskConfigFilterByOtherStatusOperation,           //配置Other过滤关系开关
    mk_ct_taskConfigFilterByOtherRelationshipOperation,     //配置Other过滤条件逻辑关系
    mk_ct_taskConfigFilterByOtherConditionsOperation,       //配置Other过滤条件列表
    
#pragma mark - 密码特征
    mk_ct_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_ct_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_ct_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_ct_taskReadLorawanModemOperation,            //读取LoRaWAN入网类型
    mk_ct_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_ct_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_ct_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_ct_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_ct_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_ct_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_ct_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_ct_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_ct_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_ct_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_ct_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_ct_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    mk_ct_taskReadLorawanADRACKLimitOperation,              //读取ADR_ACK_LIMIT
    mk_ct_taskReadLorawanADRACKDelayOperation,              //读取ADR_ACK_DELAY
    mk_ct_taskReadHeartbeatPayloadDataOperation,            //读取心跳包上行配置
    mk_ct_taskReadPositioningPayloadDataOperation,          //读取定位包上行配置
    mk_ct_taskReadLowPowerPayloadDataOperation,             //读取低电包上行配置
    mk_ct_taskReadShockPayloadDataOperation,                //读取震动检测包上行配置
    mk_ct_taskReadEventPayloadDataOperation,                //读取事件信息包上行配置
    mk_ct_taskReadGPSLimitPayloadDataOperation,             //读取GPS极限定位包上行配置
    mk_ct_taskReadDeviceInfoPayloadDataOperation,           //读取设备信息包上行配置
    
#pragma mark - 辅助功能读取
    mk_ct_taskReadDownlinkPositioningStrategyOperation,     //读取下行请求定位策略
    mk_ct_taskReadThreeAxisWakeupConditionsOperation,       //读取三轴唤醒条件
    mk_ct_taskReadThreeAxisMotionParametersOperation,       //读取运动检测判断条件
    mk_ct_taskReadShockDetectionStatusOperation,            //读取震动检测状态
    mk_ct_taskReadShockThresholdsOperation,                 //读取震动检测阈值
    mk_ct_taskReadShockDetectionReportIntervalOperation,    //读取震动上法间隔
    mk_ct_taskReadShockTimeoutOperation,                    //读取震动次数判断间隔
    mk_ct_taskReadManDownDetectionOperation,                //读取闲置功能使能
    mk_ct_taskReadManDownDetectionTimeoutOperation,            //读取Man Down检测超时时间
    mk_ct_taskReadManDownDetectionStrategyOperation,        //读取Man Down定位策略
    mk_ct_taskReadManDownDetectionReportIntervalOperation,  //读取Man Down的定位数据上报间隔
    mk_ct_taskReadAlarmTypeOperation,                       //读取报警类型选择
    mk_ct_taskReadExitAlarmTypeTimeOperation,               //读取退出报警按键时长
    mk_ct_taskReadAlertAlarmTriggerModeOperation,           //读取Alert报警触发按键模式
    mk_ct_taskReadAlertAlarmPositioningStrategyOperation,   //读取Alert报警定位策略
    mk_ct_taskReadAlertAlarmNotifyStatusOperation,          //读取Alert报警事件通知
    mk_ct_taskReadSosAlarmTriggerModeOperation,             //读取SOS报警触发按键模式
    mk_ct_taskReadSosAlarmPositioningStrategyOperation,     //读取SOS报警定位策略
    mk_ct_taskReadSosAlarmReportIntervalOperation,          //读取SOS报警数据上报间隔
    mk_ct_taskReadSosAlarmNotifyStatusOperation,            //读取SOS报警事件通知
    mk_ct_taskReadTemperatureMonitorNotifyStatusOperation,  //读取温度监测开关
    mk_ct_taskReadTemperatureDataSampleRateIntervalOperation, //读取温度数据采样间隔
    mk_ct_taskReadTemperatureThresholdOperation,            //读取温度阈值
    mk_ct_taskReadLightMonitorNotifyStatusOperation,        //读取光照监测开关
    mk_ct_taskReadLightDataSampleRateIntervalOperation,             //读取光照数据采样间隔
    mk_ct_taskReadLightThresholdOperation,                  //读取光照阈值
    mk_ct_taskReadTemperatureOperation,                     //读取温度
    mk_ct_taskReadLightIlluminationIntensityOperation,      //读取光照
    
#pragma mark - 设备LoRa参数配置
    mk_ct_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_ct_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_ct_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_ct_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_ct_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_ct_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_ct_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_ct_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_ct_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_ct_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_ct_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_ct_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_ct_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_ct_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    mk_ct_taskConfigLorawanADRACKLimitOperation,        //配置ADR_ACK_LIMIT
    mk_ct_taskConfigLorawanADRACKDelayOperation,        //配置ADR_ACK_DELAY
    mk_ct_taskConfigHeartbeatPayloadOperation,          //配置心跳包上行配置
    mk_ct_taskConfigPositioningPayloadOperation,        //配置定位包上行配置
    mk_ct_taskConfigLowPowerPayloadOperation,           //配置低电包上行配置
    mk_ct_taskConfigShockPayloadOperation,              //配置震动检测包上行配置
    mk_ct_taskConfigEventPayloadWithMessageTypeOperation,   //配置事件信息包上行配置
    mk_ct_taskConfigGPSLimitPayloadOperation,           //配置GPS极限定位包上行配置
    mk_ct_taskConfigDeviceInfoPayloadOperation,         //配置设备信息包上行配置
    
    
#pragma mark - 辅助功能配置
    mk_ct_taskConfigDownlinkPositioningStrategyyOperation,  //配置下行请求定位策略
    mk_ct_taskConfigThreeAxisWakeupConditionsOperation,         //配置三轴唤醒条件
    mk_ct_taskConfigThreeAxisMotionParametersOperation,         //配置运动检测判断
    mk_ct_taskConfigShockDetectionStatusOperation,          //配置震动检测使能
    mk_ct_taskConfigShockThresholdsOperation,               //配置震动检测阈值
    mk_ct_taskConfigShockDetectionReportIntervalOperation,  //配置震动上发间隔
    mk_ct_taskConfigShockTimeoutOperation,                  //配置震动次数判断间隔
    mk_ct_taskConfigManDownDetectionStatusOperation,            //配置闲置功能使能
    mk_ct_taskConfigManDownDetectionTimeoutOperation,              //配置Man Down检测超时时间
    mk_ct_taskConfigManDownPositioningStrategyyOperation,       //配置Man Down定位策略
    mk_ct_taskConfigManDownDetectionReportIntervalOperation,    //Man Down的定位数据上报间隔
    mk_ct_taskConfigAlarmTypeOperation,                         //配置报警类型选择
    mk_ct_taskConfigExitAlarmTypeTimeOperation,                 //配置退出报警按键
    mk_ct_taskConfigAlertAlarmTriggerModeOperation,             //配置Alert报警触发按键模式
    mk_ct_taskConfigAlertAlarmPositioningStrategyOperation,     //配置Alert报警定位策略
    mk_ct_taskConfigAlertAlarmNotifyEventOperation,             //配置Alert报警事件通知
    mk_ct_taskConfigSosAlarmTriggerModeOperation,               //配置SOS报警触发按键模式
    mk_ct_taskConfigSosAlarmPositioningStrategyOperation,       //配置SOS报警定位策略
    mk_ct_taskConfigSosAlarmReportIntervalOperation,            //配置SOS报警定位数据上报间隔
    mk_ct_taskConfigSosAlarmNotifyEventOperation,               //配置SOS报警事件通知
    mk_ct_taskConfigTemperatureMonitorNotifyStatusOperation,    //配置温度监测开关
    mk_ct_taskConfigTemperatureDataSampleRateIntervalOperation, //配置温度数据采样间隔
    mk_ct_taskConfigTemperatureThresholdOperation,              //配置温度阈值
    mk_ct_taskConfigLightMonitorNotifyStatusOperation,          //配置光照监测开关
    mk_ct_taskConfigLightDataSampleRateIntervalOperation,       //配置光照数据采样间隔
    mk_ct_taskConfigLightThresholdOperation,                    //配置光照阈值
    
#pragma mark - 蓝牙定位参数配置
    mk_ct_taskConfigBluetoothFixMechanismOperation,     //配置蓝牙定位机制
    mk_ct_taskConfigBlePositioningTimeoutOperation,     //配置蓝牙定位超时时间
    mk_ct_taskConfigBlePositioningNumberOfMacOperation,     //配置蓝牙定位mac数量
    
#pragma mark - GPS定位参数配置
    mk_ct_taskConfigGPSFixPositioningTimeoutOperation,      //配置GPS定位超时时间
    mk_ct_taskConfigGPSFixPDOPOperation,                    //配置GPS定位PDOP
    mk_ct_taskConfigOutdoorBLEReportIntervalOperation,      //配置室外蓝牙定位上报间隔
    mk_ct_taskConfigOutdoorGPSReportIntervalOperation,      //配置室外GPS定位上报间隔
    
};
