//
//  MKCTTempMonitorValueCell.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCTTempMonitorValueCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

@implementation MKCTTempMonitorValueCellModel
@end

@interface MKCTTempMonitorValueCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIImageView *icon;

@property (nonatomic, strong)UILabel *temperatureLabel;

@end

@implementation MKCTTempMonitorValueCell

+ (MKCTTempMonitorValueCell *)initCellWithTableView:(UITableView *)tableView {
    MKCTTempMonitorValueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCTTempMonitorValueCellIdenty"];
    if (!cell) {
        cell = [[MKCTTempMonitorValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCTTempMonitorValueCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.temperatureLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.temperatureLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCTTempMonitorValueCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCTTempMonitorValueCellModel.class]) {
        return;
    }
    //顶部
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@%@",_dataModel.temperature,@"℃"];
}

#pragma mark - getter
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = LOADICON(@"MKLoRaWAN-CT", @"MKCTTempMonitorValueCell", @"ct_temperatureIcon.png");
    }
    return _icon;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Temp: ";
    }
    return _msgLabel;
}

- (UILabel *)temperatureLabel {
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.textAlignment = NSTextAlignmentLeft;
        _temperatureLabel.font = MKFont(13.f);
        _temperatureLabel.textColor = DEFAULT_TEXT_COLOR;
        _temperatureLabel.text = @"0℃";
    }
    return _temperatureLabel;
}

@end
