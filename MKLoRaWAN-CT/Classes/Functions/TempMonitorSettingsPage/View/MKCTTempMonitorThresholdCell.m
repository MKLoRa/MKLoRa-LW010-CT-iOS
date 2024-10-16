//
//  MKCTTempMonitorThresholdCell.m
//  MKLoRaWAN-CT_Example
//
//  Created by aa on 2024/10/15.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCTTempMonitorThresholdCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

@implementation MKCTTempMonitorThresholdCellModel
@end

@interface MKCTTempMonitorThresholdCell ()<UITextFieldDelegate>

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UITextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKCTTempMonitorThresholdCell

+ (MKCTTempMonitorThresholdCell *)initCellWithTableView:(UITableView *)tableView {
    MKCTTempMonitorThresholdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCTTempMonitorThresholdCellIdenty"];
    if (!cell) {
        cell = [[MKCTTempMonitorThresholdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCTTempMonitorThresholdCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldChanged:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.textField.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

- (void)textFieldChanged:(NSNotification *) noti {
    NSString *tempString = self.textField.text;
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!ValidStr(tempString)) {
        self.textField.text = @"";
        if ([self.delegate respondsToSelector:@selector(ct_tempMonitorThresholdCell_valueChanged:value:)]) {
            [self.delegate ct_tempMonitorThresholdCell_valueChanged:self.dataModel.index value:self.textField.text];
        }
        return;
    }
    if (tempString.length > 3) {
        self.textField.text = [tempString substringToIndex:3];
        if ([self.delegate respondsToSelector:@selector(ct_tempMonitorThresholdCell_valueChanged:value:)]) {
            [self.delegate ct_tempMonitorThresholdCell_valueChanged:self.dataModel.index value:self.textField.text];
        }
        return;
    }
    NSString *inputString = [tempString substringFromIndex:(self.textField.text.length - 1)];
    if ([inputString regularExpressions:isRealNumbers]) {
        self.textField.text = tempString;
        if ([self.delegate respondsToSelector:@selector(ct_tempMonitorThresholdCell_valueChanged:value:)]) {
            [self.delegate ct_tempMonitorThresholdCell_valueChanged:self.dataModel.index value:self.textField.text];
        }
        return;
    }
    if ([inputString isEqualToString:@"-"]) {
        if (tempString.length == 1) {
            self.textField.text = tempString;
            if ([self.delegate respondsToSelector:@selector(ct_tempMonitorThresholdCell_valueChanged:value:)]) {
                [self.delegate ct_tempMonitorThresholdCell_valueChanged:self.dataModel.index value:self.textField.text];
            }
            return;
        }
        //负号只能在第一个
        self.textField.text = [tempString substringToIndex:self.textField.text.length - 1];
        if ([self.delegate respondsToSelector:@selector(ct_tempMonitorThresholdCell_valueChanged:value:)]) {
            [self.delegate ct_tempMonitorThresholdCell_valueChanged:self.dataModel.index value:self.textField.text];
        }
        return;
    }
}

#pragma mark - setter
- (void)setDataModel:(MKCTTempMonitorThresholdCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCTTempMonitorThresholdCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.textField.text = SafeStr(_dataModel.value);
}

#pragma mark - getter

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = DEFAULT_TEXT_COLOR;
        _textField.font = MKFont(15.f);
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.placeholder = @"-20~60";
        
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderWidth = 0.5f;
        _textField.layer.borderColor = RGBCOLOR(162, 162, 162).CGColor;
        _textField.layer.cornerRadius = 6.f;
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.font = MKFont(13.f);
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.text = @"℃";
    }
    return _unitLabel;
}

@end
