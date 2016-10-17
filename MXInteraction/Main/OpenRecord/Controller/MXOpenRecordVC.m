//
//  MXOpenRecordVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordVC.h"

#import "MXOpenRecordSectionHeader.h"
#import "MXOpenRecordCell.h"

#import "MXOpenRecordModel.h"

static NSString *const openRecordCell = @"OpenRecordCell";
static NSString *const openRecordSectionHeader = @"OpenRecordSectionHeader";

@interface MXOpenRecordVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recordArray;

@end

@implementation MXOpenRecordVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, self.view.height - 64) style:UITableViewStylePlain];
    tableView.dataSource   = self;
    tableView.delegate     = self;
    tableView.tableFooterView = [[UIView alloc] init];
    self.tableView         = tableView;
    [self.view addSubview:tableView];
}

- (void)initData
{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"open.record"];
    NSLog(@"path==%@",path);
    
    self.recordArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

}

- (void)initConstraint
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MXOpenRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"openRecordCell"];
    if (!cell) {
        cell = [[MXOpenRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"openRecordCell"];
    }
    cell.model = self.recordArray[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    MXOpenRecordSectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"openRecordSectionHeader"];
//    if (!headerView) {
//        headerView = [[MXOpenRecordSectionHeader alloc] initWithReuseIdentifier:@"openRecordSectionHeader"];
//    }
//    headerView.title = @"周一";
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

@end
