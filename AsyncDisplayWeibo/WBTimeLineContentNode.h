//
//  WBTimeLineContentNode.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "WBStatusLayout.h"

@interface WBTimeLineContentNode : ASDisplayNode
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@property (nonatomic,assign) BOOL isReweet;
@end
