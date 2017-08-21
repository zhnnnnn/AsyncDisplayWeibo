//
//  WBTimeLineCardView.m
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/8.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineCardView.h"

@interface WBTimeLineCardView()
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) WBTImeLineCardVideoView *videoView;
@property (nonatomic,assign) WBCardType cardType;
@end

@implementation WBTimeLineCardView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // video
        [self addSubview:self.videoView];
        
        // 图片
        for (int index = 0; index < 9; index++) {
            UIImageView *picImageView = [[UIImageView alloc]init];
            picImageView.contentMode = UIViewContentModeScaleAspectFill;
            picImageView.layer.masksToBounds = YES;
            picImageView.hidden = YES;
            [self.imageViewArray addObject:picImageView];
            [self addSubview:picImageView];
        }
    }
    return self;
}

- (void)p_layoutCardWithstatusModel:(WBStatusModel *)statusModel picSize:(CGSize)picSize{
    self.cardType = self.isReweet ? _statusLayout.reweetContentCardType : _statusLayout.contentCardType;
    switch (self.cardType) {
        case WBCardTypeNone:
        {
            
        }
            break;
        case WBCardTypePic:
        {
            NSInteger picCount = statusModel.picModelArray.count;
            for (int index = 0; index < 9; index++) {
                UIImageView *imageView = self.imageViewArray[index];
                if (index < picCount) {
                    // 位置赋值
                    imageView.hidden = NO;
                    CGFloat x = (index % 3) * (KCellPicPadding + picSize.width);
                    CGFloat y = (index / 3) * (KCellPicPadding + picSize.height);
                    imageView.frame = CGRectMake(x, y, picSize.width, picSize.height);
                    // 图片赋值
                    WBPicModel *picModel = statusModel.picModelArray[index];
                    [imageView yy_setImageWithURL:[NSURL URLWithString:picModel.large.url] placeholder:nil];
                }
            }
        }
            break;
        case WBCardTypeVideo:
        {
            self.videoView.frame = CGRectMake(0, 0, picSize.width, picSize.height);
            self.videoView.statusLayout = self.statusLayout;
        }
            break;
        case WBCardTypeArtical:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark -setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    WBStatusModel *statusModel = self.isReweet ? statusLayout.statusModel.retweeted_status : statusLayout.statusModel;
    CGSize picSize = self.isReweet ? statusLayout.reweetPicSize : statusLayout.picSize;
    [self p_layoutCardWithstatusModel:statusModel picSize:picSize];    
}
#pragma mark - setters
- (void)setCardType:(WBCardType)cardType {
    _cardType = cardType;
    switch (cardType) {
        case WBCardTypePic:
        {
            self.videoView.hidden = YES;
        }
            break;
        case WBCardTypeNone:
        {
            self.videoView.hidden = YES;
        }
            break;
        case WBCardTypeVideo:
        {
            self.videoView.hidden = NO;
            for (UIImageView *itemView in self.imageViewArray) {
                itemView.hidden = YES;
            }
        }
            break;
        case WBCardTypeArtical:
        {
        
        }
            break;
        default:
            break;
    }
}

#pragma mark - getters
- (NSMutableArray *)imageViewArray {
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (WBTImeLineCardVideoView *)videoView {
    if (_videoView == nil) {
        _videoView = [[WBTImeLineCardVideoView alloc]init];
    }
    return _videoView;
}

@end


// -----------------------video类型-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBTImeLineCardVideoView()
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic,strong) UIImageView *playVideoIcon;
@property (nonatomic,strong) UILabel *playTimeLabel;
@property (nonatomic,strong) UILabel *videoLengthLabel;
@end

@implementation WBTImeLineCardVideoView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentImageView];
        [self addSubview:self.playVideoIcon];
        [self addSubview:self.playTimeLabel];
        [self addSubview:self.videoLengthLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentImageView.frame = self.bounds;
    
    self.playVideoIcon.center = self.center;
    self.playVideoIcon.bounds = CGRectMake(0, 0, 50, 50);
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    // 赋值
    [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:statusLayout.statusModel.page_info.page_pic] placeholder:nil];
}

#pragma mark - getters
- (UIImageView *)contentImageView {
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contentImageView.clipsToBounds = YES;
    }
    return _contentImageView;
}

- (UIImageView *)playVideoIcon {
    if (_playVideoIcon == nil) {
        _playVideoIcon = [[UIImageView alloc]init];
        _playVideoIcon.backgroundColor = [UIColor redColor];
    }
    return _playVideoIcon;
}

- (UILabel *)playTimeLabel {
    if (_playTimeLabel == nil) {
        _playTimeLabel = [[UILabel alloc]init];
    }
    return _playTimeLabel;
}

- (UILabel *)videoLengthLabel {
    if (_videoLengthLabel == nil) {
        _videoLengthLabel = [[UILabel alloc]init];
    }
    return _videoLengthLabel;
}
@end

