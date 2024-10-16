//
//  MKCTAlarmFunctionModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTAlarmFunctionModel : NSObject

/// 0:No  1:Alert  2:SOS
@property (nonatomic, assign)NSInteger alarmType;

@property (nonatomic, copy)NSString *exitTime;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
