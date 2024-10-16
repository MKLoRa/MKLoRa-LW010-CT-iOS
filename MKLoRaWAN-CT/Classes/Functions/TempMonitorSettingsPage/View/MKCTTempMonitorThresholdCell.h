//
//  MKCTTempMonitorThresholdCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTTempMonitorThresholdCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *value;

@end

@protocol MKCTTempMonitorThresholdCellDelegate <NSObject>

- (void)ct_tempMonitorThresholdCell_valueChanged:(NSInteger)index value:(NSString *)value;

@end

@interface MKCTTempMonitorThresholdCell : MKBaseCell

@property (nonatomic, weak)id <MKCTTempMonitorThresholdCellDelegate>delegate;

@property (nonatomic, strong)MKCTTempMonitorThresholdCellModel *dataModel;

+ (MKCTTempMonitorThresholdCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
