//
//  GNRAlertController.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertController.h"
#import <GNRAlertController/GNRAlertControllerManager.h>
#import <GNRAlertController/GNRAlertContentView.h>
#import <GNRAlertController/GNRAlertActionView.h>

#import <Masonry/Masonry.h>
#import <GNRFoundation/UIView+Factory.h>
#import <GNRFoundation/NSObject+TKObject.h>

@interface GNRAlertController ()
@property (nonatomic, strong)NSString *alertID;
//container
@property (nonatomic,strong)UIView *containerView;

//content
@property (nonatomic,strong)UIView *contentSuperView;
@property (nonatomic,strong)GNRAlertContentView *contentView;
@property (nonatomic,strong)UIView *customContentView;

//action
@property (nonatomic,strong)UIView *actionSuperView;
@property (nonatomic,strong)GNRAlertActionView *actionView;

@property (nonatomic, copy)NSString *alertTitle;
@property (nonatomic, copy)NSString *alertMsg;
@property (nonatomic, strong)NSArray <GNRAlertAction *>*actions;

@end

@implementation GNRAlertController

- (void)dealloc{
    NSLog(@"GNRAlertController Dealloc!");
}

- (instancetype)initWithAlertTitle:(NSString *)title
                           message:(NSString *)message
                           actions:(NSArray <GNRAlertAction *>*)actions{
    if (self = [super init]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _alertID = [NSUUID UUID].UUIDString;
        _alertTitle = title;
        _alertMsg = message;
        _actions = actions;
    }
    return self;
}

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray <GNRAlertAction *>*)actions{
    GNRAlertController *alertController = [[GNRAlertController alloc]initWithAlertTitle:title message:message actions:actions];
    return alertController;
}

+ (instancetype)alertCustomContentView:(UIView *)customContentView
                               actions:(NSArray <GNRAlertAction *>*)actions{
    
    return nil;
}

- (BOOL)validAlert{
    if (!self.actions.count) {
        NSLog(@"GNRAlertController Error: actions count can not be zero!");
        return NO;
    }
    if (!self.alertTitle) {
        NSLog(@"GNRAlertController Error: alertTitle can not be nil!");
        return NO;
    }
    return YES;
}

- (void)show{
    if (![self validAlert]) {
        return;
    }
    [[GNRAlertControllerManager manager] showAlert:self];
    [[UIView tkTopViewController] presentViewController:self animated:YES completion:^{
    }];
}

- (void)showAnimated:(BOOL)animated{
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:animated?0.3:0 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.containerView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showAnimated:YES];
}

- (void)dismiss{
    [self dismissAnimationCompletion:^{
    }];
}

- (void)dismissAnimationCompletion:(void (^)(void))completion{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            [[GNRAlertControllerManager manager] dismissAlert:self];
            if (completion) completion();
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self installUI];
    [self updateUI];
}

- (void)updateUI{
    [self.contentView setUpTitle:self.alertTitle message:self.alertMsg];
    self.actionView.actions = self.actions;
    [self.view layoutIfNeeded];
}

- (void)installUI{
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.contentSuperView];
    [self.containerView addSubview:self.actionSuperView];
    [self.contentSuperView addSubview:self.contentView];
    [self.actionSuperView addSubview:self.actionView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@([GNRAlertControllerManager manager].config.width_containerView));
    }];
    
    [self.contentSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.actionSuperView.mas_top);
    }];
    
    [self.actionSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@([GNRAlertControllerManager manager].config.height_button));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    __weak typeof(self) wself = self;
    self.actionView.actionBlock = ^(GNRAlertAction *action) {
        [wself actionHandler:action];
    };
}

- (void)actionHandler:(GNRAlertAction *)action{
    [self dismissAnimationCompletion:^{
        if (action.handler) {
            action.handler(action);
        }
    }];
}

//MARK: - Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES;
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UIView *)contentSuperView{
    if (!_contentSuperView) {
        _contentSuperView = [[UIView alloc]init];
    }
    return _contentSuperView;
}

- (GNRAlertContentView *)contentView{
    if (!_contentView) {
        _contentView = [[GNRAlertContentView alloc]init];
    }
    return _contentView;
}

- (GNRAlertActionView *)actionView{
    if (!_actionView) {
        _actionView = [[GNRAlertActionView alloc]init];
    }
    return _actionView;
}

- (UIView *)actionSuperView{
    if (!_actionSuperView) {
        _actionSuperView = [[UIView alloc]init];
    }
    return _actionSuperView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
