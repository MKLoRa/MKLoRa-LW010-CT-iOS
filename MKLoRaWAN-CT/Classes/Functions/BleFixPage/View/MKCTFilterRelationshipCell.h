//
//  MKCTFilterRelationshipCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterRelationshipCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray *dataList;

@end

@protocol MKCTFilterRelationshipCellDelegate <NSObject>

- (void)ct_filterRelationshipChanged:(NSInteger)index dataListIndex:(NSInteger)dataListIndex;

@end

@interface MKCTFilterRelationshipCell : MKBaseCell

@property (nonatomic, strong)MKCTFilterRelationshipCellModel *dataModel;

@property (nonatomic, weak)id <MKCTFilterRelationshipCellDelegate>delegate;

+ (MKCTFilterRelationshipCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
