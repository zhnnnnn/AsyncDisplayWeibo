//
//  WBTimeLineCardNode.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface WBTimeLineCardNode : ASDisplayNode
@property (nonatomic,assign) BOOL isReweet;
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@end

// -----------------------video类型-----------------------
// ----------------------------------------------
// ----------------------------------------------
@interface WBTImeLineCardVideoNode : ASDisplayNode
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@end
