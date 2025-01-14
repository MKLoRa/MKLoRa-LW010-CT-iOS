//
//  MKCTTaskAdopter.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKCTOperationID.h"
#import "MKCTSDKDataAdopter.h"

NSString *const mk_ct_totalNumKey = @"mk_ct_totalNumKey";
NSString *const mk_ct_totalIndexKey = @"mk_ct_totalIndexKey";
NSString *const mk_ct_contentKey = @"mk_ct_contentKey";

@implementation MKCTTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_ct_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_ct_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_ct_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_ct_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_ct_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 12) {
            state = [content substringWithRange:NSMakeRange(10, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_ct_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *headerString = [readString substringWithRange:NSMakeRange(0, 2)];
    if ([headerString isEqualToString:@"ee"]) {
        //分包协议
        return [self parsePacketData:readData];
    }
    if (![headerString isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(8, 2)];
    if (readData.length != dataLen + 5) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    NSString *content = [readString substringWithRange:NSMakeRange(10, dataLen * 2)];
    //不分包协议
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parsePacketData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 4)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        NSString *totalNum = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(8, 2)];
        NSString *index = [MKBLEBaseSDKAdopter getDecimalStringWithHex:readString range:NSMakeRange(10, 2)];
        NSInteger len = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(12, 2)];
        if ([index integerValue] >= [totalNum integerValue]) {
            return @{};
        }
        mk_ct_taskOperationID operationID = mk_ct_defaultTaskOperationID;
        
        NSData *subData = [readData subdataWithRange:NSMakeRange(7, len)];
        NSDictionary *resultDic= @{
            mk_ct_totalNumKey:totalNum,
            mk_ct_totalIndexKey:index,
            mk_ct_contentKey:(subData ? subData : [NSData data]),
        };
        if ([cmd isEqualToString:@"041a"]) {
            //读取Adv Name过滤规则
            operationID = mk_ct_taskReadFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:resultDic operationID:operationID];
    }
    if ([flag isEqualToString:@"01"]) {
        //配置
        mk_ct_taskOperationID operationID = mk_ct_defaultTaskOperationID;
        NSString *content = [readString substringWithRange:NSMakeRange(10, 2)];
        BOOL success = [content isEqualToString:@"01"];
        
        if ([cmd isEqualToString:@"041a"]) {
            //配置Adv Name过滤规则
            operationID = mk_ct_taskConfigFilterAdvNameListOperation;
        }
        return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_ct_taskOperationID operationID = mk_ct_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"0015"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_ct_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_ct_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //读取设备心跳间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //读取指示灯功能
        NSDictionary *indicatorSettings = [MKCTSDKDataAdopter fetchIndicatorSettings:content];
        resultDic = @{
            @"indicatorSettings":indicatorSettings,
        };
        operationID = mk_ct_taskReadIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //读取霍尔关机功能
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ct_taskReadHallPowerOffStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //读取关机信息上报
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ct_taskReadShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0027"]) {
        //读取蜂鸣器声效选择
        resultDic = @{
            @"buzzer":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBuzzerSoundTypeOperation;
    }else if ([cmd isEqualToString:@"0028"]) {
        //读取三轴唤醒条件
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_ct_taskReadThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"0029"]) {
        //读取运动检测判断
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *duration = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"threshold":threshold,
            @"duration":duration,
        };
        operationID = mk_ct_taskReadThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"0040"]) {
        //读取电池电压
        resultDic = @{
            @"voltage":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"0041"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_ct_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"0042"]) {
        //读取自检故障原因
//        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":content,
        };
        operationID = mk_ct_taskReadSelftestStatusOperation;
    }else if ([cmd isEqualToString:@"0043"]) {
        //读取温度
        NSString *temperature = [NSString stringWithFormat:@"%@",[MKBLEBaseSDKAdopter signedHexTurnString:content]];
        resultDic = @{
            @"temperature":temperature,
        };
        operationID = mk_ct_taskReadTemperatureOperation;
    }else if ([cmd isEqualToString:@"0044"]) {
        //读取光照
        NSString *intensity = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"intensity":intensity,
        };
        operationID = mk_ct_taskReadLightIlluminationIntensityOperation;
    }else if ([cmd isEqualToString:@"0103"]) {
        //读取所有周期电池电量消耗
        NSString *workTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *advCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 8)];
        NSString *axisWakeupTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(16, 8)];
        NSString *blePostionTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(24, 8)];
        NSString *gpsPostionTimes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 8)];
        NSString *loraSendCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(40, 8)];
        NSString *loraPowerConsumption = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(48, 8)];
        NSString *batteryPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(56, 8)];
        NSString *staticPositionCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(64, 8)];
        NSString *movePositionCount = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(72, 8)];
        
        resultDic = @{
            @"workTimes":workTimes,
            @"advCount":advCount,
            @"axisWakeupTimes":axisWakeupTimes,
            @"blePostionTimes":blePostionTimes,
            @"gpsPostionTimes":gpsPostionTimes,
            @"loraSendCount":loraSendCount,
            @"loraPowerConsumption":loraPowerConsumption,
            @"batteryPower":batteryPower,
            @"staticPositionCount":staticPositionCount,
            @"movePositionCount":movePositionCount
        };
        operationID = mk_ct_taskReadAllCycleBatteryInformationOperation;
    }else if ([cmd isEqualToString:@"0104"]) {
        //读取低电百分比
        resultDic = @{
            @"prompt":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //读取低电触发心跳开关状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ct_taskReadLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //读取低电状态下低电信息包上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"0108"]) {
        //读取充电自动开机功能
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_ct_taskReadAutoPowerOnAfterChargingOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"00"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_ct_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_ct_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //读取广播超时时长
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //读取Beacon模式开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //读取设备Tx Power
        NSString *txPower = [MKCTSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_ct_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_ct_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0300"]) {
        //读取工作模式
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":mode,
        };
        operationID = mk_ct_taskReadWorkModeOperation;
    }else if ([cmd isEqualToString:@"0310"]) {
        //读取待机模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadStandbyModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0320"]) {
        //读取定期模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0321"]) {
        //读取定期模式上报间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_ct_taskReadPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0330"]) {
        //读取定时模式定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0331"]) {
        //读取定时模式时间点
        NSArray *list = [MKCTSDKDataAdopter parseTimingModeReportingTimePoint:content];
        
        resultDic = @{
            @"pointList":list,
        };
        operationID = mk_ct_taskReadTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"0340"]) {
        //读取运动模式-运动开始事件信息开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsNotifyEventOnStartOperation;
    }else if ([cmd isEqualToString:@"0341"]) {
        //读取运动模式-运动开始定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsFixOnStartOperation;
    }else if ([cmd isEqualToString:@"0342"]) {
        //读取运动开始定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"0343"]) {
        //读取运动开始定位上报次数
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_ct_taskReadMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"0350"]) {
        //读取运动模式-运动中事件信息开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsNotifyEventInTripOperation;
    }else if ([cmd isEqualToString:@"0351"]) {
        //读取运动模式-运动中定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsFixInTripOperation;
    }else if ([cmd isEqualToString:@"0352"]) {
        //读取运动中定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"0353"]) {
        //读取运动中定位间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_ct_taskReadMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"0360"]) {
        //读取运动模式-运动结束事件信息开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsNotifyEventOnEndOperation;
    }else if ([cmd isEqualToString:@"0361"]) {
        //读取运动模式-运动结束定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsFixOnEndOperation;
    }else if ([cmd isEqualToString:@"0362"]) {
        //读取运动结束定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"0363"]) {
        //读取运动结束定位间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"0364"]) {
        //读取运动结束定位次数
        NSString *number = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"number":number,
        };
        operationID = mk_ct_taskReadMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"0365"]) {
        //读取运动结束判断时间
        NSString *time = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"time":time,
        };
        operationID = mk_ct_taskReadMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"0370"]) {
        //读取运动模式-静止定位开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadMotionModeEventsFixOnStationaryStateOperation;
    }else if ([cmd isEqualToString:@"0371"]) {
        //读取运动静止状态定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadPosStrategyOnStationaryOperation;
    }else if ([cmd isEqualToString:@"0372"]) {
        //读取运动禁止状态上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadReportIntervalOnStationaryOperation;
    }else if ([cmd isEqualToString:@"0380"]) {
        //读取定时+定期模式-定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadTimeSegmentedModeStrategyOperation;
    }else if ([cmd isEqualToString:@"0381"]) {
        //读取定时+定期模式-定时时间段
        NSArray *list = [MKCTSDKDataAdopter parseTimeSegmentedModeTimePeriodSetting:content];
        
        resultDic = @{
            @"timeList":list,
        };
        operationID = mk_ct_taskReadTimeSegmentedModeTimePeriodSettingOperation;
    }else if ([cmd isEqualToString:@"0401"]) {
        //读取RSSI过滤规则
        resultDic = @{
            @"rssi":[NSString stringWithFormat:@"%ld",(long)[[MKBLEBaseSDKAdopter signedHexTurnString:content] integerValue]],
        };
        operationID = mk_ct_taskReadRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"0402"]) {
        //读取广播内容过滤逻辑
        resultDic = @{
            @"relationship":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"0403"]) {
        //读取过滤设备类型开关
        BOOL other = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL iBeacon = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL uid = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL url = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        BOOL tlm = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        BOOL bxp_acc = ([[content substringWithRange:NSMakeRange(10, 2)] isEqualToString:@"01"]);
        BOOL bxp_th = ([[content substringWithRange:NSMakeRange(12, 2)] isEqualToString:@"01"]);
        BOOL bxp_ts = ([[content substringWithRange:NSMakeRange(14, 2)] isEqualToString:@"01"]);
        BOOL bxp_deviceInfo = ([[content substringWithRange:NSMakeRange(16, 2)] isEqualToString:@"01"]);
        BOOL bxp_button = ([[content substringWithRange:NSMakeRange(18, 2)] isEqualToString:@"01"]);
        BOOL bxp_pir = ([[content substringWithRange:NSMakeRange(20, 2)] isEqualToString:@"01"]);
        BOOL bxp_tof = ([[content substringWithRange:NSMakeRange(22, 2)] isEqualToString:@"01"]);
        BOOL bxp_beacon = ([[content substringWithRange:NSMakeRange(24, 2)] isEqualToString:@"01"]);
        
        resultDic = @{
            @"other":@(other),
            @"iBeacon":@(iBeacon),
            @"uid":@(uid),
            @"url":@(url),
            @"tlm":@(tlm),
            @"bxp_acc":@(bxp_acc),
            @"bxp_th":@(bxp_th),
            @"bxp_ts":@(bxp_ts),
            @"bxp_deviceInfo":@(bxp_deviceInfo),
            @"bxp_button":@(bxp_button),
            @"bxp_pir":@(bxp_pir),
            @"bxp_tof":@(bxp_tof),
            @"bxp_beacon":@(bxp_beacon),
        };
        operationID = mk_ct_taskReadFilterTypeStatusOperation;
    }else if ([cmd isEqualToString:@"0410"]) {
        //读取精准过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0411"]) {
        //读取反向过滤MAC开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0412"]) {
        //读取MAC过滤列表
        NSArray *macList = [MKCTSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"macList":(MKValidArray(macList) ? macList : @[]),
        };
        operationID = mk_ct_taskReadFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"0418"]) {
        //读取精准过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0419"]) {
        //读取反向过滤Adv Name开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0420"]) {
        //读取iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0421"]) {
        //读取iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0422"]) {
        //读取iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"0423"]) {
        //读取iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_ct_taskReadFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0428"]) {
        //读取UID类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"0429"]) {
        //读取UID类型过滤的Namespace ID
        resultDic = @{
            @"namespaceID":content,
        };
        operationID = mk_ct_taskReadFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"042a"]) {
        //读取UID类型过滤的Instance ID
        resultDic = @{
            @"instanceID":content,
        };
        operationID = mk_ct_taskReadFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"0430"]) {
        //读取URL类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"0431"]) {
        //读取URL类型过滤内容
        NSString *url = @"";
        if (content.length > 0) {
            NSData *urlData = [data subdataWithRange:NSMakeRange(5, data.length - 5)];
            url = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        }
        resultDic = @{
            @"url":(MKValidStr(url) ? url : @""),
        };
        operationID = mk_ct_taskReadFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"0438"]) {
        //读取TLM类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"0439"]) {
        //读取TLM过滤数据类型
        NSString *version = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"version":version
        };
        operationID = mk_ct_taskReadFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"0440"]) {
        //读取BXP-iBeacon类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0441"]) {
        //读取BXP-iBeacon类型过滤的Major范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByBXPBeaconMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0442"]) {
        //读取BXP-iBeacon类型过滤的Minor范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByBXPBeaconMinorRangeOperation;
    }else if ([cmd isEqualToString:@"0443"]) {
        //读取BXP-iBeacon类型过滤的UUID
        resultDic = @{
            @"uuid":content,
        };
        operationID = mk_ct_taskReadFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0450"]) {
        //读取BeaconX Pro-ACC设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0458"]) {
        //读取BeaconX Pro-T&H设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0460"]) {
        //读取BXP-DeviceInfo类型过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBXPDeviceInfoFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0468"]) {
        //读取BXP-Button过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBXPButtonFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0469"]) {
        //读取BXP-Button报警过滤开关
        
        BOOL singlePresse = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL doublePresse = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        BOOL longPresse = ([[content substringWithRange:NSMakeRange(4, 2)] isEqualToString:@"01"]);
        BOOL abnormal = ([[content substringWithRange:NSMakeRange(6, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"singlePresse":@(singlePresse),
            @"doublePresse":@(doublePresse),
            @"longPresse":@(longPresse),
            @"abnormal":@(abnormal),
        };
        operationID = mk_ct_taskReadBXPButtonAlarmFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0470"]) {
        //读取BXP-T&S TagID类型开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0471"]) {
        //读取BXP-T&S TagID类型精准过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0472"]) {
        //读取读取BXP-T&S TagID类型反向过滤tagID开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0473"]) {
        //读取BXP-T&S TagID过滤规则
        NSArray *tagIDList = [MKCTSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"tagIDList":(MKValidArray(tagIDList) ? tagIDList : @[]),
        };
        operationID = mk_ct_taskReadFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"0478"]) {
        //读取BXP-TOF设备过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterBXPTofStatusOperation;
    }else if ([cmd isEqualToString:@"0479"]) {
        //读取BXP-TOF设备过滤MFG code
        NSArray *codeList = [MKCTSDKDataAdopter parseFilterMacList:content];
        resultDic = @{
            @"codeList":(MKValidArray(codeList) ? codeList : @[]),
        };
        operationID = mk_ct_taskReadFilterBXPTofMfgCodeListOperation;
    }else if ([cmd isEqualToString:@"0480"]) {
        //读取PIR过滤开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"0481"]) {
        //读取PIR设备过滤sensor_detection_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_ct_taskReadFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0482"]) {
        //读取PIR设备过滤sensor_sensitivity
        NSString *sensitivity = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"sensitivity":sensitivity,
        };
        operationID = mk_ct_taskReadFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"0483"]) {
        //读取PIR设备过滤door_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_ct_taskReadFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"0484"]) {
        //读取PIR设备过滤delay_response_status
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_ct_taskReadFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"0485"]) {
        //读取PIR设备Major过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByPirMajorRangeOperation;
    }else if ([cmd isEqualToString:@"0486"]) {
        //读取PIR设备Minor过滤范围
        NSString *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 4)];
        NSString *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 4)];
        resultDic = @{
            @"maxValue":maxValue,
            @"minValue":minValue,
        };
        operationID = mk_ct_taskReadFilterByPirMinorRangeOperation;
    }else if ([cmd isEqualToString:@"04f8"]) {
        //读取Other过滤条件开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"04f9"]) {
        //读取Other过滤条件的逻辑关系
        NSString *relationship = [MKCTSDKDataAdopter parseOtherRelationship:content];
        resultDic = @{
            @"relationship":relationship,
        };
        operationID = mk_ct_taskReadFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"04fa"]) {
        //读取Other的过滤条件列表
        NSArray *conditionList = [MKCTSDKDataAdopter parseOtherFilterConditionList:content];
        resultDic = @{
            @"conditionList":conditionList,
        };
        operationID = mk_ct_taskReadFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"0500"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_ct_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_ct_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_ct_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_ct_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_ct_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_ct_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //读取ADR_ACK_LIMIT
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //读取ADR_ACK_DELAY
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_ct_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_ct_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0550"]) {
        //读取设备信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadDeviceInfoPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //读取心跳数据包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadHeartbeatPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //读取低电包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadLowPowerPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //读取事件信息包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadEventPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0555"]) {
        //读取定位包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadPositioningPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0557"]) {
        //读取震动检测包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadShockPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0558"]) {
        //读取闲置检测包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadManDownDetectionPayloadDataOperation;
    }else if ([cmd isEqualToString:@"055b"]) {
        //读取GPS极限定位包上行配置
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"retransmissionTimes":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_ct_taskReadGPSLimitPayloadDataOperation;
    }else if ([cmd isEqualToString:@"0600"]) {
        //读取下行请求定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadDownlinkPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0610"]) {
        //读取震动检测开关状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadShockDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0611"]) {
        //读取震动检测阈值
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"threshold":threshold,
        };
        operationID = mk_ct_taskReadShockThresholdsOperation;
    }else if ([cmd isEqualToString:@"0612"]) {
        //读取震动上发间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadShockDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0613"]) {
        //读取震动次数判断间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadShockTimeoutOperation;
    }else if ([cmd isEqualToString:@"0640"]) {
        //读取光照监测开关
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL isOn = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL alarmSwicth = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"isOn":@(isOn),
            @"alarmSwicth":@(alarmSwicth)
        };
        operationID = mk_ct_taskReadLightMonitorNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0641"]) {
        //读取光照数据采样间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_ct_taskReadLightDataSampleRateIntervalOperation;
    }else if ([cmd isEqualToString:@"0642"]) {
        //读取光照阈值
        NSString *threshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"threshold":threshold,
        };
        operationID = mk_ct_taskReadLightThresholdOperation;
    }else if ([cmd isEqualToString:@"0650"]) {
        //读取温度监测开关
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL isOn = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL alarmSwicth = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"isOn":@(isOn),
            @"alarmSwicth":@(alarmSwicth)
        };
        operationID = mk_ct_taskReadTemperatureMonitorNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0651"]) {
        //读取温度数据采样间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_ct_taskReadTemperatureDataSampleRateIntervalOperation;
    }else if ([cmd isEqualToString:@"0652"]) {
        //读取温度阈值
        NSString *min = [NSString stringWithFormat:@"%@",[MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(0, 2)]]];
        NSString *max = [NSString stringWithFormat:@"%@",[MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(2, 2)]]];
        resultDic = @{
            @"min":min,
            @"max":max
        };
        operationID = mk_ct_taskReadTemperatureThresholdOperation;
    }else if ([cmd isEqualToString:@"0660"]) {
        //读取报警类型选择
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadAlarmTypeOperation;
    }else if ([cmd isEqualToString:@"0661"]) {
        //读取退出报警按键时长
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadExitAlarmTypeTimeOperation;
    }else if ([cmd isEqualToString:@"0662"]) {
        //读取Alert报警触发按键模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadAlertAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"0663"]) {
        //读取Alert报警定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadAlertAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0664"]) {
        //读取Alert报警事件通知
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL start = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_ct_taskReadAlertAlarmNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0665"]) {
        //读取SOS报警触发按键模式
        resultDic = @{
            @"mode":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadSosAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"0666"]) {
        //读取SOS报警定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadSosAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0667"]) {
        //读取SOS报警数据上报时间间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_ct_taskReadSosAlarmReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0668"]) {
        //读取SOS报警事件通知
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL start = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL end = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"start":@(start),
            @"end":@(end)
        };
        operationID = mk_ct_taskReadSosAlarmNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0670"]) {
        //读取闲置功能使能
        NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:content];
        
        BOOL isOn = ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]);
        BOOL notifyEventOnManDownStart = ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]);
        BOOL notifyEventOnManDownEnd = ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]);
        resultDic = @{
            @"isOn":@(isOn),
            @"notifyEventOnManDownStart":@(notifyEventOnManDownStart),
            @"notifyEventOnManDownEnd":@(notifyEventOnManDownEnd)
        };
        operationID = mk_ct_taskReadManDownDetectionOperation;
    }else if ([cmd isEqualToString:@"0671"]) {
        //读取Man Down检测超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadManDownDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"0672"]) {
        //读取Man Down定位策略
        NSString *strategy = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"strategy":strategy,
        };
        operationID = mk_ct_taskReadManDownDetectionStrategyOperation;
    }else if ([cmd isEqualToString:@"0673"]) {
        //读取Man Down的定位数据上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadManDownDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0801"]) {
        //读取GPS极限上传开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadGpsLimitUploadStatusOperation;
    }else if ([cmd isEqualToString:@"0808"]) {
        //读取室外蓝牙定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadOutdoorBLEReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0809"]) {
        //读取室外GPS定位上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadOutdoorGPSReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0820"]) {
        //读取蓝牙定位机制
        resultDic = @{
            @"priority":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBluetoothFixMechanismOperation;
    }else if ([cmd isEqualToString:@"0821"]) {
        //读取蓝牙定位超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"0822"]) {
        //读取蓝牙定位MAC数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"0823"]) {
        //读取蓝牙beacon电压上报开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_ct_taskReadBeaconVoltageReportInBleFixOperation;
    }else if ([cmd isEqualToString:@"0830"]) {
        //读取GPS定位超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadGPSFixPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"0831"]) {
        //读取GPS定位PDOP
        resultDic = @{
            @"pdop":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_ct_taskReadGPSFixPDOPOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_ct_taskOperationID operationID = mk_ct_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"0000"]) {
        //关机
        operationID = mk_ct_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"0001"]) {
        //配置LoRaWAN 入网
        operationID = mk_ct_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"0002"]) {
        //恢复出厂设置
        operationID = mk_ct_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"0020"]) {
        //配置时间戳
        operationID = mk_ct_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"0021"]) {
        //配置时区
        operationID = mk_ct_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"0022"]) {
        //配置设备心跳间隔
        operationID = mk_ct_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0023"]) {
        //配置指示灯开关状态
        operationID = mk_ct_taskConfigIndicatorSettingsOperation;
    }else if ([cmd isEqualToString:@"0025"]) {
        //配置霍尔关机功能
        operationID = mk_ct_taskConfigHallPowerOffStatusOperation;
    }else if ([cmd isEqualToString:@"0026"]) {
        //配置关机信息上报状态
        operationID = mk_ct_taskConfigShutdownPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0027"]) {
        //配置蜂鸣器声效选择
        operationID = mk_ct_taskConfigBuzzerSoundTypeOperation;
    }else if ([cmd isEqualToString:@"0028"]) {
        //配置三轴唤醒条件
        operationID = mk_ct_taskConfigThreeAxisWakeupConditionsOperation;
    }else if ([cmd isEqualToString:@"0029"]) {
        //配置运动检测判断
        operationID = mk_ct_taskConfigThreeAxisMotionParametersOperation;
    }else if ([cmd isEqualToString:@"0100"]) {
        //清除电池电量数据
        operationID = mk_ct_taskBatteryResetOperation;
    }else if ([cmd isEqualToString:@"0104"]) {
        //配置低电百分比
        operationID = mk_ct_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"0106"]) {
        //配置低电触发心跳开关状态
        operationID = mk_ct_taskConfigLowPowerPayloadStatusOperation;
    }else if ([cmd isEqualToString:@"0107"]) {
        //配置低电状态下低电信息包上报间隔
        operationID = mk_ct_taskConfigLowPowerPayloadIntervalOperation;
    }else if ([cmd isEqualToString:@"0108"]) {
        //配置充电自动开机功能
        operationID = mk_ct_taskConfigAutoPowerOnAfterChargingOperation;
    }else if ([cmd isEqualToString:@"0200"]) {
        //配置是否需要连接密码
        operationID = mk_ct_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"0201"]) {
        //配置连接密码
        operationID = mk_ct_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"0202"]) {
        //配置蓝牙广播超时时间
        operationID = mk_ct_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"0203"]) {
        //配置Beacon模式开关
        operationID = mk_ct_taskConfigBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0204"]) {
        //配置广播间隔
        operationID = mk_ct_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"0205"]) {
        //配置蓝牙TX Power
        operationID = mk_ct_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"0206"]) {
        //配置蓝牙广播名称
        operationID = mk_ct_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"0300"]) {
        //配置工作模式
        operationID = mk_ct_taskConfigWorkModeOperation;
    }else if ([cmd isEqualToString:@"0310"]) {
        //配置待机模式定位策略
        operationID = mk_ct_taskConfigStandbyModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0320"]) {
        //设置定期模式定位策略
        operationID = mk_ct_taskConfigPeriodicModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0321"]) {
        //设置定期模式上报间隔
        operationID = mk_ct_taskConfigPeriodicModeReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0330"]) {
        //设置定时模式定位策略
        operationID = mk_ct_taskConfigTimingModePositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0331"]) {
        //设置定时模式时间点
        operationID = mk_ct_taskConfigTimingModeReportingTimePointOperation;
    }else if ([cmd isEqualToString:@"0340"]) {
        //配置运动模式-运动开始事件信息开关
        operationID = mk_ct_taskConfigMotionModeEventsNotifyEventOnStartOperation;
    }else if ([cmd isEqualToString:@"0341"]) {
        //配置运动模式-运动开始定位开关
        operationID = mk_ct_taskConfigMotionModeEventsFixOnStartOperation;
    }else if ([cmd isEqualToString:@"0342"]) {
        //设置运动开始定位策略
        operationID = mk_ct_taskConfigMotionModePosStrategyOnStartOperation;
    }else if ([cmd isEqualToString:@"0343"]) {
        //设置运动开始定位上报次数
        operationID = mk_ct_taskConfigMotionModeNumberOfFixOnStartOperation;
    }else if ([cmd isEqualToString:@"0350"]) {
        //配置运动模式-运动中事件信息开关
        operationID = mk_ct_taskConfigMotionModeEventsNotifyEventInTripOperation;
    }else if ([cmd isEqualToString:@"0351"]) {
        //配置运动模式-运动中定位开关
        operationID = mk_ct_taskConfigMotionModeEventsFixInTripOperation;
    }else if ([cmd isEqualToString:@"0352"]) {
        //设置运动中定位策略
        operationID = mk_ct_taskConfigMotionModePosStrategyInTripOperation;
    }else if ([cmd isEqualToString:@"0353"]) {
        //设置运动中定位间隔
        operationID = mk_ct_taskConfigMotionModeReportIntervalInTripOperation;
    }else if ([cmd isEqualToString:@"0360"]) {
        //配置运动模式-运动结束事件信息开关
        operationID = mk_ct_taskConfigMotionModeEventsNotifyEventOnEndOperation;
    }else if ([cmd isEqualToString:@"0361"]) {
        //配置运动模式-运动结束定位开关
        operationID = mk_ct_taskConfigMotionModeEventsFixOnEndOperation;
    }else if ([cmd isEqualToString:@"0362"]) {
        //设置运动结束定位策略
        operationID = mk_ct_taskConfigMotionModePosStrategyOnEndOperation;
    }else if ([cmd isEqualToString:@"0363"]) {
        //设置运动结束定位间隔
        operationID = mk_ct_taskConfigMotionModeReportIntervalOnEndOperation;
    }else if ([cmd isEqualToString:@"0364"]) {
        //设置运动结束定位次数
        operationID = mk_ct_taskConfigMotionModeNumberOfFixOnEndOperation;
    }else if ([cmd isEqualToString:@"0365"]) {
        //设置运动结束判断时间
        operationID = mk_ct_taskConfigMotionModeTripEndTimeoutOperation;
    }else if ([cmd isEqualToString:@"0370"]) {
        //配置运动模式-静止定位开关
        operationID = mk_ct_taskConfigMotionModeEventsFixOnStationaryStateOperation;
    }else if ([cmd isEqualToString:@"0371"]) {
        //配置运动静止状态定位策略
        operationID = mk_ct_taskConfigPosStrategyOnStationaryOperation;
    }else if ([cmd isEqualToString:@"0372"]) {
        //配置运动禁止状态上报间隔
        operationID = mk_ct_taskConfigReportIntervalOnStationaryOperation;
    }else if ([cmd isEqualToString:@"0380"]) {
        //配置定时+定期模式-定位策略
        operationID = mk_ct_taskConfigTimeSegmentedModeStrategyOperation;
    }else if ([cmd isEqualToString:@"0381"]) {
        //定时+定期模式-定时时间段
        operationID = mk_ct_taskConfigTimeSegmentedModeTimePeriodSettingOperation;
    }else if ([cmd isEqualToString:@"0401"]) {
        //配置rssi过滤规则
        operationID = mk_ct_taskConfigRssiFilterValueOperation;
    }else if ([cmd isEqualToString:@"0402"]) {
        //配置广播内容过滤逻辑
        operationID = mk_ct_taskConfigFilterRelationshipOperation;
    }else if ([cmd isEqualToString:@"0410"]) {
        //配置精准过滤MAC开关
        operationID = mk_ct_taskConfigFilterByMacPreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0411"]) {
        //配置反向过滤MAC开关
        operationID = mk_ct_taskConfigFilterByMacReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0412"]) {
        //配置MAC过滤规则
        operationID = mk_ct_taskConfigFilterMACAddressListOperation;
    }else if ([cmd isEqualToString:@"0418"]) {
        //配置精准过滤Adv Name开关
        operationID = mk_ct_taskConfigFilterByAdvNamePreciseMatchOperation;
    }else if ([cmd isEqualToString:@"0419"]) {
        //配置反向过滤Adv Name开关
        operationID = mk_ct_taskConfigFilterByAdvNameReverseFilterOperation;
    }else if ([cmd isEqualToString:@"0420"]) {
        //配置iBeacon类型过滤开关
        operationID = mk_ct_taskConfigFilterByBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0421"]) {
        //配置iBeacon类型过滤Major范围
        operationID = mk_ct_taskConfigFilterByBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"0422"]) {
        //配置iBeacon类型过滤Minor范围
        operationID = mk_ct_taskConfigFilterByBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"0423"]) {
        //配置iBeacon类型过滤UUID
        operationID = mk_ct_taskConfigFilterByBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0428"]) {
        //配置UID类型过滤开关
        operationID = mk_ct_taskConfigFilterByUIDStatusOperation;
    }else if ([cmd isEqualToString:@"0429"]) {
        //配置UID类型过滤Namespace ID.
        operationID = mk_ct_taskConfigFilterByUIDNamespaceIDOperation;
    }else if ([cmd isEqualToString:@"042a"]) {
        //配置UID类型过滤Instace ID.
        operationID = mk_ct_taskConfigFilterByUIDInstanceIDOperation;
    }else if ([cmd isEqualToString:@"0430"]) {
        //配置URL类型过滤开关
        operationID = mk_ct_taskConfigFilterByURLStatusOperation;
    }else if ([cmd isEqualToString:@"0431"]) {
        //配置URL类型过滤的内容
        operationID = mk_ct_taskConfigFilterByURLContentOperation;
    }else if ([cmd isEqualToString:@"0438"]) {
        //配置TLM类型开关
        operationID = mk_ct_taskConfigFilterByTLMStatusOperation;
    }else if ([cmd isEqualToString:@"0439"]) {
        //配置TLM过滤数据类型
        operationID = mk_ct_taskConfigFilterByTLMVersionOperation;
    }else if ([cmd isEqualToString:@"0440"]) {
        //配置BXP-iBeacon类型过滤开关
        operationID = mk_ct_taskConfigFilterByBXPBeaconStatusOperation;
    }else if ([cmd isEqualToString:@"0441"]) {
        //配置BXP-iBeacon类型过滤Major范围
        operationID = mk_ct_taskConfigFilterByBXPBeaconMajorOperation;
    }else if ([cmd isEqualToString:@"0442"]) {
        //配置BXP-iBeacon类型过滤Minor范围
        operationID = mk_ct_taskConfigFilterByBXPBeaconMinorOperation;
    }else if ([cmd isEqualToString:@"0443"]) {
        //配置BXP-iBeacon类型过滤UUID
        operationID = mk_ct_taskConfigFilterByBXPBeaconUUIDOperation;
    }else if ([cmd isEqualToString:@"0450"]) {
        //配置BeaconX Pro-ACC设备过滤开关
        operationID = mk_ct_taskConfigBXPAccFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0458"]) {
        //配置BeaconX Pro-TH设备过滤开关
        operationID = mk_ct_taskConfigBXPTHFilterStatusOperation;
    }else if ([cmd isEqualToString:@"0460"]) {
        //配置BXP-DeviceInfo过滤开关
        operationID = mk_ct_taskConfigFilterByBXPDeviceInfoStatusOperation;
    }else if ([cmd isEqualToString:@"0468"]) {
        //配置BXP-Button过滤开关
        operationID = mk_ct_taskConfigFilterByBXPButtonStatusOperation;
    }else if ([cmd isEqualToString:@"0469"]) {
        //配置BXP-Button类型过滤内容
        operationID = mk_ct_taskConfigFilterByBXPButtonAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"0470"]) {
        //配置BXP-T&S TagID类型过滤开关
        operationID = mk_ct_taskConfigFilterByBXPTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0471"]) {
        //配置BXP-T&S TagID类型精准过滤Tag-ID开关
        operationID = mk_ct_taskConfigPreciseMatchTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0472"]) {
        //配置BXP-T&S TagID类型反向过滤Tag-ID开关
        operationID = mk_ct_taskConfigReverseFilterTagIDStatusOperation;
    }else if ([cmd isEqualToString:@"0473"]) {
        //配置BXP-T&S TagID过滤规则
        operationID = mk_ct_taskConfigFilterBXPTagIDListOperation;
    }else if ([cmd isEqualToString:@"0478"]) {
        //配置BXP-TOF设备过滤开关
        operationID = mk_ct_taskConfigFilterByTofStatusOperation;
    }else if ([cmd isEqualToString:@"0479"]) {
        //配置BXP-TOF设备过滤开关
        operationID = mk_ct_taskConfigFilterBXPTofListOperation;
    }else if ([cmd isEqualToString:@"0480"]) {
        //配置PIR设备过滤开关
        operationID = mk_ct_taskConfigFilterByPirStatusOperation;
    }else if ([cmd isEqualToString:@"0481"]) {
        //配置PIR设备过滤sensor_detection_status
        operationID = mk_ct_taskConfigFilterByPirDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0482"]) {
        //配置PIR设备过滤sensor_sensitivity
        operationID = mk_ct_taskConfigFilterByPirSensorSensitivityOperation;
    }else if ([cmd isEqualToString:@"0483"]) {
        //配置PIR设备过滤door_status
        operationID = mk_ct_taskConfigFilterByPirDoorStatusOperation;
    }else if ([cmd isEqualToString:@"0484"]) {
        //配置PIR设备过滤delay_response_status
        operationID = mk_ct_taskConfigFilterByPirDelayResponseStatusOperation;
    }else if ([cmd isEqualToString:@"0485"]) {
        //配置PIR设备Major过滤范围
        operationID = mk_ct_taskConfigFilterByPirMajorOperation;
    }else if ([cmd isEqualToString:@"0486"]) {
        //配置PIR设备Minor过滤范围
        operationID = mk_ct_taskConfigFilterByPirMinorOperation;
    }else if ([cmd isEqualToString:@"04f8"]) {
        //配置Other过滤关系开关
        operationID = mk_ct_taskConfigFilterByOtherStatusOperation;
    }else if ([cmd isEqualToString:@"04f9"]) {
        //配置Other过滤条件逻辑关系
        operationID = mk_ct_taskConfigFilterByOtherRelationshipOperation;
    }else if ([cmd isEqualToString:@"04fa"]) {
        //配置Other过滤条件列表
        operationID = mk_ct_taskConfigFilterByOtherConditionsOperation;
    }else if ([cmd isEqualToString:@"0501"]) {
        //配置LoRaWAN频段
        operationID = mk_ct_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"0502"]) {
        //配置LoRaWAN入网类型
        operationID = mk_ct_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"0503"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_ct_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"0504"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_ct_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"0505"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_ct_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"0506"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_ct_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"0507"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_ct_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"0508"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_ct_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"050a"]) {
        //配置ADR_ACK_LIMIT
        operationID = mk_ct_taskConfigLorawanADRACKLimitOperation;
    }else if ([cmd isEqualToString:@"050b"]) {
        //配置ADR_ACK_DELAY
        operationID = mk_ct_taskConfigLorawanADRACKDelayOperation;
    }else if ([cmd isEqualToString:@"0520"]) {
        //配置LoRaWAN CH
        operationID = mk_ct_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"0521"]) {
        //配置LoRaWAN DR
        operationID = mk_ct_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"0522"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_ct_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0523"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_ct_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0540"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_ct_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"0541"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_ct_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"0550"]) {
        //配置设备信息包上行配置
        operationID = mk_ct_taskConfigDeviceInfoPayloadOperation;
    }else if ([cmd isEqualToString:@"0551"]) {
        //配置心跳包上行配置
        operationID = mk_ct_taskConfigHeartbeatPayloadOperation;
    }else if ([cmd isEqualToString:@"0552"]) {
        //配置低电包上行配置
        operationID = mk_ct_taskConfigLowPowerPayloadOperation;
    }else if ([cmd isEqualToString:@"0554"]) {
        //配置事件信息包上行配置
        operationID = mk_ct_taskConfigEventPayloadWithMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0555"]) {
        //配置定位包上行配置
        operationID = mk_ct_taskConfigPositioningPayloadOperation;
    }else if ([cmd isEqualToString:@"0557"]) {
        //配置震动检测包上行配置
        operationID = mk_ct_taskConfigShockPayloadOperation;
    }else if ([cmd isEqualToString:@"0558"]) {
        //配置闲置检测包上行配置
        operationID = mk_ct_taskConfigManDownDetectionPayloadOperation;
    }else if ([cmd isEqualToString:@"055b"]) {
        //配置GPS极限定位包上行配置
        operationID = mk_ct_taskConfigGPSLimitPayloadOperation;
    }else if ([cmd isEqualToString:@"0600"]) {
        //配置下行请求定位策略
        operationID = mk_ct_taskConfigDownlinkPositioningStrategyyOperation;
    }else if ([cmd isEqualToString:@"0610"]) {
        //配置震动检测使能
        operationID = mk_ct_taskConfigShockDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0611"]) {
        //配置震动检测阈值
        operationID = mk_ct_taskConfigShockThresholdsOperation;
    }else if ([cmd isEqualToString:@"0612"]) {
        //配置震动上发间隔
        operationID = mk_ct_taskConfigShockDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0613"]) {
        //配置震动次数判断间隔
        operationID = mk_ct_taskConfigShockTimeoutOperation;
    }else if ([cmd isEqualToString:@"0640"]) {
        //配置光照监测开关
        operationID = mk_ct_taskConfigLightMonitorNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0641"]) {
        //配置光照数据采样间隔
        operationID = mk_ct_taskConfigLightDataSampleRateIntervalOperation;
    }else if ([cmd isEqualToString:@"0642"]) {
        //配置光照阈值
        operationID = mk_ct_taskConfigLightThresholdOperation;
    }else if ([cmd isEqualToString:@"0650"]) {
        //配置温度监测开关
        operationID = mk_ct_taskConfigTemperatureMonitorNotifyStatusOperation;
    }else if ([cmd isEqualToString:@"0651"]) {
        //配置温度数据采样间隔
        operationID = mk_ct_taskConfigTemperatureDataSampleRateIntervalOperation;
    }else if ([cmd isEqualToString:@"0652"]) {
        //配置温度阈值
        operationID = mk_ct_taskConfigTemperatureThresholdOperation;
    }else if ([cmd isEqualToString:@"0660"]) {
        //配置报警类型选择
        operationID = mk_ct_taskConfigAlarmTypeOperation;
    }else if ([cmd isEqualToString:@"0661"]) {
        //配置退出报警按键
        operationID = mk_ct_taskConfigExitAlarmTypeTimeOperation;
    }else if ([cmd isEqualToString:@"0662"]) {
        //配置Alert报警触发按键模式
        operationID = mk_ct_taskConfigAlertAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"0663"]) {
        //配置Alert报警定位策略
        operationID = mk_ct_taskConfigAlertAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0664"]) {
        //配置Alert报警事件通知
        operationID = mk_ct_taskConfigAlertAlarmNotifyEventOperation;
    }else if ([cmd isEqualToString:@"0665"]) {
        //配置SOS报警触发按键模式
        operationID = mk_ct_taskConfigSosAlarmTriggerModeOperation;
    }else if ([cmd isEqualToString:@"0666"]) {
        //配置SOS报警定位策略
        operationID = mk_ct_taskConfigSosAlarmPositioningStrategyOperation;
    }else if ([cmd isEqualToString:@"0667"]) {
        //配置SOS报警定位数据上报间隔
        operationID = mk_ct_taskConfigSosAlarmReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0668"]) {
        //配置SOS报警事件通知
        operationID = mk_ct_taskConfigSosAlarmNotifyEventOperation;
    }else if ([cmd isEqualToString:@"0670"]) {
        //配置闲置功能使能
        operationID = mk_ct_taskConfigManDownDetectionStatusOperation;
    }else if ([cmd isEqualToString:@"0671"]) {
        //配置Man Down检测超时时间
        operationID = mk_ct_taskConfigManDownDetectionTimeoutOperation;
    }else if ([cmd isEqualToString:@"0672"]) {
        //配置Man Down定位策略
        operationID = mk_ct_taskConfigManDownPositioningStrategyyOperation;
    }else if ([cmd isEqualToString:@"0673"]) {
        //Man Down的定位数据上报间隔
        operationID = mk_ct_taskConfigManDownDetectionReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0801"]) {
        //配置GPS极限上传开关
        operationID = mk_ct_taskConfigGpsLimitUploadStatusOperation;
    }else if ([cmd isEqualToString:@"0808"]) {
        //配置室外蓝牙定位上报间隔
        operationID = mk_ct_taskConfigOutdoorBLEReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0809"]) {
        //配置室外GPS定位上报间隔
        operationID = mk_ct_taskConfigOutdoorGPSReportIntervalOperation;
    }else if ([cmd isEqualToString:@"0820"]) {
        //配置蓝牙定位机制
        operationID = mk_ct_taskConfigBluetoothFixMechanismOperation;
    }else if ([cmd isEqualToString:@"0821"]) {
        //配置蓝牙定位超时时间
        operationID = mk_ct_taskConfigBlePositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"0822"]) {
        //配置蓝牙定位mac数量
        operationID = mk_ct_taskConfigBlePositioningNumberOfMacOperation;
    }else if ([cmd isEqualToString:@"0823"]) {
        //配置蓝牙beacon电压上报开关
        operationID = mk_ct_taskConfigBeaconVoltageReportInBleFixStatusOperation;
    }else if ([cmd isEqualToString:@"0830"]) {
        //配置GPS定位超时时间
        operationID = mk_ct_taskConfigGPSFixPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"0831"]) {
        //配置GPS定位PDOP
        operationID = mk_ct_taskConfigGPSFixPDOPOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_ct_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
