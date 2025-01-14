//
//  MKCTSDKDataAdopter.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKCTSDKDataAdopter

+ (NSString *)lorawanRegionString:(mk_ct_loraWanRegion)region {
    switch (region) {
        case mk_ct_loraWanRegionAS923:
            return @"00";
        case mk_ct_loraWanRegionAU915:
            return @"01";
        case mk_ct_loraWanRegionEU868:
            return @"05";
        case mk_ct_loraWanRegionKR920:
            return @"06";
        case mk_ct_loraWanRegionIN865:
            return @"07";
        case mk_ct_loraWanRegionUS915:
            return @"08";
        case mk_ct_loraWanRegionRU864:
            return @"09";
        case mk_ct_loraWanRegionAS923_1:
            return @"0a";
        case mk_ct_loraWanRegionAS923_2:
            return @"0b";
        case mk_ct_loraWanRegionAS923_3:
            return @"0c";
        case mk_ct_loraWanRegionAS923_4:
            return @"0d";
    }
}

+ (NSString *)fetchTxPower:(mk_ct_txPower)txPower {
    switch (txPower) {
        case mk_ct_txPower4dBm:
            return @"04";
        case mk_ct_txPower3dBm:
            return @"03";
        case mk_ct_txPower0dBm:
            return @"00";
        case mk_ct_txPowerNeg4dBm:
            return @"fc";
        case mk_ct_txPowerNeg8dBm:
            return @"f8";
        case mk_ct_txPowerNeg12dBm:
            return @"f4";
        case mk_ct_txPowerNeg16dBm:
            return @"f0";
        case mk_ct_txPowerNeg20dBm:
            return @"ec";
        case mk_ct_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

+ (NSString *)fetchDataFormatString:(mk_ct_dataFormat)dataType {
    switch (dataType) {
        case mk_ct_dataFormat_DAS:
            return @"00";
        case mk_ct_dataFormat_Customer:
            return @"01";
    }
}

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        index += subLen * 2;
        [dataList addObject:subContent];
    }
    return dataList;
}

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @[];
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *advNameList = [NSMutableArray array];
    for (NSInteger i = 0; i < contentData.length; i ++) {
        if (index >= contentData.length) {
            break;
        }
        NSData *lenData = [contentData subdataWithRange:NSMakeRange(index, 1)];
        NSString *lenString = [MKBLEBaseSDKAdopter hexStringFromData:lenData];
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:lenString range:NSMakeRange(0, lenString.length)];
        NSData *subData = [contentData subdataWithRange:NSMakeRange(index + 1, subLen)];
        NSString *advName = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
        if (advName) {
            [advNameList addObject:advName];
        }
        index += (subLen + 1);
    }
    return advNameList;
}

+ (NSString *)parseFilterUrlContent:(NSArray <NSData *>*)contentList {
    if (!MKValidArray(contentList)) {
        return @"";
    }
    NSMutableData *contentData = [[NSMutableData alloc] init];
    for (NSInteger i = 0; i < contentList.count; i ++) {
        NSData *tempData = contentList[i];
        if (![tempData isKindOfClass:NSData.class]) {
            return @[];
        }
        [contentData appendData:tempData];
    }
    if (!MKValidData(contentData)) {
        return @"";
    }
    NSString *url = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return (MKValidStr(url) ? url : @"");
}

+ (NSString *)parseOtherRelationship:(NSString *)other {
    if (!MKValidStr(other)) {
        return @"0";
    }
    if ([other isEqualToString:@"00"]) {
        //A
        return @"0";
    }
    if ([other isEqualToString:@"01"]) {
        //A&B
        return @"1";
    }
    if ([other isEqualToString:@"02"]) {
        //A|B
        return @"2";
    }
    if ([other isEqualToString:@"03"]) {
        //A & B & C
        return @"3";
    }
    if ([other isEqualToString:@"04"]) {
        //(A & B) | C
        return @"4";
    }
    if ([other isEqualToString:@"05"]) {
        //A | B | C
        return @"5";
    }
    return @"0";
}

