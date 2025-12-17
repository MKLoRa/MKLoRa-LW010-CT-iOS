//
//  MKCTCentralManager.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTCentralManager.h"

#import "MKBLEBaseCentralManager.h"
#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseLogManager.h"

#import "MKCTPeripheral.h"
#import "MKCTOperation.h"
#import "CBPeripheral+MKCTAdd.h"

static NSString *const mk_ct_logName = @"mk_ct_bleLog";

NSString *const mk_ct_peripheralConnectStateChangedNotification = @"mk_ct_peripheralConnectStateChangedNotification";
NSString *const mk_ct_centralManagerStateChangedNotification = @"mk_ct_centralManagerStateChangedNotification";

NSString *const mk_ct_deviceDisconnectTypeNotification = @"mk_ct_deviceDisconnectTypeNotification";

static MKCTCentralManager *manager = nil;
static dispatch_once_t onceToken;

//@interface NSObject (MKCTCentralManager)
//
//@end
//
//@implementation NSObject (MKCTCentralManager)
//
//+ (void)load{
//    [MKCTCentralManager shared];
//}
//
//@end

@interface MKCTCentralManager ()

@property (nonatomic, copy)NSString *password;

@property (nonatomic, copy)void (^sucBlock)(CBPeripheral *peripheral);

@property (nonatomic, copy)void (^failedBlock)(NSError *error);

@property (nonatomic, assign)mk_ct_centralConnectStatus connectStatus;

@end

@implementation MKCTCentralManager

- (void)dealloc {
    [self logToLocal:@"MKCTCentralManager销毁"];
    NSLog(@"MKCTCentralManager销毁");
}

- (instancetype)init {
    if (self = [super init]) {
        [self logToLocal:@"MKCTCentralManager初始化"];
        [[MKBLEBaseCentralManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKCTCentralManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKCTCentralManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    [MKBLEBaseCentralManager singleDealloc];
    manager = nil;
    onceToken = 0;
}

+ (void)removeFromCentralList {
    [[MKBLEBaseCentralManager shared] removeDataManager:manager];
    manager = nil;
    onceToken = 0;
}

#pragma mark - MKBLEBaseScanProtocol
- (void)MKBLEBaseCentralManagerDiscoverPeripheral:(CBPeripheral *)peripheral
                                advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                                             RSSI:(NSNumber *)RSSI {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",advertisementData);
        NSDictionary *dataModel = [self parseModelWithRssi:RSSI advDic:advertisementData peripheral:peripheral];
        if (!MKValidDict(dataModel)) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(mk_ct_receiveDevice:)]) {
                [self.delegate mk_ct_receiveDevice:dataModel];
            }
        });
    });
}

- (void)MKBLEBaseCentralManagerStartScan {
    [self logToLocal:@"开始扫描"];
    if ([self.delegate respondsToSelector:@selector(mk_ct_startScan)]) {
        [self.delegate mk_ct_startScan];
    }
}

- (void)MKBLEBaseCentralManagerStopScan {
    [self logToLocal:@"停止扫描"];
    if ([self.delegate respondsToSelector:@selector(mk_ct_stopScan)]) {
        [self.delegate mk_ct_stopScan];
    }
}

#pragma mark - MKBLEBaseCentralManagerStateProtocol
- (void)MKBLEBaseCentralManagerStateChanged:(MKCentralManagerState)centralManagerState {
    NSLog(@"蓝牙中心改变");
    NSString *string = [NSString stringWithFormat:@"蓝牙中心改变:%@",@(centralManagerState)];
    [self logToLocal:string];
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_ct_centralManagerStateChangedNotification object:nil];
}

- (void)MKBLEBasePeripheralConnectStateChanged:(MKPeripheralConnectState)connectState {
    //连接成功的判断必须是发送密码成功之后
    if (connectState == MKPeripheralConnectStateUnknow) {
        self.connectStatus = mk_ct_centralConnectStatusUnknow;
    }else if (connectState == MKPeripheralConnectStateConnecting) {
        self.connectStatus = mk_ct_centralConnectStatusConnecting;
    }else if (connectState == MKPeripheralConnectStateConnectedFailed) {
        self.connectStatus = mk_ct_centralConnectStatusConnectedFailed;
    }else if (connectState == MKPeripheralConnectStateDisconnect) {
        self.connectStatus = mk_ct_centralConnectStatusDisconnect;
    }
    NSLog(@"当前连接状态发生改变了:%@",@(connectState));
    NSString *string = [NSString stringWithFormat:@"连接状态发生改变:%@",@(connectState)];
    [self logToLocal:string];
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_ct_peripheralConnectStateChangedNotification object:nil];
}

