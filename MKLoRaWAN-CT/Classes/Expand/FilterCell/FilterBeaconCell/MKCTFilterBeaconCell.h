//
//  MKCTFilterBeaconCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/11/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKCTFilterBeaconCellDelegate <NSObject>

- (void)mk_ct_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_ct_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKCTFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKCTFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKCTFilterBeaconCellDelegate>delegate;

+ (MKCTFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
