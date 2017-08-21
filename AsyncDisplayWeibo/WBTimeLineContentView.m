//
//  WBTimeLineContentView.m
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineContentView.h"
#import "WBTimeLineCardView.h"

@interface WBTimeLineContentView()
@property (nonatomic,strong) YYLabel *contentLabel;
@property (nonatomic,strong) WBTimeLineCardView *cardView;
@end


@implementation WBTimeLineContentView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentLabel];
        [self addSubview:self.cardView];
    }
    return self;
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    if (self.isReweet) {
        // 位置
        self.contentLabel.frame = statusLayout.reweetContentLabelF;
        self.cardView.frame = statusLayout.reweetContentCardContainerF;
        // 数据
        self.contentLabel.attributedText = statusLayout.statusModel.retweeted_status.richContent;
        self.cardView.isReweet = YES;
        self.cardView.statusLayout = statusLayout;
        self.backgroundColor = [UIColor lightGrayColor];
    }else {
        // 位置
        self.contentLabel.frame = statusLayout.contentLabelF;
        self.cardView.frame = statusLayout.cardContainerF;
        // 数据
        self.contentLabel.attributedText = statusLayout.statusModel.richContent;
        self.cardView.statusLayout = statusLayout;
        self.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - getters
- (YYLabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[YYLabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:KCellContentTextFont];
        _contentLabel.displaysAsynchronously = YES;
    }
    return _contentLabel;
}

- (WBTimeLineCardView *)cardView {
    if (_cardView == nil) {
        _cardView = [[WBTimeLineCardView alloc]init];
    }
    return _cardView;
}
@end
