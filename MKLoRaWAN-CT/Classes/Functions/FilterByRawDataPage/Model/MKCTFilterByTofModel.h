//
//  MKCTFilterByTofModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKFilterByTofProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterByTofModel : NSObject<MKFilterByTofProtocol>

@property (nonatomic, copy)NSString *pageTitle;

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, strong)NSArray *codeList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithCodeList:(NSArray <NSString *>*)codeList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;


@end

NS_ASSUME_NONNULL_END