+ (NSArray *)parseOtherFilterConditionList:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    NSInteger index = 0;
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSInteger i = 0; i < content.length; i ++) {
        if (index >= content.length) {
            break;
        }
        NSInteger subLen = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(index, 2)];
        index += 2;
        if (content.length < (index + subLen * 2)) {
            break;
        }
        NSString *subContent = [content substringWithRange:NSMakeRange(index, subLen * 2)];
        
        NSString *type = [subContent substringWithRange:NSMakeRange(0, 2)];
        NSString *start = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(2, 2)];
        NSString *end = [MKBLEBaseSDKAdopter getDecimalStringWithHex:subContent range:NSMakeRange(4, 2)];
        NSString *data = [subContent substringFromIndex:6];
        
        NSDictionary *dataDic = @{
            @"type":type,
            @"start":start,
            @"end":end,
            @"data":(data ? data : @""),
        };
        
        index += subLen * 2;
        [dataList addObject:dataDic];
    }
    return dataList;
}

+ (NSString *)parseOtherRelationshipToCmd:(mk_ct_filterByOther)relationship {
    switch (relationship) {
        case mk_ct_filterByOther_A:
            return @"00";
        case mk_ct_filterByOther_AB:
            return @"01";
        case mk_ct_filterByOther_AOrB:
            return @"02";
        case mk_ct_filterByOther_ABC:
            return @"03";
        case mk_ct_filterByOther_ABOrC:
            return @"04";
        case mk_ct_filterByOther_AOrBOrC:
            return @"05";
    }
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_ct_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_ct_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType)) {
        //新需求，DataType为空等同于00，
        protocol.dataType = @"00";
    }
    if ([protocol.dataType isEqualToString:@"00"]) {
        protocol.minIndex = 0;
        protocol.maxIndex = 0;
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (NSString *)fetchDeviceModeValue:(mk_ct_deviceMode)deviceMode {
    switch (deviceMode) {
        case mk_ct_deviceMode_standbyMode:
            return @"00";
        case mk_ct_deviceMode_periodicMode:
            return @"01";
        case mk_ct_deviceMode_timingMode:
            return @"02";
        case mk_ct_deviceMode_motionMode:
            return @"03";
        case mk_ct_deviceMode_timeSegmentedMode:
            return @"04";
    }
}

+ (NSString *)fetchPositioningStrategyCommand:(mk_ct_positioningStrategy)strategy {
    switch (strategy) {
        case mk_ct_positioningStrategy_ble:
            return @"00";
        case mk_ct_positioningStrategy_gps:
            return @"01";
        case mk_ct_positioningStrategy_bleAndGps_1:
            return @"02";
        case mk_ct_positioningStrategy_bleAndGps_2:
            return @"03";
        case mk_ct_positioningStrategy_bleAndGps_3:
            return @"04";
    }
}

+ (NSString *)fetchTimingModeReportingTimePoint:(NSArray <mk_ct_timingModeReportingTimePointProtocol>*)dataList {
    if (dataList.count > 10) {
        return @"";
    }
    if (!MKValidArray(dataList)) {
        return @"00";
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:(2 * dataList.count) byteLen:1];
    NSString *resultString = len;
    for (NSInteger i = 0; i < dataList.count; i ++) {
        id <mk_ct_timingModeReportingTimePointProtocol>data = dataList[i];
        if (data.hour < 0 || data.hour > 23 || data.minuteGear < 0 || data.minuteGear > 59) {
            return @"";
        }
        NSInteger timeValue = 0;
        if (data.hour == 0 && data.minuteGear == 0) {
            timeValue = 1440;
        }else {
            timeValue = 60 * data.hour + data.minuteGear;
        }
        NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:timeValue byteLen:2];
        resultString = [resultString stringByAppendingString:timeString];
    }
    return resultString;
}

