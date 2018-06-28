//
//  UIImage+Utils.h
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
//改变图片颜色
+ (UIImage *)r_createImageWithColor:(UIColor *)color;
//拉伸区域
+ (UIImage *)r_resizableImageWithName:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets;

+ (UIImage *)r_resizableImageWithImage:(UIImage *)changeImage capInsets:(UIEdgeInsets)capInsets;

@end
