//
//  WBEmojiContentModel.h
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/5.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBEmojiItemModel;
@interface WBEmojiContentModel : NSObject
@property (nonatomic,copy) NSString *group_icon_name;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,strong) NSArray <WBEmojiItemModel *> *emoticons;
@end

// -----------------------每个emoji对应的数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
//chs = "[\U8bb8\U613f]";
//cht = "[\U8a31\U9858]";
//gif = "lxh_xuyuan.gif";
//png = "lxh_xuyuan.png";
//type = 0;
@interface WBEmojiItemModel : NSObject
// 简体中文
@property (nonatomic, strong) NSString *chs;
// 繁体中文
@property (nonatomic, strong) NSString *cht;
// gif图片名字
@property (nonatomic, strong) NSString *gif;
// png图片名字
@property (nonatomic, strong) NSString *png;
//
@property (nonatomic, strong) NSString *type;
@end
