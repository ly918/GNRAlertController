//
//  GNRAlertControllerConfig.h
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import <Foundation/Foundation.h>

@interface GNRAlertControllerConfig : NSObject

@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)UIColor *msgColor;
@property (nonatomic, strong)UIColor *confirmTextColor;
@property (nonatomic, strong)UIColor *cancelTextColor;

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, strong)UIFont *msgFont;
@property (nonatomic, strong)UIFont *cancelFont;
@property (nonatomic, strong)UIFont *confirmFont;

@property (nonatomic, assign)CGFloat width_containerView;
@property (nonatomic, assign)CGFloat leadingMargin_textLabel;
@property (nonatomic, assign)CGFloat topMargin_textLabel;
@property (nonatomic, assign)CGFloat space_titleMsg;
@property (nonatomic, assign)CGFloat bottomMargin_textLabel;
@property (nonatomic, assign)CGFloat height_button;

@end
