//
//  MKCTScanPageCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCTScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)ct_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKCTScanPageModel;
@interface MKCTScanPageCell : MKBaseCell

@property (nonatomic, strong)MKCTScanPageModel *dataModel;

@property (nonatomic, weak)id <MKCTScanPageCellDelegate>delegate;

+ (MKCTScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
