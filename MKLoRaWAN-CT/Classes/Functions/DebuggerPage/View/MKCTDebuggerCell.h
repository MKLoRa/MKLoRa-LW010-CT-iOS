//
//  MKCTDebuggerCell.h
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCTDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKCTDebuggerCellDelegate <NSObject>

- (void)ct_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKCTDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKCTDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKCTDebuggerCellDelegate>delegate;

+ (MKCTDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
