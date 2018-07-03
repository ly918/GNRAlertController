//
//  GNRAlertControllerManager.m
//  FBSnapshotTestCase
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertControllerManager.h"
#import <GNRAlertController/GNRAlertController.h>

@interface GNRAlertControllerManager()
@property (nonatomic, strong)NSMutableArray *alerts;
@property (nonatomic, strong)GNRAlertControllerConfig *config;
@end

@implementation GNRAlertControllerManager

static GNRAlertControllerManager* manager = nil;
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == manager) {
            manager = [[GNRAlertControllerManager alloc] init];
        }
    });
    return manager;
}

+ (void)setUpConfig:(void (^)(GNRAlertControllerConfig *))setUpConfig{
    if (setUpConfig) setUpConfig([GNRAlertControllerManager manager].config);
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)isExistAlert:(GNRAlertController *)alert{
    for (GNRAlertController *al in self.alerts) {
        if ([al.alertID isEqualToString:alert.alertID]) {
            return YES;
        }
    }
    return NO;
}

- (void)showAlert:(GNRAlertController *)alert{
    if (![alert isKindOfClass:[GNRAlertController class]]) {
        return;
    }
    if (![self isExistAlert:alert] && alert) {
        [self hideAll];
        [self.alerts insertObject:alert atIndex:0];
    }
}

- (void)dismissAlert:(GNRAlertController *)alert{
    if (![alert isKindOfClass:[GNRAlertController class]]) {
        return;
    }
    if ([self isExistAlert:alert] && alert) {
        [self.alerts removeObject:alert];
        [self showFirst];
    }
}

- (void)hideAll{
    for (GNRAlertController *al in self.alerts) {
        [UIView animateWithDuration:0.1 animations:^{
            al.view.alpha = 0;
        } completion:^(BOOL finished) {
            al.view.hidden = YES;
        }];
    }
}

- (void)showFirst{
    if (self.alerts.count) {
        GNRAlertController *alert = self.alerts.firstObject;
        [UIView animateWithDuration:0.1 animations:^{
            alert.view.alpha = 1;
        } completion:^(BOOL finished) {
            alert.view.hidden = NO;
        }];
    }
}

- (NSMutableArray *)alerts{
    if (!_alerts) {
        _alerts = [NSMutableArray array];
    }
    return _alerts;
}

- (GNRAlertControllerConfig *)config{
    if (!_config) {
        _config = [[GNRAlertControllerConfig alloc]init];
    }
    return _config;
}

@end
