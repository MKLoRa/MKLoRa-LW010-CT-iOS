//
//  MKCTFilterEditSectionHeaderView.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/11/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKCTFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_ct_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_ct_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKCTFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKCTFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKCTFilterEditSectionHeaderViewDelegate>delegate;

+ (MKCTFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
