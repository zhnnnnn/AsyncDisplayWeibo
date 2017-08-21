//
//  WBTimeLineCardNode.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBTimeLineCardNode.h"

@interface WBTimeLineCardNode()
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) WBTImeLineCardVideoNode *videoNode;
@property (nonatomic,assign) WBCardType cardType;
@end


@implementation WBTimeLineCardNode
#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        // video
        [self addSubnode:self.videoNode];
        // 图片
        for (int index = 0; index < 9; index++) {
            ASNetworkImageNode *picImageNode = [[ASNetworkImageNode alloc]init];
            picImageNode.contentMode = UIViewContentModeScaleAspectFill;
            picImageNode.layer.masksToBounds = YES;
            picImageNode.hidden = YES;
            [self.imageViewArray addObject:picImageNode];
            [self addSubnode:picImageNode];
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
                ASNetworkImageNode *imageNode = self.imageViewArray[index];
                if (index < picCount) {
                    // 位置赋值
                    imageNode.hidden = NO;
                    CGFloat x = (index % 3) * (KCellPicPadding + picSize.width);
                    CGFloat y = (index / 3) * (KCellPicPadding + picSize.height);
                    imageNode.frame = CGRectMake(x, y, picSize.width, picSize.height);
                    // 图片赋值
                    WBPicModel *picModel = statusModel.picModelArray[index];
                    imageNode.URL = [NSURL URLWithString:picModel.large.url];
                }
            }
        }
            break;
        case WBCardTypeVideo:
        {
            self.videoNode.frame = CGRectMake(0, 0, picSize.width, picSize.height);
            self.videoNode.statusLayout = self.statusLayout;
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
            self.videoNode.hidden = YES;
        }
            break;
        case WBCardTypeNone:
        {
            self.videoNode.hidden = YES;
        }
            break;
        case WBCardTypeVideo:
        {
            self.videoNode.hidden = NO;
            for (ASNetworkImageNode *itemNode in self.imageViewArray) {
                itemNode.hidden = YES;
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

- (WBTImeLineCardVideoNode *)videoNode {
    if (_videoNode == nil) {
        _videoNode = [[WBTImeLineCardVideoNode alloc]init];
    }
    return _videoNode;
}
@end

// -----------------------video类型-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBTImeLineCardVideoNode()
@property (nonatomic,strong) ASNetworkImageNode *contentImageNode;
@property (nonatomic,strong) ASNetworkImageNode *playVideoNode;
@property (nonatomic,strong) ASTextNode *playTimeTextNode;
@property (nonatomic,strong) ASTextNode *videoLengthNode;
@end

@implementation WBTImeLineCardVideoNode
- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.contentImageNode];
        [self addSubnode:self.playVideoNode];
        [self addSubnode:self.playTimeTextNode];
        [self addSubnode:self.videoLengthNode];
    }
    return self;
}

- (void)layout {
    [super layout];
    self.contentImageNode.frame = CGRectMake(0, 0, self.calculatedSize.width, self.calculatedSize.height);
}

#pragma mark - setters
- (void)setStatusLayout:(WBStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    
    // 赋值
    self.contentImageNode.URL =  [NSURL URLWithString:statusLayout.statusModel.page_info.page_pic];
}

#pragma mark - getters
- (ASNetworkImageNode *)contentImageNode {
    if (_contentImageNode == nil) {
        _contentImageNode = [[ASNetworkImageNode alloc]init];
    }
    return _contentImageNode;
}

- (ASNetworkImageNode *)playVideoNode {
    if (_playVideoNode == nil) {
        _playVideoNode = [[ASNetworkImageNode alloc]init];
        _playVideoNode.backgroundColor = [UIColor redColor];
    }
    return _playVideoNode;
}

- (ASTextNode *)playTimeTextNode {
    if (_playTimeTextNode == nil) {
        _playTimeTextNode = [[ASTextNode alloc]init];
    }
    return _playTimeTextNode;
}

- (ASTextNode *)videoLengthNode {
    if (_videoLengthNode == nil) {
        _videoLengthNode = [[ASTextNode alloc]init];
    }
    return _videoLengthNode;
}

@end
