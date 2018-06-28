//
//  UIButton+Utils.h
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Handler)(UIButton *sender);

@interface UIButton (Utils)

- (void)makeRotation;

- (void)resetAnimation;
//block
- (void)r_setHandler:(Handler)handler andEvent:(UIControlEvents)event;
//倒计时
- (void)changeCode;

@end
