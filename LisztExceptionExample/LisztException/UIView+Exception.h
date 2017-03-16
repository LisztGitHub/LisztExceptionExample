//
//  UIView+Exception.h
//  LisztExceptionExample
//
//  Created by 软擎信息科技 on 2016/12/19.
//  Copyright © 2016年 Liszt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LisztExceptionType) {
    /*无网络*/
    ExceptionTypeNoNetwork,
    /*无数据*/
    ExceptionTypeData,
    /*系统异常*/
    ExceptionTypeSystem
};

@interface UIView (Exception)
/*重载回调*/
@property (copy, nonatomic) void(^LisztExceptionReloadBlock)();

/*
 加载一个加载异常的视图
 @param exceptionType 异常类型(无网络、无数据、系统异常)
 @param reload 是否显示重新载入
 */
- (void)addException:(LisztExceptionType)exceptionType showReloadButton:(BOOL)reload;
/*
 自定义图标和文本
 @param title 标题
 @param imageName 图片名称
 */
- (void)addExceptionTitle:(NSString *)title imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle showReloadButton:(BOOL)reload;
/*
 清空异常提醒
 */
- (void)hideException;
@end

@interface LisztExceptionView : UIView
/*图标View*/
@property (nonatomic, strong) UIImageView *imageView;
/*标题*/
@property (nonatomic, strong) UILabel *titleView;
/*按钮*/
@property (nonatomic, strong) UIButton *reloadButton;
/*重载回调*/
@property (copy, nonatomic) void(^LisztExceptionReloadBlock)();

/*
 初始化异常视图
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName buttonTitle:(NSString *)btnTitle showReload:(BOOL)reload;
@end
