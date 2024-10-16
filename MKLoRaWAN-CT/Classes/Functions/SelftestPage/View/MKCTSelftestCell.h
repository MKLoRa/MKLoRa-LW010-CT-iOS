//
//  MKCTSelftestCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTSelftestCellModel : NSObject

@property (nonatomic, copy)NSString *value0;

@property (nonatomic, copy)NSString *value1;

@property (nonatomic, copy)NSString *value2;

@property (nonatomic, copy)NSString *value3;

@property (nonatomic, copy)NSString *value4;

@property (nonatomic, copy)NSString *value5;

@property (nonatomic, copy)NSString *value6;

@property (nonatomic, copy)NSString *value7;

@end

@interface MKCTSelftestCell : MKBaseCell

@property (nonatomic, strong)MKCTSelftestCellModel *dataModel;

+ (MKCTSelftestCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
