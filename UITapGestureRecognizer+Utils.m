//
//  UITapGestureRecognizer+Utils.m
//  OfferManager
//
//  Created by rongwf on 2017/11/9.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import "UITapGestureRecognizer+Utils.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import <objc/runtime.h>

static const void *TapTouchUpInsidelHandlersKey = &TapTouchUpInsidelHandlersKey;

@implementation UITapGestureRecognizer (Utils)

- (void)r_setTapHandler:(TapHandler)handler {
    objc_setAssociatedObject(self, TapTouchUpInsidelHandlersKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(touchUpInsidelHandlers:)];
}

- (void)touchUpInsidelHandlers:(UITapGestureRecognizer *)sender {
    if (sender.view.isPushLogin.length > 0 && [[self getUserInfo] count] <= 0) {
        UIViewController *currentVC = [self getCurrentVC];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:[LoginViewController new]];
        [currentVC presentViewController:navi animated:YES completion:nil];
    } else {
        TapHandler handler = objc_getAssociatedObject(self, TapTouchUpInsidelHandlersKey);
        if (handler) {
            handler(sender);
        }
    }
}

@end
