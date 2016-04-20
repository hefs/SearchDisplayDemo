//
//  HoriSecondViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "HoriSecondViewController.h"
#import "CityModel.h"

@interface HoriSecondViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet UITableView *layout;

@end

@implementation HoriSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    datas = [[NSMutableArray alloc] initWithCapacity:0];
    __weak typeof(*&self) weakSelf = self;
    [CityModel getCitiesActionWithName:@"南昌" handler:^(NSArray *cities,NSError *error){
        [datas addObjectsFromArray:cities];
        [weakSelf.layout reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    CityModel *model = [datas objectAtIndex:indexPath.row];
    cell.textLabel.text = [model.province_cn stringByAppendingString:model.name_cn];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
