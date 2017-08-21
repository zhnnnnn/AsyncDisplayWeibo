//
//  WBStatusLayout.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBStatusLayout.h"
#import "WBStatusHelper.h"

@interface WBStatusLayout()
@property (nonatomic,assign) CGFloat cardHeight;
@property (nonatomic,assign) CGFloat reweetCardHeight;
@end

@implementation WBStatusLayout
+ (instancetype)WBLayoutWithStatusModel:(WBStatusModel *)statusModel {
    WBStatusLayout *statusLayout = [[WBStatusLayout alloc]init];
    statusLayout.statusModel = statusModel;
    [statusLayout layout];
    return statusLayout;
}

- (void)updateDate {
    [self p_layoutHeader];
}

#pragma mark - pravite methods
- (void)layout {
    [self p_dealRichText];
    [self p_layoutHeader];
    [self p_layoutContent];
}

- (void)p_dealRichText {
    self.statusModel.richContent = [WBRichTextHelper wb_attributeRuleString:self.statusModel.text itemModel:self.statusModel];
    self.statusModel.retweeted_status.richContent = [WBRichTextHelper wb_attributeRuleString:[NSString stringWithFormat:@"@%@:%@",self.statusModel.retweeted_status.user.screen_name,self.statusModel.retweeted_status.text] itemModel:self.statusModel];
    self.statusModel.richSouce =    [NSString stringWithFormat:@"%@   %@",[WBStatusHelper formatterDate:self.statusModel.created_at],[WBStatusHelper regexedSouceString:self.statusModel.source]];
}

- (void)p_layoutHeader {
    // 头像
    self.headIconF = CGRectMake(KCellPadding, KCellPadding, KCellIconWidthHeight, KCellIconWidthHeight);
    // 昵称
    CGFloat KNickNameX = CGRectGetMaxX(self.headIconF) + KCellPaddingText;
    CGFloat KNickNameHeight = [WBStatusHelper oneLineTextHeightWithFont:KCellNickNameFont];
    self.nickNameF = CGRectMake(KNickNameX, KCellPadding, KCellNickNameMaxWidth, KNickNameHeight);
    // 来源
    CGFloat KSourceX = KNickNameX;
    CGFloat KSourceY = CGRectGetMaxY(self.nickNameF) + KAUTOSCALE(3);
    self.timeSourceF = CGRectMake(KSourceX, KSourceY, KCellNickNameMaxWidth, [WBStatusHelper oneLineTextHeightWithFont:KCellSourceFont]);
    // 头部容器
    self.headContainerF = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.headIconF));
}

- (void)p_layoutContent {
    
    // 卡片类型的计算
//    CGFloat cardContentHeight = 0;
//    CGFloat reweetContentHeight = 0;
    [self p_caluatePicSizeWithStatus:self.statusModel isReweet:NO contentHeight:self.cardHeight];
    if (self.statusModel.retweeted_status.user) {
       [self p_caluatePicSizeWithStatus:self.statusModel isReweet:YES contentHeight:self.reweetCardHeight];
    }
    
//    NSLog(@"%f",reweetContentHeight);
    
    // --原创
    // 文字
    CGFloat contetLabelH = [WBStatusHelper heightForAttributeText:self.statusModel.richContent maxWidth:KCellContentWidth];
    self.contentLabelF = CGRectMake(KCellPadding, KCellPaddingText, KCellContentWidth, contetLabelH);
    // 卡片容器
    CGFloat cardContainerY = CGRectGetMaxY(self.contentLabelF) + KCellPaddingText;
    self.cardContainerF = CGRectMake(KCellPadding, cardContainerY, KCellContentWidth, self.cardHeight);
    // 卡片加上内容
    CGFloat contentContainerH = CGRectGetMaxY(self.cardContainerF) - self.contentLabelF.origin.y;
    CGFloat contentContainerY = KCellPaddingText + CGRectGetMaxY(self.headContainerF);
    self.contentContainerF = CGRectMake( 0, contentContainerY, SCREEN_WIDTH, contentContainerH);
    
    // --转发
    // 文字
    CGFloat reweetLabelH = [WBStatusHelper heightForAttributeText:self.statusModel.retweeted_status.richContent maxWidth:KCellContentWidth];
    self.reweetContentLabelF = CGRectMake(KCellPadding, KCellPaddingText, KCellContentWidth, reweetLabelH);
    // 卡片容器
    CGFloat reweetCardContainerY = CGRectGetMaxY(self.reweetContentLabelF) + KCellPaddingText;
    self.reweetContentCardContainerF = CGRectMake(KCellPadding, reweetCardContainerY, KCellContentWidth, self.reweetCardHeight);
    // 卡片加上内容
    CGFloat reweetContainerH = CGRectGetMaxY(self.reweetContentCardContainerF) - self.reweetContentLabelF.origin.y + 20;
    CGFloat reweetContainerY = CGRectGetMaxY(self.contentContainerF) + KCellPaddingText;
    self.reweetContetConrainerF = CGRectMake(0, reweetContainerY, SCREEN_WIDTH, reweetContainerH);
    
    self.cellHieight = CGRectGetMaxY(self.reweetContetConrainerF);
}

