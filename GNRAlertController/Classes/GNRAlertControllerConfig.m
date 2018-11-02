//
//  GNRAlertControllerConfig.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertControllerConfig.h"
#import <GNRFoundation/UIColor+Hex.h>
#import <GNRFoundation/UIView+GNRSafeArea.h>
@implementation GNRAlertControllerConfig

- (instancetype)init{
    if (self = [super init]) {
        _titleColor = [UIColor colorWithHexString:@"#ffffff"];
        _msgColor = [UIColor colorWithHexString:@"#ffffff"];
        _bgColor = [UIColor colorWithHexString:@"#404153" alpha:0.5];
        _confirmTextColor = [UIColor colorWithHexString:@"#ffffff"];
        _cancelTextColor = [UIColor colorWithHexString:@"#ffffff"];
        _cancelBgColor = [UIColor colorWithHexString:@"#595A72"];
        _actionColors = @[(id)[UIColor colorWithHexString:@"#536FFF"].CGColor,(id)[UIColor colorWithHexString:@"#CE72FF"].CGColor];
        
        _titleFont = [UIFont boldSystemFontOfSize:26];
        _msgFont = [UIFont systemFontOfSize:16];
        _cancelFont = [UIFont systemFontOfSize:16];
        _cancelFont = [UIFont systemFontOfSize:16];
        
        _width_containerView = 300;
        _leadingMargin_textLabel = 20.f;
        _topMargin_textLabel = 51.f;
        _bottomMargin_textLabel = 27.f;
        _space_titleMsg = 17.f;
        _height_actionView = 104.f;
        _height_actionButton = 54.f;
        _bottomMarginButton = 49.f;
        _leftMarginButton = 24.f;
        _spaceButton = 14.f;
    }
    return self;
}

@end
