//
//  UITapGestureRecognizer+Utils.h
//  OfferManager
//
//  Created by rongwf on 2017/11/9.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapHandler)(UITapGestureRecognizer *sender);

@interface UITapGestureRecognizer (Utils)

- (void)r_setTapHandler:(TapHandler)handler;

@end