#pragma mark - MKBLEBaseCentralManagerProtocol
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        [self logToLocal:@"+++++++++++++++++接收数据出错"];
        NSLog(@"+++++++++++++++++接收数据出错");
        return;
    }
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
        //非日志
        NSString *string = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        [self saveToLogData:string appToDevice:NO];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        //引起设备断开连接的类型
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_ct_deviceDisconnectTypeNotification
                                                            object:nil
                                                          userInfo:@{@"type":[content substringWithRange:NSMakeRange(10, 2)]}];
        return;
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
        //日志
        NSString *content = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        if (!MKValidStr(content)) {
            return;
        }
        [self saveToLogData:content appToDevice:NO];
        if ([self.logDelegate respondsToSelector:@selector(mk_ct_receiveLog:)]) {
            [self.logDelegate mk_ct_receiveLog:content];
        }
        return;
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++发送数据出错");
        [self logToLocal:@"发送数据出错"];
        return;
    }
    
}

#pragma mark - public method
- (CBCentralManager *)centralManager {
    return [MKBLEBaseCentralManager shared].centralManager;
}

- (CBPeripheral *)peripheral {
    return [MKBLEBaseCentralManager shared].peripheral;
}

- (mk_ct_centralManagerStatus )centralStatus {
    return ([MKBLEBaseCentralManager shared].centralStatus == MKCentralManagerStateEnable)
    ? mk_ct_centralManagerStatusEnable
    : mk_ct_centralManagerStatusUnable;
}

- (void)startScan {
    NSArray *services = @[
        [CBUUID UUIDWithString:@"AA15"],
        [CBUUID UUIDWithString:@"BB10"]];
    [[MKBLEBaseCentralManager shared] scanForPeripheralsWithServices:services
                                                             options:nil];
}

