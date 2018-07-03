//
//  GNRAlertController.h
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import <UIKit/UIKit.h>
#import <GNRAlertController/GNRAlertAction.h>
#import <GNRAlertController/GNRAlertControllerManager.h>

@interface GNRAlertController : UIViewController

@property (nonatomic, strong, readonly)NSString *alertID;
@property (nonatomic, strong)GNRAlertControllerConfig *config;

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray <GNRAlertAction *>*)actions;

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
   attributeTitleSubStrArr:(NSArray <NSString *>*)attributeTitleSubStrArr
 attributeMessageSubStrArr:(NSArray <NSString *>*)attributeMessageSubStrArr
        attributeTextColor:(UIColor *)attributeTextColor
                   actions:(NSArray <GNRAlertAction *>*)actions;

+ (instancetype)alertCustomContentView:(UIView *)customContentView
                               actions:(NSArray <GNRAlertAction *>*)actions;

- (void)show;

- (void)dismiss;

@end
