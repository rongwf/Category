//
//  UIButton+Utils.m
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import "UIButton+Utils.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import <objc/runtime.h>

#define AnimationTime 0.5f

static const void *TouchUpInsidelHandlersKey = &TouchUpInsidelHandlersKey;

@implementation UIButton (Utils)

- (void)r_setHandler:(Handler)handler andEvent:(UIControlEvents)event {
    objc_setAssociatedObject(self, TouchUpInsidelHandlersKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchUpInsidelHandlers:) forControlEvents:event];
}

- (void)touchUpInsidelHandlers:(UIButton *)sender {
    if (sender.isPushLogin.length > 0 && [[self getUserInfo] count] <= 0) {
        UIViewController *currentVC = [self getCurrentVC];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:[LoginViewController new]];
        [currentVC presentViewController:navi animated:YES completion:nil];
    } else {
        Handler handler = objc_getAssociatedObject(self, TouchUpInsidelHandlersKey);
        if (handler) {
            handler(sender);
        }
    }
}

- (void)changeCode {
    WS(weakSelf);
    __block NSInteger time = 119; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [weakSelf setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.backgroundColor = [UIColor colorWithHexString:@"#ff9900"];
                [weakSelf setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 120;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                weakSelf.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
                [weakSelf setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [weakSelf setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)makeRotation {
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:AnimationTime];
    if(CGAffineTransformEqualToTransform(self.imageView.transform,CGAffineTransformIdentity)){
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else {
        self.imageView.transform =CGAffineTransformIdentity;
    }
    [UIView commitAnimations];
}

- (void)resetAnimation {
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:AnimationTime];
    self.imageView.transform =CGAffineTransformIdentity;
    [UIView commitAnimations];
}

@end