- (void)stopScan {
    [[MKBLEBaseCentralManager shared] stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral
                 password:(NSString *)password
                 sucBlock:(void (^)(CBPeripheral * _Nonnull))sucBlock
              failedBlock:(void (^)(NSError * error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    if (password.length != 8 || ![MKBLEBaseSDKAdopter asciiString:password]) {
        [self operationFailedBlockWithMsg:@"The password should be 8 characters." failedBlock:failedBlock];
        return;
    }
    self.password = @"";
    self.password = password;
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    self.password = @"";
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)disconnect {
    [[MKBLEBaseCentralManager shared] disconnect];
}

- (void)addTaskWithTaskID:(mk_ct_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock {
    MKCTOperation <MKBLEBaseOperationProtocol>*operation = [self generateOperationWithOperationID:operationID
                                                                                   characteristic:characteristic
                                                                                      commandData:commandData
                                                                                     successBlock:successBlock
                                                                                     failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addReadTaskWithTaskID:(mk_ct_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock {
    MKCTOperation <MKBLEBaseOperationProtocol>*operation = [self generateReadOperationWithOperationID:operationID
                                                                                       characteristic:characteristic
                                                                                         successBlock:successBlock
                                                                                         failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addOperation:(MKCTOperation *)operation {
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (BOOL)notifyLogData:(BOOL)notify {
    if (self.connectStatus != mk_ct_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.ct_log == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.ct_log];
    return YES;
}

#pragma mark - password method
- (void)connectPeripheral:(CBPeripheral *)peripheral
             successBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    self.sucBlock = nil;
    self.sucBlock = sucBlock;
    self.failedBlock = nil;
    self.failedBlock = failedBlock;
    MKCTPeripheral *trackerPeripheral = [[MKCTPeripheral alloc] initWithPeripheral:peripheral];
    [[MKBLEBaseCentralManager shared] connectDevice:trackerPeripheral sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        if (MKValidStr(self.password) && self.password.length == 8) {
            //需要密码登录
            [self logToLocal:@"密码登录"];
            [self sendPasswordToDevice];
            return;
        }
        //免密登录
        [self logToLocal:@"免密登录"];
        MKBLEBase_main_safe(^{
            self.connectStatus = mk_ct_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_ct_peripheralConnectStateChangedNotification object:nil];
            if (self.sucBlock) {
                self.sucBlock(peripheral);
            }
        });
    } failedBlock:failedBlock];
}

- (void)sendPasswordToDevice {
    NSString *commandData = @"ed01000108";
    for (NSInteger i = 0; i < self.password.length; i ++) {
        int asciiCode = [self.password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    __weak typeof(self) weakSelf = self;
    MKCTOperation *operation = [[MKCTOperation alloc] initOperationWithID:mk_ct_connectPasswordOperation commandBlock:^{
        __strong typeof(self) sself = weakSelf;
        [sself saveToLogData:commandData appToDevice:YES];
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:[MKBLEBaseCentralManager shared].peripheral.ct_password type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error || !MKValidDict(returnData) || ![returnData[@"state"] isEqualToString:@"01"]) {
            //密码错误
            [sself operationFailedBlockWithMsg:@"Password Error" failedBlock:sself.failedBlock];
            return ;
        }
        //密码正确
        MKBLEBase_main_safe(^{
            sself.connectStatus = mk_ct_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_ct_peripheralConnectStateChangedNotification object:nil];
            if (sself.sucBlock) {
                sself.sucBlock([MKBLEBaseCentralManager shared].peripheral);
            }
        });
    }];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

#pragma mark - task method
- (MKCTOperation <MKBLEBaseOperationProtocol>*)generateOperationWithOperationID:(mk_ct_taskOperationID)operationID
                                                                 characteristic:(CBCharacteristic *)characteristic
                                                                    commandData:(NSString *)commandData
                                                                   successBlock:(void (^)(id returnData))successBlock
                                                                   failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!MKValidStr(commandData)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKCTOperation <MKBLEBaseOperationProtocol>*operation = [[MKCTOperation alloc] initOperationWithID:operationID commandBlock:^{
        __strong typeof(self) sself = weakSelf;
        [sself saveToLogData:commandData appToDevice:YES];
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:characteristic type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

- (MKCTOperation <MKBLEBaseOperationProtocol>*)generateReadOperationWithOperationID:(mk_ct_taskOperationID)operationID
                                                                     characteristic:(CBCharacteristic *)characteristic
                                                                       successBlock:(void (^)(id returnData))successBlock
                                                                       failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKCTOperation <MKBLEBaseOperationProtocol>*operation = [[MKCTOperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared].peripheral readValueForCharacteristic:characteristic];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

#pragma mark - private method
- (NSDictionary *)parseModelWithRssi:(NSNumber *)rssi advDic:(NSDictionary *)advDic peripheral:(CBPeripheral *)peripheral {
    if ([rssi integerValue] == 127 || !MKValidDict(advDic) || !peripheral) {
        return @{};
    }
    NSData *manuData1 = advDic[@"kCBAdvDataServiceData"][[CBUUID UUIDWithString:@"AA15"]];
    NSData *manuData2 = advDic[@"kCBAdvDataServiceData"][[CBUUID UUIDWithString:@"BB10"]];
    if (manuData1.length != 12 && manuData2.length != 12) {
        return @{};
    }
    
    NSData *manufacturerData = (MKValidData(manuData1) ? manuData1 : manuData2);
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:manufacturerData];
    
    NSInteger index = 0;
    
    NSString *deviceType = [content substringWithRange:NSMakeRange(index, 2)];
    index += 2;
    
    NSString *tempMac = [[content substringWithRange:NSMakeRange(index, 12)] uppercaseString];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",
    [tempMac substringWithRange:NSMakeRange(0, 2)],
    [tempMac substringWithRange:NSMakeRange(2, 2)],
    [tempMac substringWithRange:NSMakeRange(4, 2)],
    [tempMac substringWithRange:NSMakeRange(6, 2)],
    [tempMac substringWithRange:NSMakeRange(8, 2)],
    [tempMac substringWithRange:NSMakeRange(10, 2)]];
    index += 12;
    
    NSString *batteryPercent = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 2)];
    index += 2;
    
    NSString *voltage = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(index, 4)];
    index += 4;
    
    NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(index, 2)]];
    BOOL needPassword = [[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    NSString *tempWorkBynary = [@"0" stringByAppendingString:[binary substringFromIndex:1]];
    NSString *tempWork = [MKBLEBaseSDKAdopter getHexByBinary:tempWorkBynary];
    NSString *workMode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:tempWork range:NSMakeRange(0, tempWork.length)];
    index += 2;
    
    NSString *assistanceBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(index, 2)]];
    
    BOOL lightOverThreshold = [[assistanceBinary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
    BOOL highTemperatureOverThreshold = [[assistanceBinary substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
    BOOL lowTemperatureBelowThreshold = [[assistanceBinary substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
    BOOL alarm = [[assistanceBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
    BOOL manDown = [[assistanceBinary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
    BOOL vibrate = [[assistanceBinary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
    BOOL downLink = [[assistanceBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    
    
    [self logToLocal:[@"扫描到设备:" stringByAppendingString:content]];
    
    return @{
        @"rssi":rssi,
        @"peripheral":peripheral,
        @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
        @"txPower":(advDic[CBAdvertisementDataTxPowerLevelKey] ? advDic[CBAdvertisementDataTxPowerLevelKey] : @""),
        @"deviceType":deviceType,
        @"batteryPercent":batteryPercent,
        @"voltage":voltage,
        @"macAddress":macAddress,
        @"needPassword":@(needPassword),
        @"workMode":workMode,
        @"lightOverThreshold":@(lightOverThreshold),
        @"highTemperatureOverThreshold":@(highTemperatureOverThreshold),
        @"lowTemperatureBelowThreshold":@(lowTemperatureBelowThreshold),
        @"alarm":@(alarm),
        @"manDown":@(manDown),
        @"vibrate":@(vibrate),
        @"downLink":@(downLink),
        @"connectable":advDic[CBAdvertisementDataIsConnectable],
    };
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MPCentralManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    MKBLEBase_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

- (void)saveToLogData:(NSString *)string appToDevice:(BOOL)app {
    if (!MKValidStr(string)) {
        return;
    }
    NSString *fuction = (app ? @"App To Device" : @"Device To App");
    NSString *recordString = [NSString stringWithFormat:@"%@---->%@",fuction,string];
    [self logToLocal:recordString];
}

- (void)logToLocal:(NSString *)string {
    if (!MKValidStr(string)) {
        return;
    }
    [MKBLEBaseLogManager saveDataWithFileName:mk_ct_logName dataList:@[string]];
}

@end
