//
//  WBTimeLineCell.h
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/2.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "WBStatusLayout.h"
@interface WBTimeLineCell : ASCellNode
@property (nonatomic,strong) WBStatusLayout *statusLayout;
@end
