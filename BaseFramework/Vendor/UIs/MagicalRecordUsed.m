//
//  MagicalRecordUsed.m
//  BaseFramework
//
//  Created by wendongsheng on 15/5/13.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "MagicalRecordUsed.h"

@interface MagicalRecordUsed ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    UITableView *_tableView;
    UISearchBar *_textField;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MagicalRecordUsed

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ORANGE_COLOR;
    [self loadData];
    [self setupViews];
    [self setupNav];
}

- (void)setupNav{
    UISearchBar *text = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 160, 20)];
    text.tintColor = LIGHTGRAY_COLOR;
    text.delegate = self;
    _textField = text;
    self.navigationItem.titleView = text;
}

- (void)setupViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
//    [_tableView setEditing:YES animated:YES];
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewFH(headerView)-1, SCREEN_WIDTH, 1)];
    line.backgroundColor = GRAY_COLOR;
    [headerView addSubview:line];
    
    float jiange = (SCREEN_WIDTH-2*80)/3;
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(jiange+(80+jiange)*i, 5, 80, 30)];
        [button setBackgroundColor:GRAY_COLOR forState:UIControlStateNormal];
        [button setBackgroundColor:LIGHTGRAY_COLOR forState:UIControlStateHighlighted];
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
        if (i == 0) {
            [button setTitle:@"筛选" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [button setTitle:@"添加" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
        }
        [headerView addSubview:button];
    }
    
    _tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate && TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.dataArray[indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

#warning mark - 删除元素
    //删除coreData中的元素
    [self.dataArray[indexPath.row] MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    
    //删除数组中的元素
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UISearchBarDelegate 
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        [self loadData];
        [_tableView reloadData];
    }
}

#pragma mark - button event
#warning mark - 查询
- (void)select:(UIButton *)button{
    [self.dataArray removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS %@",_textField.text];
    NSArray *array = [HistoryModel MR_findAllSortedBy:@"date" ascending:NO withPredicate:predicate];
    [self.dataArray addObjectsFromArray:array];
    [_tableView reloadData];
}

#warning mark - 增加元素
- (void)add:(UIButton *)button{
    HistoryModel *item = [HistoryModel MR_createEntity];
    item.date = [NSDate date];
    item.title = _textField.text;
    
    //存储到coreData中
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    
    //存储数组中
    [self.dataArray insertObject:item atIndex:0];
    
    //cell上显示数据
    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationLeft];
    
    //设置滚动
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - private method
- (void)loadData{
    [self.dataArray removeAllObjects];
    NSArray *historyArray = [HistoryModel MR_findAllSortedBy:@"date" ascending:NO];
    for (HistoryModel *model in historyArray) {
        [self.dataArray addObject:model];
    }
}

#pragma mark - getter && setter
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

@end
