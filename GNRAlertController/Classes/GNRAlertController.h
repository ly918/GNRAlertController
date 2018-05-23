//
//  GNRAlertController.h
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import <UIKit/UIKit.h>
#import <GNRAlertController/GNRAlertAction.h>

@interface GNRAlertController : UIViewController

@property (nonatomic, strong, readonly)NSString *alertID;

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray <GNRAlertAction *>*)actions;

+ (instancetype)alertCustomContentView:(UIView *)customContentView
                               actions:(NSArray <GNRAlertAction *>*)actions;

- (void)show;

- (void)dismiss;

@end
