//
//  MKCTFilterByTLMModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/11/30.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKFilterByTLMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterByTLMModel : NSObject<MKFilterByTLMProtocol>

@property (nonatomic, copy)NSString *pageTitle;

@property (nonatomic, assign)BOOL isOn;

/// 0:过滤所有TLM  1:过滤非加密类型TLM 2:过滤加密类型TLM
@property (nonatomic, assign)NSInteger tlm;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configFilterStatus:(BOOL)isOn
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置TLM版本
/// - Parameters:
///   - version: 0:Do not filter data.  1:Unencrypted TLM data. 2:Encrypted TLM data.
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)configTLMVersion:(NSInteger)version
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
