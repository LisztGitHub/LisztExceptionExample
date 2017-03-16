//
//  UIView+Exception.m
//  LisztExceptionExample
//
//  Created by 软擎信息科技 on 2016/12/19.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import "UIView+Exception.h"
#import <objc/runtime.h>

#define EAdapterWidth [UIScreen mainScreen].bounds.size.width / 375
static char lisztExceptionBlock;

@implementation UIView (Exception)
- (void)addException:(LisztExceptionType)exceptionType showReloadButton:(BOOL)reload{
    NSString *imageName = @"";
    NSString *title = @"";
    if(exceptionType==ExceptionTypeSystem){
        imageName = @"no_system";
        title = @"系统异常\n请检查后再试";
    }
    else if (exceptionType==ExceptionTypeNoNetwork){
        imageName = @"no_network";
        title = @"网络异常\n请检查后再试";
    }
    else if (exceptionType==ExceptionTypeData){
        imageName = @"no_data";
        title = @"暂无数据\n请稍后再试";
    }
    LisztExceptionView *exceptionView = [[LisztExceptionView alloc]initWithFrame:self.bounds title:title imageName:imageName buttonTitle:@"重新载入" showReload:reload];
    exceptionView.LisztExceptionReloadBlock = self.LisztExceptionReloadBlock;
    [self addSubview:exceptionView];
}
- (void)addExceptionTitle:(NSString *)title imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle showReloadButton:(BOOL)reload{
    LisztExceptionView *exceptionView = [[LisztExceptionView alloc]initWithFrame:self.bounds title:title imageName:imageName buttonTitle:btnTitle showReload:reload];
    exceptionView.LisztExceptionReloadBlock = self.LisztExceptionReloadBlock;
    [self addSubview:exceptionView];
}
- (void)hideException{
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[LisztExceptionView class]]){
            [view removeFromSuperview];
        }
    }
}

- (void)setLisztExceptionReloadBlock:(void (^)())LisztExceptionReloadBlock{
    objc_setAssociatedObject(self, &lisztExceptionBlock, LisztExceptionReloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)())LisztExceptionReloadBlock{
    return objc_getAssociatedObject(self, &lisztExceptionBlock);
}
@end

@implementation LisztExceptionView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle showReload:(BOOL)reload{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:self.titleView];
        self.titleView.text = title;
        if(reload){
            [self addSubview:self.reloadButton];
            [self.reloadButton setTitle:btnTitle forState:UIControlStateNormal];
        }
    }
    return self;
}

#pragma mark - Button Action
- (void)buttonAction{
    if(self.LisztExceptionReloadBlock){
        self.LisztExceptionReloadBlock();
    }
}

#pragma mark - 懒加载
- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, EAdapterWidth * 121, CGRectGetWidth(self.bounds), EAdapterWidth * 150)];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}
- (UILabel *)titleView{
    if(!_titleView){
        _titleView = [[UILabel alloc]initWithFrame:CGRectMake(50, EAdapterWidth * 121 + EAdapterWidth * 150, CGRectGetWidth(self.bounds)-100, 40)];
        _titleView.font = [UIFont systemFontOfSize:14.f];
        _titleView.numberOfLines = 0;
        _titleView.textColor = [UIColor lightGrayColor];
        _titleView.textAlignment = NSTextAlignmentCenter;
    }
    return _titleView;
}
- (UIButton *)reloadButton{
    if(!_reloadButton){
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.frame = CGRectMake(50, EAdapterWidth * 121 + EAdapterWidth * 150 + 40 + 30, CGRectGetWidth(self.bounds) - 100, 40);
        [_reloadButton setTitle:@"重新载入" forState:UIControlStateNormal];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _reloadButton.backgroundColor = [UIColor orangeColor];
        [_reloadButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton.layer.cornerRadius = 5;
        _reloadButton.clipsToBounds = YES;
    }
    return _reloadButton;
}
@end
