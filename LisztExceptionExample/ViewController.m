//
//  ViewController.m
//  LisztExceptionExample
//
//  Created by 软擎信息科技 on 2016/12/19.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Exception.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"hide" style:UIBarButtonItemStylePlain target:self action:@selector(hide)];
}
- (void)hide{
    [self.view hideException];
    [self.view setLisztExceptionReloadBlock:^{
        [[[UIAlertView alloc]initWithTitle:@"重载数据了!!!" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    }];
}


- (IBAction)buttonAction:(UIButton *)sender {
    switch (sender.tag-10) {
        case 0:
        {
            [self.view addException:ExceptionTypeNoNetwork showReloadButton:YES];
        }
            break;
        case 1:
        {
            [self.view addException:ExceptionTypeData showReloadButton:NO];
        }
            break;
        case 2:
        {
            [self.view addException:ExceptionTypeSystem showReloadButton:YES];
        }
            break;
        case 3:
        {
            [self.view addExceptionTitle:@"自定义提醒\n当前是自定义提醒" imageName:@"no_system" buttonTitle:@"重载数据" showReloadButton:YES];
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
