//
//  MKCTTempMonitorValueCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTTempMonitorValueCellModel : NSObject

@property (nonatomic, copy)NSString *temperature;

@end

@interface MKCTTempMonitorValueCell : MKBaseCell

@property (nonatomic, strong)MKCTTempMonitorValueCellModel *dataModel;

+ (MKCTTempMonitorValueCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
