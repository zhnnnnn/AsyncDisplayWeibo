//
//  WBRichTextHelper.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/4.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBTimelineItemModel.h"

@interface WBRichTextHelper : NSObject
/**
 微博的富文本格式字符串

 @param string 字符串
 @return 富文本
 */
+ (NSAttributedString *)wb_attributeRuleString:(NSString *)string itemModel:(WBStatusModel *)itemModel;
@end
