//
//  UIView+Utils.h
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WFPlaceholderView;

IB_DESIGNABLE

typedef void(^Animations)(void);

@interface UIView (Utils)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, weak) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

//水平居中
- (void)alignHorizontal;
//垂直居中
- (void)alignVertical;
//判断是否显示在主窗口上面
- (BOOL)isShowOnWindow;
//找到当前vc;
 - (UIViewController *)parentController;
//添加轻拍手势
- (void)addTapAction:(SEL)tapAction target:(id)target ;
//向内凹陷动画效果
- (void)openAnimateWithBackgroundView:(UIView *)view animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
//回复向内凹陷动画
- (void)closeAnimateWithBackgroundView:(UIView *)view animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end
