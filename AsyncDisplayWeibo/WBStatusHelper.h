//
//  WBStatusHelper.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/1.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusHelper : NSObject
/**
 计算单行字体的高度

 @param font 字体的大小
 @return 文字的高度
 */
+ (CGFloat)oneLineTextHeightWithFont:(CGFloat)font;

/**
 计算宽度一定的情况下的文字高度

 @param text 需要计算的文字
 @param maxWidth 文字最大的宽度
 @param font 字体的大小
 @return 文字的高度
 */
+ (CGFloat)caluateTextHeightWithText:(NSString *)text MaxWidth:(CGFloat)maxWidth font:(CGFloat)font;

/**
 获取资源文件

 @param name 文件名字
 @return 资源文件
 */
+ (NSData *)WBDataWithSourceName:(NSString *)name;

/**
 生成富文本

 @param text 文字
 @param font 字体大小
 @param color 字体颜色
 @return 富文本
 */
+ (NSAttributedString *)attributedStringWithText:(NSString *)text textFont:(CGFloat)font textColor:(UIColor *)color;

/**
 At正则 例如 @王思聪
 */
+ (NSRegularExpression *)regexAt;

/**
 话题正则 例如 #暖暖环游世界#
 */
+ (NSRegularExpression *)regexTopic;

/**
 表情正则 例如 [偷笑]
 */
+ (NSRegularExpression *)regexEmoticon;

/**
 来源正则
 */
+ (NSRegularExpression *)regexSource;

/**
 来源正则过后的字符串
 */
+ (NSString *)regexedSouceString:(NSString *)needRegexString;

/**
 表情字典
 */
+ (NSDictionary *)WBEmojiDict;

/**
 获取富文本的高度

 @param attributeText 富文本
 @param maxWidth 最大的宽度
 @return 富文本的高度
 */
+ (CGFloat)heightForAttributeText:(NSAttributedString *)attributeText maxWidth:(CGFloat)maxWidth;

/**
 不可用的url处理

 @param imageURL url
 @return 可用的url
 */
+ (NSURL *)defaultURLForImageURL:(id)imageURL;

/**
 格式化时间

 @return 格式化的时间
 */
+ (NSString *)formatterDate:(NSDate *)date;
@end
