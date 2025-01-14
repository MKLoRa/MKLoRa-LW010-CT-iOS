//
//  MKCTSelftestController.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/7/2.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCTSelftestController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSObject+MKModel.h"

#import "MKHudManager.h"
#import "MKAlertController.h"
#import "MKTableSectionLineHeader.h"

#import "MKCTSelftestModel.h"

#import "MKCTSelftestCell.h"
#import "MKCTPCBAStatusCell.h"
#import "MKCTBatteryInfoCell.h"

@interface MKCTSelftestController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKCTSelftestModel *dataModel;

@end

@implementation MKCTSelftestController

- (void)dealloc {
    NSLog(@"MKCTSelftestController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60.f;
    }
    if (indexPath.section == 2) {
        return 290.f;
    }
    
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKCTSelftestCell *cell = [MKCTSelftestCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKCTPCBAStatusCell *cell = [MKCTPCBAStatusCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    MKCTBatteryInfoCell *cell = [MKCTBatteryInfoCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKCTSelftestCellModel *cellModel = [[MKCTSelftestCellModel alloc] init];
    if ([self.dataModel.gps integerValue] == 0 && [self.dataModel.acceData integerValue] == 0) {
        cellModel.value0 = @"0";
    }
    cellModel.value1 = ([self.dataModel.acceData integerValue] == 1 ? @"1" : @"");
    cellModel.value2 = ([self.dataModel.gps integerValue] == 1 ? @"2" : @"");
    
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKCTPCBAStatusCellModel *cellModel = [[MKCTPCBAStatusCellModel alloc] init];
    cellModel.value0 = (([self.dataModel.pcbaStatus integerValue] == 0) ? @"0" : @"");
    cellModel.value1 = (([self.dataModel.pcbaStatus integerValue] == 1) ? @"1" : @"");
    cellModel.value2 = (([self.dataModel.pcbaStatus integerValue] == 2) ? @"2" : @"");
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKCTBatteryInfoCellModel *cellModel = [[MKCTBatteryInfoCellModel alloc] init];
    cellModel.msg = @"All Cycles Battery Information:";
    [cellModel mk_modelSetWithJSON:self.dataModel.allInfo];
    
    [self.section2List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Selftest Interface";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKCTSelftestModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCTSelftestModel alloc] init];
    }
    return _dataModel;
}

@end
