//
//  MKCTTimeSegmentedAddCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/11/21.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTTimeSegmentedAddCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKCTTimeSegmentedAddCellDelegate <NSObject>

- (void)ct_timeSegmentedAddCell_addPressed;

@end

@interface MKCTTimeSegmentedAddCell : MKBaseCell

@property (nonatomic, strong)MKCTTimeSegmentedAddCellModel *dataModel;

@property (nonatomic, weak)id <MKCTTimeSegmentedAddCellDelegate>delegate;

+ (MKCTTimeSegmentedAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
