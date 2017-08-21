//
//  WBTimeLineCardView.h
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/8.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WBTimeLineCardView : UIView
@property (nonatomic,assign) BOOL isReweet;
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@end

// -----------------------video类型-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBTImeLineCardVideoView : UIView
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@end
