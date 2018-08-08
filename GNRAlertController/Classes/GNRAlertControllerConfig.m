//
//  GNRAlertControllerConfig.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertControllerConfig.h"
#import <GNRFoundation/UIColor+Hex.h>

@implementation GNRAlertControllerConfig

- (instancetype)init{
    if (self = [super init]) {
        _titleColor = [UIColor colorWithHexString:@"#333333"];
        _msgColor = [UIColor colorWithHexString:@"#666666"];
        _confirmTextColor = [UIColor colorWithHexString:@"#496AD5"];
        _cancelTextColor = [UIColor colorWithHexString:@"#999999"];
        
        _titleFont = [UIFont systemFontOfSize:17];
        _msgFont = [UIFont systemFontOfSize:13];
        _cancelFont = [UIFont systemFontOfSize:15];
        _cancelFont = [UIFont systemFontOfSize:15];
        
        _width_containerView = 270.f;
        _leadingMargin_textLabel = 20.f;
        _topMargin_textLabel = 22.f;
        _bottomMargin_textLabel = 20.f;
        _space_titleMsg = 8.f;
        _height_button = 60.f;
    }
    return self;
}

@end
