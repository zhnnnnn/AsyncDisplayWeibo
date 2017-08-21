//
//  WBTimeLineNormalTableViewCell.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineNormalTableViewCell.h"
#import "WBTimeLineHeaderView.h"
#import "WBTimeLineContentView.h"
@interface WBTimeLineNormalTableViewCell()
@property (nonatomic,strong) WBTimeLineHeaderView *headerView;
@property (nonatomic,strong) WBTimeLineContentView *timeLineContentView;
@property (nonatomic,strong) WBTimeLineContentView *reweetView;
@end


@implementation WBTimeLineNormalTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headerView];
        [self addSubview:self.timeLineContentView];
        [self addSubview:self.reweetView];
    }
    return self;
}

- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    // 头部
    self.headerView.frame = statusLayout.headContainerF;
    self.headerView.statusLayout = statusLayout;
    // 内容
    self.timeLineContentView.frame = statusLayout.contentContainerF;
    self.timeLineContentView.statusLayout = statusLayout;
    // 转发
    self.reweetView.frame = statusLayout.reweetContetConrainerF;
    self.reweetView.isReweet = YES;
    self.reweetView.statusLayout = statusLayout;
    // 显示隐藏
    if (statusLayout.statusModel.retweeted_status) {
        self.reweetView.hidden = NO;
    }else {
        self.reweetView.hidden = YES;
    }
}

#pragma mark - getters
- (WBTimeLineContentView *)timeLineContentView {
    if (_timeLineContentView == nil) {
        _timeLineContentView = [[WBTimeLineContentView alloc]init];
    }
    return _timeLineContentView;
}

- (WBTimeLineHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[WBTimeLineHeaderView alloc]init];
    }
    return _headerView;
}

- (WBTimeLineContentView *)reweetView {
    if (_reweetView == nil) {
        _reweetView = [[WBTimeLineContentView alloc]init];
    }
    return _reweetView;
}

@end
