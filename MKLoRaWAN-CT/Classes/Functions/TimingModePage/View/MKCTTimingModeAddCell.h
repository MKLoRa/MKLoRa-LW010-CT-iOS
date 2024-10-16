//
//  MKCTTimingModeAddCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTTimingModeAddCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKCTTimingModeAddCellDelegate <NSObject>

- (void)ct_addButtonPressed;

@end

@interface MKCTTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKCTTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKCTTimingModeAddCellDelegate>delegate;

+ (MKCTTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
