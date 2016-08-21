//
//  HomeViewController.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/22.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "HomeViewController.h"
#import "IBDesignable/IBDesignableViewController.h"
#import "SPHelper.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableContent;

@end

@implementation HomeViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableContent.rowHeight = UITableViewAutomaticDimension;
    self.tableContent.estimatedRowHeight = 44.0;
    self.tableContent.tableFooterView = [UIView new];
}

- (NSString *)filePath
{
    NSString *archiverFilePath = [NSString stringWithFormat:@"%@/archiver", NSHomeDirectory()];
    return archiverFilePath;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"HomeCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    UILabel *lblDesc = (UILabel *)[cell viewWithTag:100];
    if(indexPath.row==0)
    {
        lblDesc.text = @"IBDesignable/IBInspectable 是IOS8为我们提供的新特性，支持自定义属性映射到XIB(运行时机制) ";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *vc = [SPHelper viewControllerForStoryboardName:@"Home" class:[IBDesignableViewController class]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
