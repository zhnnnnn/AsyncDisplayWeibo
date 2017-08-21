//
//  WBTimeLineHardCell.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineHardCell.h"
#import "WBTimeLineContentNode.h"
#import "WBTimeLineHeadNode.h"
#import "WBTimeLineCardNode.h"

@interface WBTimeLineHardCell()
@property (nonatomic,strong) WBTimeLineHeadNode *headerNode;
@property (nonatomic,strong) WBTimeLineContentNode *contentNode;
@property (nonatomic,strong) WBTimeLineContentNode *reweetNode;
@end

@implementation WBTimeLineHardCell
#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubnode:self.headerNode];
        [self addSubnode:self.contentNode];
        [self addSubnode:self.reweetNode];
    }
    return self;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    return CGSizeMake(constrainedSize.width, self.statusLayout.cellHieight);
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    // 头部
    self.headerNode.frame = statusLayout.headContainerF;
    self.headerNode.statusLayout = statusLayout;
    // 内容
    self.contentNode.frame = statusLayout.contentContainerF;
    self.contentNode.statusLayout = statusLayout;
    // 转发
    self.reweetNode.frame = statusLayout.reweetContetConrainerF;
    self.reweetNode.isReweet = YES;
    self.reweetNode.statusLayout = statusLayout;
    // 显示隐藏
    if (statusLayout.statusModel.retweeted_status) {
        self.reweetNode.hidden = NO;
    }else {
        self.reweetNode.hidden = YES;
    }
}

#pragma mark - getters
- (WBTimeLineHeadNode *)headerNode {
    if (_headerNode == nil) {
        _headerNode = [[WBTimeLineHeadNode alloc]init];
    }
    return _headerNode;
}

- (WBTimeLineContentNode *)contentNode {
    if (_contentNode == nil) {
        _contentNode = [[WBTimeLineContentNode alloc]init];
    }
    return _contentNode;
}

- (WBTimeLineContentNode *)reweetNode {
    if (_reweetNode == nil) {
        _reweetNode = [[WBTimeLineContentNode alloc]init];
    }
    return _reweetNode;
}
@end
