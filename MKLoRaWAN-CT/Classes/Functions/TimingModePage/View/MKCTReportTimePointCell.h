//
//  MKCTReportTimePointCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTReportTimePointCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger hourIndex;

@property (nonatomic, assign)NSInteger timeSpaceIndex;

@end

@protocol MKCTReportTimePointCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)ct_cellDeleteButtonPressed:(NSInteger)index;

/// 用户选择了hour事件
- (void)ct_hourButtonPressed:(NSInteger)index;

/// 用户选择了时间间隔事件
- (void)ct_timeSpaceButtonPressed:(NSInteger)index;

/**
 重新设置cell的子控件位置，主要是删除按钮方面的处理
 */
- (void)ct_cellResetFrame;

/// cell的点击事件，用来重置cell的布局
- (void)ct_cellTapAction;

@end

@interface MKCTReportTimePointCell : MKBaseCell

@property (nonatomic, weak)id <MKCTReportTimePointCellDelegate>delegate;

@property (nonatomic, strong)MKCTReportTimePointCellModel *dataModel;

+ (MKCTReportTimePointCell *)initCellWithTableView:(UITableView *)tableView;

- (BOOL)canReset;
- (void)resetCellFrame;
- (void)resetFlagForFrame;

@end

NS_ASSUME_NONNULL_END
