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
@property (nonatomic, strong)UIColor *bgColor;
@property (nonatomic, strong)UIColor *confirmTextColor;
@property (nonatomic, strong)UIColor *cancelTextColor;
@property (nonatomic, strong)UIColor *cancelBgColor;
@property (nonatomic, strong)NSArray *actionColors;//CGColor

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, strong)UIFont *msgFont;
@property (nonatomic, strong)UIFont *cancelFont;
@property (nonatomic, strong)UIFont *confirmFont;

@property (nonatomic, assign)CGFloat width_containerView;
@property (nonatomic, assign)CGFloat leadingMargin_textLabel;
@property (nonatomic, assign)CGFloat topMargin_textLabel;
@property (nonatomic, assign)CGFloat space_titleMsg;
@property (nonatomic, assign)CGFloat bottomMargin_textLabel;

@property (nonatomic, assign)CGFloat height_actionView;
@property (nonatomic, assign)CGFloat height_actionButton;
@property (nonatomic, assign)CGFloat bottomMarginButton;
@property (nonatomic, assign)CGFloat leftMarginButton;
@property (nonatomic, assign)CGFloat spaceButton;

@property (nonatomic, strong)UIImage *closeBtnImg;

@end
