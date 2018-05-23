//
//  GNRViewController.m
//  GNRAlertController
//
//  Created by ly918@qq.com on 05/23/2018.
//  Copyright (c) 2018 ly918@qq.com. All rights reserved.
//

#import "GNRViewController.h"
#import <GNRAlertController/GNRAlertController.h>

@interface GNRViewController ()

@end

@implementation GNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GNRAlertAction *cancel = [GNRAlertAction actionWithTitle:nil type:GNRAlertActionTypeCancel handler:^(GNRAlertAction *action) {
        NSLog(@"Cancel");
    }];
    
    GNRAlertAction *confirm = [GNRAlertAction actionWithTitle:nil type:GNRAlertActionTypeNormal handler:^(GNRAlertAction *action) {
        NSLog(@"Confirm");
    }];

    [[GNRAlertController alertTitle:@"标题标题标题标题标题标题标题" message:nil actions:@[cancel,confirm]] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
