//
//  UIImage+Utils.m
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)r_createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)r_resizableImageWithName:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets {
    UIImage *changeImage = [UIImage imageNamed:imageName];
    changeImage = [changeImage resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    return changeImage;
}

+ (UIImage *)r_resizableImageWithImage:(UIImage *)changeImage capInsets:(UIEdgeInsets)capInsets {
    changeImage = [changeImage resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    return changeImage;
}

@end
