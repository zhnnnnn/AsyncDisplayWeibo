//
//  WBTimelineItemModel.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimelineItemModel.h"
#import "YYModel.h"
// -----------------------单次接口获取到的数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBTimelineItemModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"statuses" : [WBStatusModel class]};
}
@end

// -----------------------单条数据的model-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBStatusModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
//             @"user" : [WBUserModel class],
             @"url_struct" : [WBUrlStructModel class],
             @"pic_infos" : [WBPicModel class],
             @"pic_ids" : [NSString class]
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dict {
    _picModelArray = nil;
    if (_pic_ids.count > 0) {
        NSMutableArray *picModelArray = [NSMutableArray array];
        for (NSString *key in _pic_ids) {
            WBPicModel *model = _pic_infos[key];
            [picModelArray addObject:model];
        }
        _picModelArray = [picModelArray copy];
    }
    
    return YES;
}
@end

// -----------------------user model-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBUserModel

@end

// -----------------------匹配链接url-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBUrlStructModel

@end

// -----------------------图片数据的model-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBPicModel

@end

// -----------------------每个图片的元数据-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBPictureMetaData

@end

// -----------------------pageinfo 区分文章视频啥的-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBPageInfoModel

@end

// -----------------------视频信息-----------------------
// ----------------------------------------------
// ----------------------------------------------
@implementation WBPageMediaInfo

@end
