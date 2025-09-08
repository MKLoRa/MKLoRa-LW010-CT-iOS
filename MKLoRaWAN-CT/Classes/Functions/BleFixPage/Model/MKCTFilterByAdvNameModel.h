//
//  MKCTFilterByAdvNameModel.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKFilterByAdvNameProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterByAdvNameModel : NSObject<MKFilterByAdvNameProtocol>

@property (nonatomic, copy)NSString *pageTitle;

@property (nonatomic, assign)BOOL match;

@property (nonatomic, assign)BOOL filter;

@property (nonatomic, strong)NSArray *nameList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithNameList:(NSArray <NSString *>*)nameList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
