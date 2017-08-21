//
//  WBEmojiContentModel.m
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/5.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBEmojiContentModel.h"

@implementation WBEmojiContentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"emoticons" : [WBEmojiItemModel class],
             };
}
@end

// -----------------------每个emoji对应的数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBEmojiItemModel

@end
