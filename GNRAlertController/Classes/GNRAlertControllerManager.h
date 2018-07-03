//
//  GNRAlertControllerManager.h
//  FBSnapshotTestCase
//
//  Created by Luca on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import <GNRAlertController/GNRAlertControllerConfig.h>

@class GNRAlertController;

@interface GNRAlertControllerManager : NSObject

@property (nonatomic, strong, readonly)GNRAlertControllerConfig *config;

+ (instancetype)manager;

+ (void)setUpConfig:(void (^)(GNRAlertControllerConfig *config))setUpConfig;

- (void)showAlert:(GNRAlertController *)alert;

- (void)dismissAlert:(GNRAlertController *)alert;

@end
