//
//  WBStatusHelper.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/1.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBStatusHelper.h"
#import "WBEmojiContentModel.h"

@implementation WBStatusHelper
+ (CGFloat)oneLineTextHeightWithFont:(CGFloat)font {
    NSString *temp = @"啊";
    CGRect stringRect = [temp boundingRectWithSize:CGSizeMake(1000, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return stringRect.size.height;
}

+ (CGFloat)caluateTextHeightWithText:(NSString *)text MaxWidth:(CGFloat)maxWidth font:(CGFloat)font {
    CGRect stringRect = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return stringRect.size.height;
}

+ (NSData *)WBDataWithSourceName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@""];
    if (path == nil) {
        return nil;
    }else {
        return [NSData dataWithContentsOfFile:path];
    }
}

+ (NSAttributedString *)attributedStringWithText:(NSString *)text textFont:(CGFloat)font textColor:(UIColor *)color {
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:font],
                                 NSForegroundColorAttributeName : color,
                                 NSBaselineOffsetAttributeName : @0
                                 };
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
}

+ (NSRegularExpression *)regexAt {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 微博的 At 只允许 英文数字下划线连字符，和 unicode 4E00~9FA5 范围内的中文字符，这里保持和微博一致。。
        // 目前中文字符范围比这个大
        regex = [NSRegularExpression regularExpressionWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSRegularExpression *)regexTopic {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSRegularExpression *)regexSource {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).*?(?=<)" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSString *)regexedSouceString:(NSString *)needRegexString {
    NSArray *souceArray = [[WBStatusHelper regexSource] matchesInString:needRegexString options:kNilOptions range:NSMakeRange(0, needRegexString.length)];
    NSTextCheckingResult *check = souceArray.firstObject;
    if (check.range.location == NSNotFound || check.range.length <= 1) {
        return nil;
    }else {
     return [needRegexString substringWithRange:check.range];
    }
}

+ (NSDictionary *)WBEmojiDict {
    static NSMutableDictionary *emojiDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emojiDict = [NSMutableDictionary dictionary];
        NSString *emojiBunldePath = [[NSBundle mainBundle]pathForResource:@"Emoticons" ofType:@"bundle"];
        NSString *emojiImageFolderPath = [emojiBunldePath stringByAppendingPathComponent:@"emoticonImage"];
        // 正则对应图片的字典
        NSString *emojiDictPath = [[emojiBunldePath stringByAppendingPathComponent:@"com.sina.default"] stringByAppendingPathComponent:@"content.plist"];
        NSDictionary *emojiContentDict = [NSDictionary dictionaryWithContentsOfFile:emojiDictPath];
        WBEmojiContentModel *contentModel = [WBEmojiContentModel yy_modelWithDictionary:emojiContentDict];
        for (WBEmojiItemModel *emoji in contentModel.emoticons) {
            NSString *emojiImagePath = [emojiImageFolderPath stringByAppendingPathComponent:emoji.png];
            if (emojiImagePath.length == 0) {continue;}
            if (emoji.cht.length > 0) {
                [emojiDict setObject:emojiImagePath forKey:emoji.cht];
            }
            if (emoji.chs.length > 0) {
               [emojiDict setObject:emojiImagePath forKey:emoji.chs];
            }
        }
    });
    return emojiDict;
}

+ (CGFloat)heightForAttributeText:(NSAttributedString *)attributeText maxWidth:(CGFloat)maxWidth {
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    container.maximumNumberOfRows = 0;
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributeText];
    return layout.textBoundingSize.height;
}

+ (NSURL *)defaultURLForImageURL:(id)imageURL {
    /*
     微博 API 提供的图片 URL 有时并不能直接用，需要做一些字符串替换：
     */
    if (!imageURL) return nil;
    NSString *link = nil;
    if ([imageURL isKindOfClass:[NSURL class]]) {
        link = ((NSURL *)imageURL).absoluteString;
    } else if ([imageURL isKindOfClass:[NSString class]]) {
        link = imageURL;
    }
    if (link.length == 0) return nil;
    
    if ([link hasSuffix:@".png"]) {
        // add "_default"
        if (![link hasSuffix:@"_default.png"]) {
            NSString *sub = [link substringToIndex:link.length - 4];
            link = [sub stringByAppendingFormat:@"_default.png"];
        }
    } else {
        // replace "_y.png" with "_os7.png"
        NSRange range = [link rangeOfString:@"_y.png?version"];
        if (range.location != NSNotFound) {
            NSMutableString *mutable = link.mutableCopy;
            [mutable replaceCharactersInRange:NSMakeRange(range.location + 1, 1) withString:@"os7"];
            link = mutable;
        }
    }
    return [NSURL URLWithString:link];
}

+ (NSString *)formatterDate:(NSDate *)date; {
    NSDateFormatter *showFormatter = [[NSDateFormatter alloc]init];
    showFormatter.dateFormat = @"yyyy HH:mm";
    NSString *showString = [showFormatter stringFromDate:date];
    return showString;
}
@end
