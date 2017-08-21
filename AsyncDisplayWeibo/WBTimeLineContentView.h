//
//  WBTimeLineContentView.h
//  AsyncDisplayWeibo
//
//  Created by 张辉男 on 17/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBStatusLayout.h"
@interface WBTimeLineContentView : UIView
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@property (nonatomic,assign) BOOL isReweet;
@end
