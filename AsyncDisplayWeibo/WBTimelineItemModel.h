//
//  WBTimelineItemModel.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUserModel,WBStatusModel,WBUrlStructModel,WBPictureMetaData,WBPicModel,WBPageInfoModel,WBPageMediaInfo;

// -----------------------单次接口获取到的数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBTimelineItemModel : NSObject
@property (nonatomic,copy) NSArray <WBStatusModel *> *statuses;
@end

// -----------------------单条数据的model-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBStatusModel : NSObject
// -----------------------处理过后的富文本框,处理完缓存起来性能更好-----------------------
@property (nonatomic,copy) NSAttributedString *richContent;
@property (nonatomic,copy) NSString *richSouce;
@property (nonatomic,copy) NSString *souceLinker;
// -----------------------基础的数据-----------------------
// 文字内容
@property (nonatomic,copy) NSString *text;
// 来源
@property (nonatomic,copy) NSString *source;
// 时间
@property (nonatomic,strong) NSDate *created_at;
// 用户
@property (nonatomic,strong) WBUserModel *user;
// text对应链接数据
@property (nonatomic,copy) NSArray <WBUrlStructModel *> *url_struct;

// 图片数据的的字典
@property (nonatomic,strong) NSDictionary <NSString *, WBPicModel *> *pic_infos;
// 图片的id数组
@property (nonatomic,copy) NSArray <NSString *> *pic_ids;
// 图片的数组
@property (nonatomic,strong) NSArray <WBPicModel *> *picModelArray;

// 卡片类型(视频 文章)
@property (nonatomic,strong) WBPageInfoModel *page_info;

// 转发的数据
@property (nonatomic,strong) WBStatusModel *retweeted_status;
@end

// -----------------------user model-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBUserModel : NSObject
// 昵称
@property (nonatomic,copy) NSString *screen_name;
// 头像
@property (nonatomic,copy) NSString *profile_image_url;
@end

// -----------------------对应链接的数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBUrlStructModel : NSObject
// 短链(匹配text里的链接)
@property (nonatomic,copy) NSString *short_url;
// 原始链接
@property (nonatomic,copy) NSString *ori_url;
// 链接对应的标题
@property (nonatomic,copy) NSString *url_title;
// title前对应小图标
@property (nonatomic,copy) NSString *url_type_pic;
@end

// -----------------------图片数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBPicModel : NSObject
// 缩略图
@property (nonatomic,strong) WBPictureMetaData *thumbnail;
// 中图
@property (nonatomic,strong) WBPictureMetaData *bmiddle;
// 放大查看
@property (nonatomic,strong) WBPictureMetaData *large;
// 查看原图
@property (nonatomic,strong) WBPictureMetaData *largest;
@end

// -----------------------每一个图片的元数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBPictureMetaData : NSObject
// 图片url
@property (nonatomic,copy) NSString *url;
// 图片的宽度
@property (nonatomic,assign) CGFloat width;
// 图片的高度
@property (nonatomic,assign) CGFloat height;
@end

// -----------------------pageinfo 区分文章视频啥的-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBPageInfoModel : NSObject
// 类型
@property (nonatomic,assign) int type;
// 图片
@property (nonatomic,copy) NSString *page_pic;
// 标题
@property (nonatomic,copy) NSString *page_title;

// 不知道是啥
@property (nonatomic,copy) NSString *content1;
@property (nonatomic,copy) NSString *content2;

// 视频信息
@property (nonatomic,strong) WBPageMediaInfo *media_info;

@end

// -----------------------视频信息-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBPageMediaInfo : NSObject
// 名字
@property (nonatomic,copy) NSString *name;
// 在线人数？
@property (nonatomic,copy) NSString *online_users_number;
// 播放次数
@property (nonatomic,copy) NSString *online_users;
// 时长？
@property (nonatomic,assign) int duration;


// 视频url?
@property (nonatomic,copy) NSString *stream_url;
@property (nonatomic,copy) NSString *stream_url_hd;
@property (nonatomic,copy) NSString *h5_url;
@property (nonatomic,copy) NSString *mp4_sd_url;
@end