+ (NSString *)fetchimeSegmentedModeTimePeriodSetting:(NSArray <mk_ct_timeSegmentedModeTimePeriodSettingProtocol>*)dataList {
    if (dataList.count > 10) {
        return @"";
    }
    if (!MKValidArray(dataList)) {
        return @"00";
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:(8 * dataList.count) byteLen:1];
    NSString *resultString = len;
        
    for (NSInteger i = 0; i < dataList.count; i ++) {
        id <mk_ct_timeSegmentedModeTimePeriodSettingProtocol>data = dataList[i];
        if (data.startHour < 0 || data.startHour > 24 || data.startMinuteGear < 0 || data.startMinuteGear > 59) {
            return @"";
        }
        if (data.endHour < 0 || data.endHour > 24 || data.endMinuteGear < 0 || data.endMinuteGear > 59) {
            return @"";
        }
        if (data.interval < 30 || data.interval > 86400) {
            return @"";
        }
        NSInteger startTimeValue = 0;
        if (data.startHour == 0 && data.startMinuteGear == 0) {
            startTimeValue = 0;
        }else if (data.startHour == 24 && data.startMinuteGear == 0){
            startTimeValue = 1440;
        }else {
            startTimeValue = 60 * data.startHour + data.startMinuteGear;
        }
        NSInteger endTimeValue = 0;
        if (data.endHour == 0 && data.endMinuteGear == 0) {
            endTimeValue = 0;
        }else if (data.endHour == 24 && data.endMinuteGear == 0){
            endTimeValue = 1440;
        }else {
            endTimeValue = 60 * data.endHour + data.endMinuteGear;
        }
        if (startTimeValue > endTimeValue) {
            return @"";
        }
        
        if (i > 0) {
            id <mk_ct_timeSegmentedModeTimePeriodSettingProtocol>previousData = dataList[i - 1];
            NSInteger preEndTimeValue = 0;
            if (previousData.endHour == 0 && previousData.endMinuteGear == 0) {
                preEndTimeValue = 0;
            }else if (previousData.endHour == 24 && previousData.endMinuteGear == 0) {
                preEndTimeValue = 1440;
            }else {
                preEndTimeValue = 60 * previousData.endHour + previousData.endMinuteGear;
            }
            
            if (startTimeValue < preEndTimeValue) {
                return @"";
            }
        }
        
        NSString *startTimeString = [MKBLEBaseSDKAdopter fetchHexValue:startTimeValue byteLen:2];
        NSString *endTimeString = [MKBLEBaseSDKAdopter fetchHexValue:endTimeValue byteLen:2];
        NSString *intervalString = [MKBLEBaseSDKAdopter fetchHexValue:data.interval byteLen:4];
        NSString *timeString = [NSString stringWithFormat:@"%@%@%@",startTimeString,endTimeString,intervalString];
        resultString = [resultString stringByAppendingString:timeString];
    }
    return resultString;
}

+ (NSArray <NSDictionary *>*)parseTimingModeReportingTimePoint:(NSString *)content {
    if (!MKValidStr(content) || content.length < 4) {
        return @[];
    }
    if ([content isEqualToString:@"00"]) {
        return @[];
    }
    NSInteger totalByte = content.length / 4;
    NSMutableArray *tempList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalByte; i ++) {
        NSString *tempString = [content substringWithRange:NSMakeRange(i * 4, 4)];
        NSInteger tempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(0, tempString.length)];
        NSInteger hour = 0;
        NSInteger minuteGear = 0;
        if (tempValue < 1440) {
            //如果是96，表示00:00
            hour = tempValue / 60;
            minuteGear = tempValue % 60;
        }
        [tempList addObject:@{
            @"hour":@(hour),
            @"minuteGear":@(minuteGear),
        }];
    }
    
    return tempList;
}

