//
//  MXHomeLeftKeyBagVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeLeftKeyBagVC.h"
#import "MXUserKeyBagModel.h"

static NSString * const cellIdentifier = @"cellIdentifier";

@interface MXHomeLeftKeyBagVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MXHomeLeftKeyBagVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor mx_colorWithHexString:@"F5F4F4"];
    tableView.tableFooterView = [[UIView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keysArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = [self getKeyNameWithNumber:self.keysArray[indexPath.row].name];
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 处理钥匙名称
- (NSString *)getKeyNameWithNumber:(NSString *)number
{
    NSRange districtNo = NSMakeRange(2, 2);
    NSString *district = [number substringWithRange:districtNo];
    
    NSRange buildingNo = NSMakeRange(4, 2);
    NSString *building = [number substringWithRange:buildingNo];
    
    NSRange unitNo = NSMakeRange(6, 2);
    NSString *unit = [number substringWithRange:unitNo];
    
    NSString *room = [number substringFromIndex:12];
    
    return  [NSString stringWithFormat:@"%@小区%@栋%@单元%@号房间", district, building, unit, room];
}

@end