- (void)p_caluatePicSizeWithStatus:(WBStatusModel *)statusModel isReweet:(BOOL)isReweet contentHeight:(CGFloat)contentHeight{
    // 图片类型
    CGSize picSize = CGSizeZero;
    CGFloat cardContentHeight = 0;
    if (statusModel.picModelArray.count > 0) {// 有图片的情况下
        self.contentCardType = WBCardTypePic;
        CGFloat picCount = statusModel.picModelArray.count;
        CGFloat picWH = (SCREEN_WIDTH - 2 * KCellPadding - (picCount - 1) * KCellPicPadding) / picCount;
        CGFloat line3minPicWH = (SCREEN_WIDTH - 2 * KCellPadding - 2 * KCellPicPadding) / 3;
        CGFloat line2minPicWH = (SCREEN_WIDTH - 2 * KCellPadding - KCellPicPadding) / 2;
        CGFloat onePicSmall = (SCREEN_WIDTH - 2 * KCellPadding) / 2;
        CGFloat onePicLong = 1.4 * onePicSmall;
        switch (statusModel.picModelArray.count) {
            case 1:// 特殊处理,按比例
            {
                WBPicModel *picModel = [statusModel.picModelArray firstObject];
                WBPictureMetaData *middlePictureMetaData = picModel.bmiddle;
                if (middlePictureMetaData.width > middlePictureMetaData.height) {
                    picSize = CGSizeMake(onePicLong, onePicSmall);
                }else {
                    picSize = CGSizeMake(onePicSmall, onePicLong);
                }
                cardContentHeight = picSize.height;
            }
                break;
            case 2 : case 3:
            {
                picSize = CGSizeMake(picWH, picWH);
                cardContentHeight = picSize.height;
            }
                break;
            case 4:
            {
                picSize = CGSizeMake(line2minPicWH, line2minPicWH);
                cardContentHeight = picSize.height * 2 + KCellPicPadding;
            }
                break;
            case 5: case 6:
            {
                picSize = CGSizeMake(line3minPicWH, line3minPicWH);
                cardContentHeight = picSize.height * 2 + KCellPicPadding;
            }
                break;
            case 7: case 8: case 9:
            {
                picSize = CGSizeMake(line3minPicWH, line3minPicWH);
                cardContentHeight = picSize.height * 3 + 2 * KCellPicPadding;
            }
                break;
        }
    }
    
    // 视频
    if ([statusModel.page_info isKindOfClass:[WBPageInfoModel class]]) {
        if (statusModel.page_info.type == 11) {
            if (isReweet) {
                self.reweetContentCardType = WBCardTypeVideo;
            }else {
                self.contentCardType = WBCardTypeVideo;
            }
            picSize = CGSizeMake(SCREEN_WIDTH - 2 * KCellPadding, 0.5 * (SCREEN_WIDTH - 2 * KCellPadding));
            cardContentHeight = picSize.height;
        }
    }
    
    if (isReweet) {
        self.reweetPicSize = picSize;
        self.reweetCardHeight = cardContentHeight;
        self.cardHeight = 0;
    }else {
        self.picSize = picSize;
        self.cardHeight = cardContentHeight;
    }
    
}

#pragma mark - setters
- (void)setStatusModel:(WBStatusModel *)statusModel {
    _statusModel = statusModel;
}
@end
