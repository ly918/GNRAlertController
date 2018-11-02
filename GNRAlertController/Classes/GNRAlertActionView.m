//
//  GNRAlertActionView.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertActionView.h"
#import <GNRAlertController/GNRAlertControllerManager.h>
#import <GNRFoundation/UIView+Factory.h>
#import <GNRFoundation/CALayer+Factory.h>
#import <GNRFoundation/UIColor+Hex.h>
#import <GNRFoundation/UIImage+Fix.h>
#import <Masonry/Masonry.h>

@interface GNRAlertActionView()
@property (nonatomic, strong)NSMutableArray *buttons;
@property (nonatomic, strong)NSMutableArray *layers;
@end

@implementation GNRAlertActionView
static NSString *GNRAlertControllerActionEnableKeyPath = @"enabled";

- (void)dealloc{
    [self removeObserver];
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)setActions:(NSArray<GNRAlertAction *> *)actions{
    [self removeObserver];
    [self clear];
    _actions = actions;
    [self layout];
    [self addObserver];
}

- (void)layout{

    __block UIButton *lastBtn = nil;
    [self.actions enumerateObjectsUsingBlock:^(GNRAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIView buttonWithButtonType:UIButtonTypeCustom title:obj.title image:nil target:self action:@selector(buttonPressed:)];
        btn.tag = idx;
        btn.clipsToBounds = NO;
        btn.enabled = obj.enabled;
        btn.layer.cornerRadius = [GNRAlertControllerManager manager].config.height_actionButton/2.0;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:obj.type==GNRAlertActionTypeCancel?[GNRAlertControllerManager manager].config.cancelTextColor:[GNRAlertControllerManager manager].config.confirmTextColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff" alpha:0.5] forState:UIControlStateDisabled];
        
        if (obj.type==GNRAlertActionTypeCancel) {
            [btn setBackgroundImage:[UIImage imageWithColor:[GNRAlertControllerManager manager].config.cancelBgColor] forState:UIControlStateNormal];
        } else {
            CALayer *layer = [CALayer layerGradientWithColors:[GNRAlertControllerManager manager].config.actionColors locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
            layer.cornerRadius = [GNRAlertControllerManager manager].config.height_actionButton/2.0;
            layer.masksToBounds = YES;
            [btn.layer insertSublayer:layer atIndex:0];
            [self.layers addObject:layer];
        }
        
        [self addSubview:btn];
        
        if (lastBtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).offset([GNRAlertControllerManager manager].config.spaceButton);
                make.top.equalTo(@0);
                make.bottom.equalTo(@(-[GNRAlertControllerManager manager].config.bottomMarginButton));
                make.height.equalTo(@([GNRAlertControllerManager manager].config.height_actionButton));
                make.width.equalTo(lastBtn);
                make.right.equalTo(@(-[GNRAlertControllerManager manager].config.leftMarginButton));
            }];
            
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@([GNRAlertControllerManager manager].config.leftMarginButton));
                make.top.equalTo(@0);
                make.bottom.equalTo(@(-[GNRAlertControllerManager manager].config.bottomMarginButton));
                make.height.equalTo(@([GNRAlertControllerManager manager].config.height_actionButton));
                if (self.actions.count==1) {
                    make.right.equalTo(@(-[GNRAlertControllerManager manager].config.leftMarginButton));
                }
            }];
        }
        lastBtn = btn;
        [self.buttons addObject:btn];
    }];
    [self layoutIfNeeded];
}


- (void)addObserver{
    [self.actions enumerateObjectsUsingBlock:^(GNRAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addObserver:self forKeyPath:GNRAlertControllerActionEnableKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }];
}

- (void)removeObserver{
    [self.actions enumerateObjectsUsingBlock:^(GNRAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeObserver:self forKeyPath:GNRAlertControllerActionEnableKeyPath];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:GNRAlertControllerActionEnableKeyPath]) {
        GNRAlertAction *action = object;
        NSInteger index = [self.actions indexOfObject:action];
        UIButton *btn = [self.buttons objectAtIndex:index];
        btn.enabled = action.enabled;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        for (CALayer *layer in btn.layer.sublayers) {
            layer.frame = btn.bounds;
        }
    }];
}

- (void)clear{
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttons removeAllObjects];
    [self.layers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [self.layers removeAllObjects];
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

- (NSMutableArray *)layers{
    if (!_layers) {
        _layers = [NSMutableArray array];
    }
    return _layers;
}

@end
