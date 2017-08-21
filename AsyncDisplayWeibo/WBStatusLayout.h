//
//  WBStatusLayout.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WBTimelineItemModel.h"

typedef NS_ENUM(NSInteger,WBCardType) {
    WBCardTypeNone,
    WBCardTypeArtical,
    WBCardTypePic,
    WBCardTypeVideo
};

@interface WBStatusLayout : NSObject
// -----------------------公开的方法-----------------------
+ (instancetype)WBLayoutWithStatusModel:(WBStatusModel *)statusModel;
- (void)updateDate;
// -----------------------微博的数据----------------------- 
@property (nonatomic,strong) WBStatusModel *statusModel;
// -----------------------cell的高度-----------------------
@property (nonatomic,assign) CGFloat cellHieight;

// --
// 图片的size
@property (nonatomic,assign) CGSize picSize;
// 卡片内容类型
@property (nonatomic,assign) WBCardType contentCardType;

// -- 转发
// 转发的图片的size
@property (nonatomic,assign) CGSize reweetPicSize;
// 转发的卡片类型
@property (nonatomic,assign) WBCardType reweetContentCardType;

// -----------------------头部-----------------------
// 头像
@property (nonatomic,assign) CGRect headIconF;
// 昵称
@property (nonatomic,assign) CGRect nickNameF;
// 项目来源
@property (nonatomic,assign) CGRect timeSourceF;
// 头部菜单按钮
@property (nonatomic,assign) CGRect headMenuF;
// 头部容器
@property (nonatomic,assign) CGRect headContainerF;
// -----------------------正文-----------------------
// 正文的文字
@property (nonatomic,assign) CGRect contentLabelF;
// 正文卡片
@property (nonatomic,assign) CGRect cardContainerF;
// 正文容器
@property (nonatomic,assign) CGRect contentContainerF;

// -----------------------转发的数据-----------------------
// 文字
@property (nonatomic,assign) CGRect reweetContentLabelF;
// 内容卡片
@property (nonatomic,assign) CGRect reweetContentCardContainerF;
// 转发的容器
@property (nonatomic,assign) CGRect reweetContetConrainerF;
@end
