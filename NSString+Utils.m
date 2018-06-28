//
//  NSString+Utils.m
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)

- (CGFloat)boundingWidthWithHeight:(CGFloat)height dict:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

- (CGFloat)boundingHeightWithWidth:(CGFloat)width dict:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

- (NSAttributedString *)getCaptureNewString:(NSString *)captureLocation color:(UIColor *)color {
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:self];
    if ([[newStr string] rangeOfString:captureLocation].location != NSNotFound) {
        NSInteger location = [[newStr string] rangeOfString:captureLocation].location;
        [newStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location,captureLocation.length)];
    }
    return newStr;
}

- (NSAttributedString *)getCaptureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:self];
    if ([[newStr string] rangeOfString:captureLocation].location != NSNotFound) {
        NSInteger location = [[newStr string] rangeOfString:captureLocation].location;
        [newStr addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font} range:NSMakeRange(location, captureLocation.length)];
    }
    return newStr;
}

+ (NSString*)getCurrentTimesWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (NSString *)getNowTimeTimestamp {
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dateNow timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

//  判断是否以字母开头
- (BOOL)isEnglishFirst {
    NSString *regular = @"^[A-Za-z].+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    if ([predicate evaluateWithObject:self] == YES){
        return YES;
    }else{
        return NO;
    }
}
//  判断是否以汉字开头
- (BOOL)isChineseFirst {
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    BOOL b = [self getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)checkUserName {
    if (![self isEnglishFirst] && ![self isChineseFirst]) {
        return NO;
    }
    //6-20位数字和字母组成
    NSString *regex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]{2,18}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

- (BOOL)checkLinkman {
    NSString *regex = @"(^[\u4e00-\u9fa5]{2,15}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

- (BOOL)checkPhoneNumber {
    NSString *regex = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

- (BOOL)checkMail {
    //6-20位数字和字母组成
    NSString *regex = @"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

- (BOOL)checkPassword {
    if (self.length >= 6 && self.length <= 24) {
        return YES;
    } else {
        return NO;
    }
}

- (NSAttributedString *)changeLineSpace:(float)space captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];

    NSInteger location = [[attributedString string] rangeOfString:captureLocation].location;
    [attributedString addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font} range:NSMakeRange(location, captureLocation.length)];
    return attributedString;
}

- (NSAttributedString *)changeWordSpace:(float)space captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    NSInteger location = [[attributedString string] rangeOfString:captureLocation].location;
    [attributedString addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font} range:NSMakeRange(location, captureLocation.length)];
    return attributedString;
}

- (NSAttributedString *)changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace captureNewString:(NSString *)captureLocation color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    NSInteger location = [[attributedString string] rangeOfString:captureLocation].location;
    [attributedString addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font} range:NSMakeRange(location, captureLocation.length)];
    return attributedString;
}

// 生成字符串长度
#define kRandomLength 117
// 随机字符表
static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *)getRandomString {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
    for (int i = 0; i < kRandomLength; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}
//MD5加密
- (NSString *)md5WithString {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)URLEncode {
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    NSString *urlEncode = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding)));
    return urlEncode;
}

/**
 *  计算字符串字节长度,中文一个字节，英文0.5字节
 *
 *  @return 字节长度
 */
- (int)lengthForCString {
    int strlength = 0;
    char * p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i ++) {
        if (* p) {
            p ++;
            strlength ++;
        }
        else {
            p ++;
        }
    }
    return (strlength + 1)/2;
}

/**
 *  按字节数截取字符串，中文一个字节，英文0.5字节，如果最后字符是半个中文，自动抛掉最后一个字符
 *
 *  @param length 字节数
 *
 *  @return 截取后的字符串
 */
- (NSString *)subStringWithByteLength:(int)length {
    float bytesCount = 0;
    float lastBytesCount = 0;
    for (int i = 1; i <= self.length; i ++) {
        if ([[self substringWithRange:NSMakeRange(i - 1, 1)] lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            bytesCount ++;
        } else {
            bytesCount += 0.5;
        }
        if (bytesCount > length) {
            return [self substringWithRange:NSMakeRange(0, i - 1)];
        } else if (bytesCount == length) {
            return [self substringWithRange:NSMakeRange(0, i)];
        } else {
            lastBytesCount = bytesCount;
        }
    }
    return @"按字节截取字符串出错，请检查截取字节是否超出范围。";
}

@end
