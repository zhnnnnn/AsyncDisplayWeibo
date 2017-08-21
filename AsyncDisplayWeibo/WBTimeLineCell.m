//
//  WBTimeLineCell.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineCell.h"
#import "WBTimeLineHeaderView.h"
#import "WBTimeLineContentView.h"
#import "WBTimeLineHeadNode.h"

@interface WBTimeLineCell()
@property (nonatomic,strong) ASDisplayNode *headerNode;
@property (nonatomic,strong) ASDisplayNode *contentNode;
@property (nonatomic,strong) ASDisplayNode *reweetNode;
@end

@implementation WBTimeLineCell
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
    WBTimeLineHeaderView *headView = (WBTimeLineHeaderView *)self.headerNode.view;
    headView.statusLayout = statusLayout;
    // 内容
    self.contentNode.frame = statusLayout.contentContainerF;
    WBTimeLineContentView *contentView = (WBTimeLineContentView *)self.contentNode.view;
    contentView.statusLayout = statusLayout;
    // 转发
    self.reweetNode.frame = statusLayout.reweetContetConrainerF;
    WBTimeLineContentView *reweetView = (WBTimeLineContentView *)self.reweetNode.view;
    reweetView.isReweet = YES;
    reweetView.statusLayout = statusLayout;
    // 显示隐藏
    if (statusLayout.statusModel.retweeted_status) {
        self.reweetNode.hidden = NO;
    }else {
        self.reweetNode.hidden = YES;
    }
}

#pragma mark - getters
- (ASDisplayNode *)headerNode {
    if (_headerNode == nil) {
        _headerNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
            WBTimeLineHeaderView *header = [[WBTimeLineHeaderView alloc]init];
            return header;
        }];
    }
    return _headerNode;
}

- (ASDisplayNode *)contentNode {
    if (_contentNode == nil) {
        _contentNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
            WBTimeLineContentView *contentView = [[WBTimeLineContentView alloc]init];
            return contentView;
        }];
    }
    return _contentNode;
}

- (ASDisplayNode *)reweetNode {
    if (_reweetNode == nil) {
        _reweetNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
            WBTimeLineContentView *reweetView = [[WBTimeLineContentView alloc]init];
            return reweetView;
        }];
    }
    return _reweetNode;
}

@end
