//
//  GNRAlertAction.m
//  GNRAlertController
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertAction.h"

@interface GNRAlertAction()

@end

@implementation GNRAlertAction

+ (instancetype)actionWithTitle:(NSString *)title type:(GNRAlertActionType)type handler:(GNRAlertActionHandler)handler{
    GNRAlertAction *action = [[GNRAlertAction alloc]init];
    action.title = title;
    action.type = type;
    action.handler = handler;
    action.enabled = YES;
    return action;
}

- (NSString *)title{
    if (self.type==GNRAlertActionTypeCancel) {
        _title = _title.length?_title:@"取消";
    } else {
        _title = _title.length?_title:@"好";
    }
    return _title;
}

@end
