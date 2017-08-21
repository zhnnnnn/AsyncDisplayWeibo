//
//  WBRichTextHelper.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/4.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBRichTextHelper.h"
typedef void(^WBEventAction)();
@implementation WBRichTextHelper
+ (NSAttributedString *)wb_attributeRuleString:(NSString *)string itemModel:(WBStatusModel *)itemModel{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedString yy_setFont:[UIFont systemFontOfSize:KCellContentTextFont] range:attributedString.yy_rangeOfAll];
    CGFloat fontWH = [UIFont systemFontOfSize:KCellContentTextFont].pointSize;
    // 友好显示链接
    for (WBUrlStructModel *urlModel in itemModel.url_struct) {
        if (urlModel.short_url.length == 0) {continue;}
        if (urlModel.url_title.length == 0) {continue;}
        NSString *urlTitle = urlModel.url_title;
        NSRange searchRange = NSMakeRange(0, attributedString.string.length);
        NSRange range = [attributedString.string rangeOfString:urlModel.short_url options:kNilOptions range:searchRange];
        
        // 替换的字符串
        NSMutableAttributedString *urlReplace = [[NSMutableAttributedString alloc]initWithString:urlTitle];
        if (range.location + range.length > attributedString.string.length) {continue;}
        urlReplace.yy_font = [UIFont systemFontOfSize:KCellContentTextFont];
        
        // icon
        if (urlModel.url_type_pic.length > 0) {
            UIImageView *structIconImageView = [[UIImageView alloc]init];
            structIconImageView.bounds = CGRectMake(0, 0, fontWH, fontWH);
            dispatch_async(dispatch_get_main_queue(), ^{
                [structIconImageView yy_setImageWithURL:[WBStatusHelper defaultURLForImageURL:urlModel.url_type_pic] placeholder:nil];
            });
            NSAttributedString *icon = [NSAttributedString yy_attachmentStringWithContent:structIconImageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(fontWH, fontWH) alignToFont:[UIFont systemFontOfSize:KCellContentTextFont] alignment:YYTextVerticalAlignmentCenter];
            [urlReplace insertAttributedString:icon atIndex:0];
        }
        
        // 事件点击
        [urlReplace yy_setTextHighlightRange:NSMakeRange(0, urlReplace.string.length) color:KCellLinkerColor backgroundColor:KCellLinkerBackColor userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"url单击");
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"url长按");
        }];
        [attributedString replaceCharactersInRange:range withAttributedString:urlReplace];
    }
    
    // @
    attributedString = [WBRichTextHelper regularExpressionAttribustring:attributedString regularExpression:[WBStatusHelper regexAt] tapAction:^{
        NSLog(@"tap");
    } longPressAction:^{
        NSLog(@"long");
    }];
    
    // #话题#
    attributedString = [WBRichTextHelper regularExpressionAttribustring:attributedString regularExpression:[WBStatusHelper regexTopic] tapAction:^{
        NSLog(@"tap");
    } longPressAction:^{
        NSLog(@"long");
    }];
    
    // emoji
    NSArray *emojiArray = [[WBStatusHelper regexEmoticon] matchesInString:attributedString.string options:kNilOptions range:attributedString.yy_rangeOfAll];
    for (NSTextCheckingResult *emoji in emojiArray) {
        if (emoji.range.location == NSNotFound || emoji.range.length <= 1) {continue;}
        if (emoji.range.location + emoji.range.length > attributedString.length) {continue;}
        NSString *emojiString = [attributedString.string substringWithRange:emoji.range];
        if (emojiString.length == 0) {continue;}
        NSString *imagePath = [[WBStatusHelper WBEmojiDict] objectForKey:emojiString];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        UIImageView *emojiImageView = [[UIImageView alloc]init];
        emojiImageView.bounds = CGRectMake(0, 0, fontWH, fontWH);
        emojiImageView.image = image;
        NSAttributedString *emojiReplaceString = [NSAttributedString yy_attachmentStringWithContent:emojiImageView contentMode:UIViewContentModeScaleAspectFill attachmentSize:CGSizeMake(fontWH, fontWH) alignToFont:[UIFont systemFontOfSize:KCellContentTextFont] alignment:YYTextVerticalAlignmentCenter];
        [attributedString replaceCharactersInRange:emoji.range withAttributedString:emojiReplaceString];
    }
    
    return attributedString;
}


+ (NSMutableAttributedString *)regularExpressionAttribustring:(NSMutableAttributedString *)attributeString regularExpression:(NSRegularExpression *)regular tapAction:(WBEventAction)tapAction longPressAction:(WBEventAction)lonPressAction {
    NSArray *regularArray = [regular matchesInString:attributeString.string options:kNilOptions range:attributeString.yy_rangeOfAll];
    for (NSTextCheckingResult *result in regularArray) {
        if (result.range.location == NSNotFound || result.range.length <= 1) {continue;}
        [attributeString yy_setTextHighlightRange:result.range color:KCellLinkerColor backgroundColor:KCellLinkerBackColor userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (tapAction) {
                tapAction();
            }
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (lonPressAction) {
                lonPressAction();
            }
        }];
    }
    return attributeString;
}




@end
