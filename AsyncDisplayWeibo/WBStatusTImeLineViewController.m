//
//  WBStatusTImeLineViewController.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/1.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "WBStatusTImeLineViewController.h"
#import "WBTimeLineCell.h"
#import "WBStatusLayout.h"
#import "WBStatusHelper.h"
#import "YYModel.h"
#import "WBTimelineItemModel.h"
#import "WBTimeLineHardCell.h"

@interface WBStatusTImeLineViewController ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic,strong) NSMutableArray <WBStatusLayout *> *layoutArray;
@end

@implementation WBStatusTImeLineViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化控件
    self.tableNode.frame = self.view.bounds;
    [self.view addSubnode:self.tableNode];
    // 请求数据
    [self p_loadDatas];
}

#pragma mark - pravite methods
- (void)p_loadDatas {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int index = 0; index < 3; index++) {
            NSString *soureName = [NSString stringWithFormat:@"weibo_%d.json",index];
            NSData *weiboData = [WBStatusHelper WBDataWithSourceName:soureName];
            WBTimelineItemModel *timeLineModel = [WBTimelineItemModel yy_modelWithJSON:weiboData];
            for (WBStatusModel *status in timeLineModel.statuses) {
                WBStatusLayout *layout = [WBStatusLayout WBLayoutWithStatusModel:status];
                [self.layoutArray addObject:layout];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableNode reloadData];
        });
    });
}

#pragma mark - delegates
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 1;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.layoutArray.count;
}

- (ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBTimeLineCell *node = [[WBTimeLineCell alloc]init];
    node.statusLayout = self.layoutArray[indexPath.row];
    return node;
}

#pragma mark - getters
- (ASTableNode *)tableNode {
    if (_tableNode == nil) {
        _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
    }
    return _tableNode;
}

- (NSMutableArray<WBStatusLayout *> *)layoutArray {
    if (_layoutArray == nil) {
        _layoutArray = [NSMutableArray array];
    }
    return _layoutArray;
}
@end
