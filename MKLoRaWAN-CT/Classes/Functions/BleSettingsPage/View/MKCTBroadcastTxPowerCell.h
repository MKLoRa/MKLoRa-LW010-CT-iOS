//
//  MKCTBroadcastTxPowerCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/6/15.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTBroadcastTxPowerCellModel : NSObject

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,       //3dBm
 8,       //4dBm
 */
@property (nonatomic, assign)NSInteger txPowerValue;

@end

@protocol MKCTBroadcastTxPowerCellDelegate <NSObject>

/*
 0,   //RadioTxPower:-40dBm
 1,   //-20dBm
 2,   //-16dBm
 3,   //-12dBm
 4,    //-8dBm
 5,    //-4dBm
 6,       //0dBm
 7,       //3dBm
 8,       //4dBm
 */
- (void)ct_txPowerValueChanged:(NSInteger)txPower;

@end

@interface MKCTBroadcastTxPowerCell : MKBaseCell

@property (nonatomic, weak)id <MKCTBroadcastTxPowerCellDelegate>delegate;

@property (nonatomic, strong)MKCTBroadcastTxPowerCellModel *dataModel;

+ (MKCTBroadcastTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
