//
//  MKCTBatteryInfoCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2025/1/14.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTBatteryInfoCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *axisWakeupTimes;

@property (nonatomic, copy)NSString *blePostionTimes;

@property (nonatomic, copy)NSString *gpsPostionTimes;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *batteryPower;

@property (nonatomic, copy)NSString *staticPositionCount;

@property (nonatomic, copy)NSString *movePositionCount;

@end

@interface MKCTBatteryInfoCell : MKBaseCell

@property (nonatomic, strong)MKCTBatteryInfoCellModel *dataModel;

+ (MKCTBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
