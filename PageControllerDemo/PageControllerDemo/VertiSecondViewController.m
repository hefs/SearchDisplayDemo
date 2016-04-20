//
//  VertiSecondViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "VertiSecondViewController.h"

@interface VertiSecondViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSArray *Items;
    NSArray *filteredItems;
    UISearchController *searchController;
}
@property (nonatomic,weak) IBOutlet UITableView *layoutTable;
@property (nonatomic,strong)  UISearchBar *displaySearchBar;
@property (nonatomic,strong) UISearchDisplayController *searchDisplayCtrs;
@end


@implementation VertiSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Items = @[@"123",@"adv",@"752",@"qwcx",@"汉字",@"%$%^"];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        resultsController必须设为nil，否则搜索时会闪退
        searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
//        searchController.hidesNavigationBarDuringPresentation = NO;
        //搜索时不显示灰色背景，使得搜索结果可交互
        searchController.dimsBackgroundDuringPresentation = NO;
        _layoutTable.tableHeaderView = searchController.searchBar;
    }else{
        //不能直接[self.view addSubView:self.displaySearchBar] ,否则会显示异常
        _layoutTable.tableHeaderView = self.displaySearchBar;
        _searchDisplayCtrs = [[UISearchDisplayController alloc] initWithSearchBar:self.displaySearchBar contentsController:self];
        _searchDisplayCtrs.delegate = self;
        _searchDisplayCtrs.searchResultsTableView.delegate = self;
        _searchDisplayCtrs.searchResultsTableView.dataSource = self;
    }
}

- (UISearchBar *)displaySearchBar{
    if (!_displaySearchBar) {
        _displaySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 44)];
        _displaySearchBar.delegate = self;
        _displaySearchBar.placeholder = @"SearchDisplay";
        _displaySearchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
        
    }
    return _displaySearchBar;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (searchController.isActive) {
        return filteredItems.count;
    }
    return [tableView isEqual:_layoutTable] ? Items.count : filteredItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentity];
    }
    NSString *text = [tableView isEqual:_layoutTable] ? Items[indexPath.row] : filteredItems[indexPath.row];
    if (searchController.isActive) {
        text = filteredItems[indexPath.row];
    }
    cell.textLabel.text = text;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (!searchText.length) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchText];
    filteredItems = [Items filteredArrayUsingPredicate:predicate];
    [self.searchDisplayCtrs.searchResultsTableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (!searchController.searchBar.text.length) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchController.searchBar.text];
    filteredItems = [Items filteredArrayUsingPredicate:predicate];
    [_layoutTable reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
