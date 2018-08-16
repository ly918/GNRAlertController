//
//  GNRViewController.m
//  GNRAlertController
//
//  Created by ly918@qq.com on 05/23/2018.
//  Copyright (c) 2018 ly918@qq.com. All rights reserved.
//

#import "GNRViewController.h"
#import <GNRAlertController/GNRAlertController.h>
#import <Masonry/Masonry.h>
@interface GNRViewController ()

@end

@implementation GNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __block GNRAlertAction *cancel = [GNRAlertAction actionWithTitle:nil type:GNRAlertActionTypeCancel handler:^(GNRAlertAction *action) {
        NSLog(@"Cancel");
        
    }];
    cancel.enabled = NO;
    
    GNRAlertAction *confirm = [GNRAlertAction actionWithTitle:nil type:GNRAlertActionTypeNormal handler:^(GNRAlertAction *action) {
        NSLog(@"Confirm");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cancel.enabled = YES;
    });
    
    //普通
//    [[GNRAlertController alertTitle:@"标题标题标题标题标题标题标题" message:nil actions:@[cancel,confirm]] show];
    
    //高亮文本
    [[GNRAlertController alertTitle:@"2S后可以取消" message:@"提示提示提示提示提TB示提示提示提示提示提示" attributeTitleSubStrArr:nil attributeMessageSubStrArr:@[@"TB"] attributeTextColor:[UIColor orangeColor] actions:@[cancel,confirm]]show];
    
    //自定义UI
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor redColor];
//    UIView *subView = [[UIView alloc]init];
//    subView.backgroundColor = [UIColor greenColor];
//    [view addSubview:subView];
//    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(@0);
//        make.left.equalTo(@0);
//        make.right.equalTo(@(0));
//        make.height.mas_equalTo(314);
//    }];
//    GNRAlertController * alertController = [GNRAlertController alertCustomContentView:view actions:nil];
//    alertController.config.width_containerView = 251;
//    [alertController show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
