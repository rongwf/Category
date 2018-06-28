//
//  UIView+Utils.m
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import "UIView+Utils.h"
#import "WFPlaceholderView.h"

@implementation UIView (Utils)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)alignHorizontal {
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical {
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow {
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth {
    return self.borderWidth;
}

- (UIColor *)borderColor {
    return self.borderColor;
    
}

- (CGFloat)cornerRadius {
    return self.cornerRadius;
}

- (UIViewController *)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (void)addTapAction:(SEL)tapAction target:(id)target{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:tapAction];
    [self addGestureRecognizer:gesture];
}

// 第一次形变
- (CATransform3D)firstTransform {
    // 每次进来都进行初始化 回归到正常状态
    CATransform3D firstTransform = CATransform3DIdentity;
    // m34就是实现视图的透视效果的（俗称近大远小）
    firstTransform.m34 = 1.0/-900;
    // 缩小
    firstTransform = CATransform3DScale(firstTransform, 0.85, 0.85, 1);
    // x轴旋转
    firstTransform = CATransform3DRotate(firstTransform, 15.0 * M_PI / 180.0, 1, 0, 0);
    return firstTransform;
}

// 第二次形变
- (CATransform3D)secondTransform {
    // 初始化 再次回归正常
    CATransform3D secondTransform = CATransform3DIdentity;
    // 用和上面相同的m34 来设置透视效果
    secondTransform.m34 = [self firstTransform].m34;
    // 向上平移一丢丢 让视图平滑点
    secondTransform = CATransform3DTranslate(secondTransform, 0, self.frame.size.height * (-0.08), 0);
    // 最终缩小到0.8倍
    secondTransform = CATransform3DScale(secondTransform, 0.8, 0.8, 1);
    return secondTransform;
}

- (void)openAnimateWithBackgroundView:(UIView *)view animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        // 第一段操作
        // 逆时针X轴旋转 缩小到0.95倍，实现向内倾斜凹陷的透视效果
        view.backgroundColor = RGBA(0, 0, 0, 0.3);
        view.hidden = NO;
        weakSelf.layer.transform = [weakSelf firstTransform];
    } completion:^(BOOL finished) {
        // 第二段操作，
        // 把transform设置为初始化，透视效果和第一段一样，
        // 让他回归到正常（不倾斜），
        // 同时大小最终为0.8，高度向上移动一点点，
        // 添加maskView，添加popView
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.layer.transform = [weakSelf secondTransform];
            animations();
        } completion:^(BOOL finished) {
            completion(finished);
        }];
    }];
}

- (void)closeAnimateWithBackgroundView:(UIView *)view animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    // 动画回去
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.layer.transform = [weakSelf firstTransform];
        animations();
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            // 折叠完之后让transform回归到正常水平
            weakSelf.layer.transform = CATransform3DIdentity;
            view.hidden = YES;
            view.backgroundColor = RGBA(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            completion(finished);
        }];
    }];
}

@end