+ (NSArray <NSDictionary *>*)parseTimeSegmentedModeTimePeriodSetting:(NSString *)content {
    if (!MKValidStr(content) || content.length < 16) {
        return @[];
    }
    if ([content isEqualToString:@"00"]) {
        return @[];
    }
    NSInteger totalByte = content.length / 16;
    NSMutableArray *tempList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalByte; i ++) {
        NSString *tempString = [content substringWithRange:NSMakeRange(i * 16, 16)];
        
        NSInteger startTempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(0, 4)];
        NSInteger startHour = 0;
        NSInteger startMinuteGear = 0;
        if (startTempValue < 1440) {
            startHour = startTempValue / 60;
            startMinuteGear = startTempValue % 60;
        }else if (startTempValue == 1440) {
            startHour = 24;
            startMinuteGear = 0;
        }
        
        NSInteger endTempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(4, 4)];
        NSInteger endHour = 0;
        NSInteger endMinuteGear = 0;
        if (endTempValue < 1440) {
            endHour = endTempValue / 60;
            endMinuteGear = endTempValue % 60;
        }else if (endTempValue == 1440) {
            endHour = 24;
            endMinuteGear = 0;
        }
        
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:tempString range:NSMakeRange(8, 8)];
        
        
        
        [tempList addObject:@{
            @"startHour":@(startHour),
            @"startMinuteGear":@(startMinuteGear),
            @"endHour":@(endHour),
            @"endMinuteGear":@(endMinuteGear),
            @"reportInterval":interval,
        }];
    }
    
    return tempList;
}

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content {
    NSString *highBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
    BOOL broadcast = [[highBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
    BOOL LowPower = [[highBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    
    NSString *lowBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
    BOOL charging = [[lowBinary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    BOOL fullCharge = [[lowBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
    BOOL networkCheck = [[lowBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
    BOOL failToFix = [[lowBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
    BOOL fixSuccessful = [[lowBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
    BOOL inFix = [[lowBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
    BOOL deviceState = [[lowBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    
    
    return @{
        @"charging":@(charging),
        @"fullCharge":@(fullCharge),
        @"lowPower":@(LowPower),
        @"networkCheck":@(networkCheck),
        @"inFix":@(inFix),
        @"fixSuccessful":@(fixSuccessful),
        @"failToFix":@(failToFix),
        @"broadcast":@(broadcast),
        @"deviceState":@(deviceState)
    };
}

+ (NSString *)parseIndicatorSettingsCommand:(id <mk_ct_indicatorSettingsProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_ct_indicatorSettingsProtocol)]) {
        return @"";
    }
    NSString *DeviceState = (protocol.DeviceState ? @"1" : @"0");
    NSString *LowPower = (protocol.LowPower ? @"1" : @"0");
    NSString *Charging = (protocol.Charging ? @"1" : @"0");
    NSString *FullCharge = (protocol.FullCharge ? @"1" : @"0");
    NSString *Broadcast = (protocol.Broadcast ? @"1" : @"0");
    NSString *NetworkCheck = (protocol.NetworkCheck ? @"1" : @"0");
    NSString *InFix = (protocol.InFix ? @"1" : @"0");
    NSString *FixSuccessful = (protocol.FixSuccessful ? @"1" : @"0");
    NSString *FailToFix = (protocol.FailToFix ? @"1" : @"0");
    
    NSString *lowBinary = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",Charging,FullCharge,NetworkCheck,FailToFix,FixSuccessful,InFix,@"1",DeviceState];
    NSString *lowByte = [MKBLEBaseSDKAdopter getHexByBinary:lowBinary];
    
    NSString *hightBinary = [NSString stringWithFormat:@"%@%@%@",@"000000",Broadcast,LowPower];
    NSString *highByte = [MKBLEBaseSDKAdopter getHexByBinary:hightBinary];
    
    return [highByte stringByAppendingString:lowByte];
}

+ (NSString *)fetchLRPositioningSystemString:(mk_ct_positioningSystem)system {
    switch (system) {
        case mk_ct_positioningSystem_GPS:
            return @"00";
        case mk_ct_positioningSystem_Beidou:
            return @"01";
        case mk_ct_positioningSystem_GPSAndBeidou:
            return @"02";
    }
}

+ (NSString *)fetchBluetoothFixMechanismString:(mk_ct_bluetoothFixMechanism)priority {
    switch (priority) {
        case mk_ct_bluetoothFixMechanism_timePriority:
            return @"00";
        case mk_ct_bluetoothFixMechanism_rssiPriority:
            return @"01";
    }
}

@end
