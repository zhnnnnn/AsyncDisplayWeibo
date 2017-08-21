//
//  WBTimeLineContentNode.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineContentNode.h"
#import "WBTimeLineCardNode.h"
@interface WBTimeLineContentNode()
@property (nonatomic,strong) ASDisplayNode *contentTextNode;
@property (nonatomic,strong) WBTimeLineCardNode *cardNode;
@end

@implementation WBTimeLineContentNode
- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.contentTextNode];
        [self addSubnode:self.cardNode];
    }
    return self;
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    if (self.isReweet) {
        // 位置
        self.contentTextNode.frame = statusLayout.reweetContentLabelF;
        self.cardNode.frame = statusLayout.reweetContentCardContainerF;
        // 数据
        YYLabel *label = (YYLabel *)self.contentTextNode.view;
        label.attributedText = statusLayout.statusModel.retweeted_status.richContent;
        self.cardNode.isReweet = YES;
        self.cardNode.statusLayout = statusLayout;
        self.backgroundColor = [UIColor lightGrayColor];
    }else {
        // 位置
        self.contentTextNode.frame = statusLayout.contentLabelF;
        self.cardNode.frame = statusLayout.cardContainerF;
        // 数据
        YYLabel *label = (YYLabel *)self.contentTextNode.view;
        label.attributedText = statusLayout.statusModel.richContent;
        self.cardNode.statusLayout = statusLayout;
        self.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - getters
- (ASDisplayNode *)contentTextNode {
    if (_contentTextNode == nil) {
        _contentTextNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
            YYLabel *label = [[YYLabel alloc]init];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:KCellContentTextFont];
            label.displaysAsynchronously = YES;
            return label;
        }];
    }
    return _contentTextNode;
}


- (WBTimeLineCardNode *)cardNode {
    if (_cardNode == nil) {
        _cardNode = [[WBTimeLineCardNode alloc]init];
    }
    return _cardNode;
}
@end
