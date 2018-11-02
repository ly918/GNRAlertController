//
//  GNRAlertContentView.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertContentView.h"
#import <GNRAlertController/GNRAlertControllerManager.h>
#import <GNRFoundation/UIView+Factory.h>
#import <Masonry/Masonry.h>
#import <GNRFoundation/NSString+FirstLetter.h>

@interface GNRAlertContentView()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *msgLabel;

@end

@implementation GNRAlertContentView

- (instancetype)init{
    if (self = [super init]) {
        [self installUI];
        
    }
    return self;
}

- (void)installUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.msgLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@([GNRAlertControllerManager manager].config.leadingMargin_textLabel));
        make.right.equalTo(@(-[GNRAlertControllerManager manager].config.leadingMargin_textLabel));
        make.top.equalTo(@([GNRAlertControllerManager manager].config.topMargin_textLabel));
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@([GNRAlertControllerManager manager].config.leadingMargin_textLabel));
        make.right.equalTo(@(-[GNRAlertControllerManager manager].config.leadingMargin_textLabel));
        make.bottom.equalTo(@(-[GNRAlertControllerManager manager].config.bottomMargin_textLabel));
        make.top.equalTo(self.titleLabel.mas_bottom).offset([GNRAlertControllerManager manager].config.space_titleMsg);
    }];
}

- (void)setUpTitle:(NSString *)title message:(NSString *)message{
    self.titleLabel.text = title?:@"";
    self.msgLabel.text = message?:@"";
    NSAttributedString *titleAtt = [NSString t_changeCorlorWithColor:self.attributeTextColor TotalString:title SubStringArray:self.subTitleStrArr];
    self.titleLabel.attributedText = titleAtt;
    NSAttributedString *messageAtt = [NSString t_changeCorlorWithColor:self.attributeTextColor TotalString:message SubStringArray:self.subMessageStrArr];
    self.msgLabel.attributedText = messageAtt;
    [self layout];
}

- (void)layout{
    if (self.msgLabel.text.length) {
        [self.msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-[GNRAlertControllerManager manager].config.bottomMargin_textLabel));
            make.top.equalTo(self.titleLabel.mas_bottom).offset([GNRAlertControllerManager manager].config.space_titleMsg);
        }];
    } else {
        [self.msgLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-[GNRAlertControllerManager manager].config.bottomMargin_textLabel));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        }];
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UIView labelWithTitle:nil font:[GNRAlertControllerManager manager].config.titleFont textColor:[GNRAlertControllerManager manager].config.titleColor textAlignment:NSTextAlignmentCenter];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [UIView labelWithTitle:nil font:[GNRAlertControllerManager manager].config.msgFont textColor:[GNRAlertControllerManager manager].config.msgColor textAlignment:NSTextAlignmentCenter];
        _msgLabel.numberOfLines = 0;
    }
    return _msgLabel;
}

@end
