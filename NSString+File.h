//
//  NSString+File.h
//  OfferManager
//
//  Created by rongwf on 2017/10/18.
//  Copyright © 2017年 rongwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)
//document根文件夹
+ (NSString *)documentFolder;
//生成子文件夹
+ (NSString *)createSubFolder:(NSString *)subFolder;
//获取机型
+ (NSString *)getDeviceName;

@end
