//
//  NSString+Utils.h
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)
//根据文字高度返回文字宽度
- (CGFloat)boundingWidthWithHeight:(CGFloat)height dict:(UIFont *)font;
//根据文字宽度返回文字高度
- (CGFloat)boundingHeightWithWidth:(CGFloat)width dict:(UIFont *)font;
//截取新的串,显示不同的颜色效果:一个label显示不同的颜色
- (NSAttributedString *)getCaptureNewString:(NSString *)captureLocation color:(UIColor *)color;
//截取新的串,显示不同的颜色效果:一个label显示不同字体和颜色
- (NSAttributedString *)getCaptureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font;
//获取当前时间
+ (NSString*)getCurrentTimesWithFormat:(NSString *)format;
//获取当前时间戳
+ (NSString *)getNowTimeTimestamp;
//判断用户名
- (BOOL)checkUserName;
//判断电话号
- (BOOL)checkPhoneNumber;
//判断邮箱
- (BOOL)checkMail;
//判断密码
- (BOOL)checkPassword;
//判断联系人姓名
- (BOOL)checkLinkman;
// 设置行间距，截取新的串,显示不同的颜色效果:一个label显示不同字体和颜色
- (NSAttributedString *)changeLineSpace:(float)space captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font;
// 设置字间距，截取新的串,显示不同的颜色效果:一个label显示不同字体和颜色
- (NSAttributedString *)changeWordSpace:(float)space captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font;
// 设置行字间距，截取新的串,显示不同的颜色效果:一个label显示不同字体和颜色
- (NSAttributedString *)changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font;
//随机生成117位字符串
+ (NSString *)getRandomString;
//md5加密
- (NSString *)md5WithString;
//url编码
- (NSString *)URLEncode;

- (int)lengthForCString;

- (NSString *)subStringWithByteLength:(int)length;

@end
