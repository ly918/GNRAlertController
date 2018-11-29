//
//  GNRAlertController.m
//  Pods
//
//  Created by Luca on 2018/5/23.
//

#import "GNRAlertController.h"
#import <GNRAlertController/GNRAlertContentView.h>
#import <GNRAlertController/GNRAlertActionView.h>
#import <Masonry/Masonry.h>
#import <GNRFoundation/UIView+Factory.h>
#import <GNRFoundation/NSObject+TKObject.h>

@interface GNRAlertController ()

@property (nonatomic, strong)NSString *alertID;
//container
@property (nonatomic,strong)UIView *containerView;
@property (nonatomic,strong)UIVisualEffectView *blurView;

//content
@property (nonatomic,strong)UIView *contentSuperView;
@property (nonatomic,strong)UIView *contentView;

//action
@property (nonatomic,strong)UIView *actionSuperView;
@property (nonatomic,strong)GNRAlertActionView *actionView;

@property (nonatomic,strong)UIButton *closeBtn;

@property (nonatomic, strong)NSArray <GNRAlertAction *>*actions;

@end

@implementation GNRAlertController

- (void)dealloc{
    NSLog(@"GNRAlertController Dealloc!");
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)initWithCustomContentView:(UIView *)customContentView
                               actions:(NSArray <GNRAlertAction *>*)actions{
    if (self = [super init]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _contentView = customContentView;
        _alertID = [NSUUID UUID].UUIDString;
        _actions = actions;
        _config = [GNRAlertControllerManager manager].config;
    }
    return self;
}

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray <GNRAlertAction *>*)actions{
    GNRAlertContentView *contentView = [[GNRAlertContentView alloc]init];
    [contentView setUpTitle:title message:message];
    GNRAlertController *alertController = [[GNRAlertController alloc]initWithCustomContentView:contentView actions:actions];
    return alertController;
}

+ (instancetype)alertTitle:(NSString *)title
                   message:(NSString *)message
   attributeTitleSubStrArr:(NSArray <NSString *>*)attributeTitleSubStrArr
 attributeMessageSubStrArr:(NSArray <NSString *>*)attributeMessageSubStrArr
        attributeTextColor:(UIColor *)attributeTextColor
                   actions:(NSArray <GNRAlertAction *>*)actions{
    GNRAlertContentView *contentView = [[GNRAlertContentView alloc]init];
    contentView.subTitleStrArr = attributeTitleSubStrArr;
    contentView.subMessageStrArr = attributeMessageSubStrArr;
    contentView.attributeTextColor = attributeTextColor;
    [contentView setUpTitle:title message:message];
    GNRAlertController *alertController = [[GNRAlertController alloc]initWithCustomContentView:contentView actions:actions];
    return alertController;
}

+ (instancetype)alertCustomContentView:(UIView *)customContentView
                               actions:(NSArray <GNRAlertAction *>*)actions{
    GNRAlertController *alertController = [[GNRAlertController alloc]initWithCustomContentView:customContentView actions:actions];
    return alertController;
}

- (BOOL)validAlert{
    if (!_contentView) {
        NSLog(@"GNRAlertController Error: content view can not be nil!");
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
    self.containerView.alpha = 0;
    self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:animated?0.3:0 animations:^{
        self.containerView.alpha = 1;
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
    [self addKeyBoardObserve];
    UITapGestureRecognizer *tapPress =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressAction)];
    [self.view addGestureRecognizer:tapPress];
}

- (void)tapPressAction{
    [self.view endEditing:YES];
}

-(void)addKeyBoardObserve{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShown:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat offset = (CGRectGetMaxY(self.containerView.frame)-(CGRectGetHeight(self.view.bounds)-height));
    offset = offset<0?0:offset;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@(-offset));
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@(0));
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)updateUI{
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
        make.width.equalTo(@(self.config.width_containerView));
    }];
    
    [self.contentSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.bottom.equalTo(self.actionSuperView.mas_top);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    [self.actionSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(self.actions.count?self.config.height_actionView:0));
    }];
    
    [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.closeBtn.hidden = ![GNRAlertControllerManager manager].config.closeBtnImg;
    [self.closeBtn setImage:[GNRAlertControllerManager manager].config.closeBtnImg forState:UIControlStateNormal];
    
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

- (void)closeBtnAction{
    [self dismiss];
}

//MARK: - Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 20;
        _containerView.layer.masksToBounds = YES;
        [_containerView addSubview:self.blurView];
        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _containerView;
}

- (UIView *)contentSuperView{
    if (!_contentSuperView) {
        _contentSuperView = [[UIView alloc]init];
    }
    return _contentSuperView;
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

- (UIVisualEffectView *)blurView{
    if (!_blurView) {
        _blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.contentView.backgroundColor = [GNRAlertControllerManager manager].config.bgColor;
    }
    return _blurView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIView buttonWithTitle:nil image:nil target:self action:@selector(closeBtnAction)];
        [self.containerView addSubview:_closeBtn];
        [self.containerView bringSubviewToFront:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(@0);
            make.width.height.equalTo(@55);
        }];
    }
    return _closeBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
