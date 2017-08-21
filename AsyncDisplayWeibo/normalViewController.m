//
//  normalViewController.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "normalViewController.h"
#import "WBTimeLineNormalTableViewCell.h"

@interface normalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <WBStatusLayout *> *layoutArray;
@end

@implementation normalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
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
            [self.tableView reloadData];
        });
    });
}

#pragma mark - delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layoutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBTimeLineNormalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (normalCell == nil) {
        normalCell = [[WBTimeLineNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    normalCell.statusLayout = self.layoutArray[indexPath.row];
    return normalCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutArray[indexPath.row].cellHieight;
}
#pragma mark - getters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray<WBStatusLayout *> *)layoutArray {
    if (_layoutArray == nil) {
        _layoutArray = [NSMutableArray array];
    }
    return _layoutArray;
}

@end
