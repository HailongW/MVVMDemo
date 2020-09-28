//
//  ViewController.m
//  MVVMDemo
//
//  Created by 王海龙 on 2020/9/27.
//  Copyright © 2020 WHL. All rights reserved.
//

#import "ViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString * const reuserId = @"reuserId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, strong) MVVMViewModel *mvvmModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"宝马X7",@"奔驰S",@"奥迪Q8",@"布加迪",@"迈凯伦",@"劳斯莱斯",@"保时捷",@"法拉利"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.mvvmModel = [[MVVMViewModel alloc] init];
    
    __weak typeof(self) weakSelf = self;
    //绑定刷新UI的事件，将Block传入ViewModel中，当数据发生变化时调用
    /**
     // UI  <<---> MODEL  (BLOCK)  vm
     // model  --->  UI
     MVVM 核心思想是解耦+双向绑定，即通过viewModel 实现数据和UI的相互联动而View和Model完全解耦互相不依赖
     目前比较好的开发框架是RAC + MVVM
     */
    [self.mvvmModel initWithBlock:^(id  _Nonnull data) {
        NSArray *array = data;
        MVVMView *headerView = [[MVVMView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (array.count + 1)/4*50)];
        [headerView headViewInitWithData:data];
        weakSelf.tableView.tableHeaderView = headerView;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
    } fail:^(id  _Nonnull data) {
        NSLog(@"数据处理失败");
    }];
    
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark -- tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.mvvmModel.contentKey = self.dataArray[indexPath.row]; //UI页面数据发生变化，通过KVO触发事件绑定的successBlock处理
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (IBAction)didClickReloadDataItem:(id)sender {
    
    NSLog(@"刷新数据");
    [self.mvvmModel loadData];//刷新数据事件绑定
}


@end
