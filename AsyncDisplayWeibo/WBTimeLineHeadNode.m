//
//  WBTimeLineHeadNode.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/3.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineHeadNode.h"

@interface WBTimeLineHeadNode()
@property (nonatomic,strong) ASTextNode *nickNameTextNode;
@property (nonatomic,strong) ASTextNode *timeSouceTextNode;
@property (nonatomic,strong) ASNetworkImageNode *headIconNode;
@end

@implementation WBTimeLineHeadNode
#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.nickNameTextNode];
        [self addSubnode:self.timeSouceTextNode];
        [self addSubnode:self.headIconNode];
    }
    return self;
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    // 设置位置
    self.headIconNode.frame = self.statusLayout.headIconF;
    self.nickNameTextNode.frame = self.statusLayout.nickNameF;
    self.timeSouceTextNode.frame = self.statusLayout.timeSourceF;
    // 设置数据
    self.headIconNode.URL = [NSURL URLWithString:self.statusLayout.statusModel.user.profile_image_url];
    self.nickNameTextNode.attributedText = [WBStatusHelper attributedStringWithText:self.statusLayout.statusModel.user.screen_name textFont:KCellNickNameFont textColor:[UIColor blackColor]];
    self.timeSouceTextNode.attributedText = [WBStatusHelper attributedStringWithText:self.statusLayout.statusModel.source textFont:KCellSourceFont textColor:[UIColor blackColor]];
}


#pragma mark - getters
- (ASTextNode *)nickNameTextNode {
    if (_nickNameTextNode == nil) {
        _nickNameTextNode = [[ASTextNode alloc]init];
    }
    return _nickNameTextNode;
}

- (ASTextNode *)timeSouceTextNode {
    if (_timeSouceTextNode == nil) {
        _timeSouceTextNode = [[ASTextNode alloc]init];
    }
    return _timeSouceTextNode;
}

- (ASNetworkImageNode *)headIconNode {
    if (_headIconNode == nil) {
        _headIconNode = [[ASNetworkImageNode alloc]init];
//        _headIconNode.cornerRadius = KCellIconWidthHeight/2;
        _headIconNode.clipsToBounds = YES;
    }
    return _headIconNode;
}
@end
