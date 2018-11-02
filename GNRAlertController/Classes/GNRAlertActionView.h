//
//  GNRAlertActionView.h
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import <UIKit/UIKit.h>
#import <GNRAlertController/GNRAlertAction.h>

@interface GNRAlertActionView : UIView

@property (nonatomic, strong)NSArray <GNRAlertAction *>*actions;
@property (nonatomic, copy)void (^actionBlock)(GNRAlertAction *action);

@end
