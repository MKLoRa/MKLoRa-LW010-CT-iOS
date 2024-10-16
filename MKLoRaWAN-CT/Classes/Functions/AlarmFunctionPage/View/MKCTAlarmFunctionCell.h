//
//  MKCTAlarmFunctionCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2023/7/1.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTAlarmFunctionCellModel : NSObject

@property (nonatomic, copy)NSString *exitTime;

@end

@protocol MKCTAlarmFunctionCellDelegate <NSObject>

- (void)ct_exitAlarmTypeChanged:(NSString *)value;

@end

@interface MKCTAlarmFunctionCell : MKBaseCell

@property (nonatomic, strong)MKCTAlarmFunctionCellModel *dataModel;

@property (nonatomic, weak)id <MKCTAlarmFunctionCellDelegate>delegate;

+ (MKCTAlarmFunctionCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
