//
//  GNRAlertActionView.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertActionView.h"
#import <GNRAlertController/GNRAlertControllerManager.h>
#import <GNRFoundation/UIView+Factory.h>
#import <GNRFoundation/UIColor+Hex.h>
#import <GNRFoundation/UIImage+Fix.h>
#import <Masonry/Masonry.h>

@interface GNRAlertActionView()
@property (nonatomic, strong)UIImageView *line;
@property (nonatomic, strong)NSMutableArray *buttons;

@end

@implementation GNRAlertActionView

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)installLine{
    _line = [self newLine];
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
}

- (void)setActions:(NSArray<GNRAlertAction *> *)actions{
    _actions = actions;
    [self clear];
    [self layout];
}

- (void)layout{
    
    __block UIButton *lastBtn = nil;
    [self.actions enumerateObjectsUsingBlock:^(GNRAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIView buttonWithButtonType:UIButtonTypeCustom title:obj.title image:nil target:self action:@selector(buttonPressed:)];
        btn.tag = idx;
        btn.clipsToBounds = NO;
        [btn setTitleColor:obj.type==GNRAlertActionTypeCancel?[GNRAlertControllerManager manager].config.cancelTextColor:[GNRAlertControllerManager manager].config.confirmTextColor forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#e7e7e7"]] forState:UIControlStateHighlighted];
        [self addSubview:btn];
        
        if (lastBtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right);
                make.top.bottom.equalTo(@0);
                make.width.equalTo(lastBtn);
                make.right.equalTo(@0);
            }];
            //line
            UIImageView *line = [self newLine];
            [lastBtn addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@0.5);
                make.top.equalTo(@9);
                make.bottom.equalTo(@(-9));
                make.right.equalTo(@0);
            }];
            
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(@0);
                if (self.actions.count==1) {
                    make.right.equalTo(@0);
                }
            }];
        }
        lastBtn = btn;
        [self.buttons addObject:btn];
    }];
    
    [self installLine];
}

- (void)clear{
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttons removeAllObjects];
}

- (void)buttonPressed:(UIButton *)sender{
    if (self.actions.count) {
        GNRAlertAction *action = self.actions[sender.tag];
        if (_actionBlock) {
            _actionBlock(action);
        }
    }
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIImageView *)newLine{
    UIImageView *line = [[UIImageView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#e7e7e7"];
    return line;
}

@end
