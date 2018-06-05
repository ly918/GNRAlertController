//
//  GNRAlertAction.h
//  GNRAlertController
//
//  Created by Luca on 2018/5/23.
//

#import <UIKit/UIKit.h>

@class GNRAlertAction;

typedef NS_ENUM(NSInteger, GNRAlertActionType) {
    GNRAlertActionTypeNormal,
    GNRAlertActionTypeCancel
};

typedef void(^GNRAlertActionHandler)(GNRAlertAction *action);

@interface GNRAlertAction : NSObject
@property (nonatomic, assign)BOOL enabled;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)GNRAlertActionType type;
@property (nonatomic, copy)GNRAlertActionHandler handler;

+ (instancetype)actionWithTitle:(NSString *)title type:(GNRAlertActionType)type handler:(GNRAlertActionHandler)handler;

@end
