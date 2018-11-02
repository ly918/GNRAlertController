//
//  GNRAlertContentView.h
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import <UIKit/UIKit.h>

@interface GNRAlertContentView : UIView

@property (nonatomic,strong)NSArray *subTitleStrArr;
@property (nonatomic,strong)NSArray *subMessageStrArr;
@property (nonatomic,strong)UIColor *attributeTextColor;

- (void)setUpTitle:(NSString *)title message:(NSString *)message;

@end
