//
//  WBStatusHeaderView.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/1.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineHeaderView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface WBTimeLineHeaderView()
@property (nonatomic,strong) UIImageView *headIconImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) YYLabel *timeSourceLabel;
@property (nonatomic,strong) UIButton *menuButton;
@end

@implementation WBTimeLineHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.timeSourceLabel];
        [self addSubview:self.menuButton];
        [self addSubview:self.headIconImageView];
    }
    return self;
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    // 位置
    self.headIconImageView.frame = statusLayout.headIconF;
    self.userNameLabel.frame = statusLayout.nickNameF;
    self.timeSourceLabel.frame = statusLayout.timeSourceF;
    // 数据
    self.userNameLabel.text = statusLayout.statusModel.user.screen_name;
    self.timeSourceLabel.text = statusLayout.statusModel.richSouce;
    [self.headIconImageView yy_setImageWithURL:[NSURL URLWithString:statusLayout.statusModel.user.profile_image_url] placeholder:nil];
}

#pragma mark - getters
- (UILabel *)userNameLabel {
    if (_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.font = [UIFont systemFontOfSize:KCellNickNameFont];
    }
    return _userNameLabel;
}

- (YYLabel *)timeSourceLabel {
    if (_timeSourceLabel == nil) {
        _timeSourceLabel = [[YYLabel alloc]init];
        _timeSourceLabel.font = [UIFont systemFontOfSize:KCellSourceFont];
    }
    return _timeSourceLabel;
}

- (UIButton *)menuButton {
    if (_menuButton == nil) {
        _menuButton = [[UIButton alloc]init];
        [_menuButton setTitle:@"MENU" forState:UIControlStateNormal];
    }
    return _menuButton;
}

- (UIImageView *)headIconImageView {
    if (_headIconImageView == nil) {
        _headIconImageView = [[UIImageView alloc]initWithCornerRadiusAdvance:KCellIconWidthHeight/2 rectCornerType:UIRectCornerAllCorners];
    }
    return _headIconImageView;
}
@end
