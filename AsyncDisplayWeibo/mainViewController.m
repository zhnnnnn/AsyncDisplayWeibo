//
//  mainViewController.m
//  AsyncDisplayWeibo
//
//  Created by zhn on 2017/8/21.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "mainViewController.h"
#import "WBTimeLineHardViewController.h"
#import "WBStatusTImeLineViewController.h"
#import "normalViewController.h"

@interface mainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *titleArray;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.titleArray = @[@"easy",@"hard",@"normal"];
}

#pragma mark - delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[[WBStatusTImeLineViewController alloc]init] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[[WBTimeLineHardViewController alloc]init] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[[normalViewController alloc]init] animated:YES];
        }
            break;
        default:
            break;
    }
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
@end
