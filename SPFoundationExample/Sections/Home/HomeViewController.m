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
#import "Person.h"
#import "Biology.h"
#import <objc/runtime.h>
#import "SPSerializeKit.h"

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
    
    Person *person = [[Person alloc] init];
    person.name = @"wengzilin";
    person.age = 26;
    [person setValue:@"laoweng" forKey:@"_father"];
    //set value of superClass
    person.introInBiology = @"I am a biology on earth";
    //[person setValue:@(10000) forKey:@"_hairCountInBiology"];//no access to private instance in super
    
    
    NSLog(@"Before archiver:\n%@", [person description]);
    
    WZLSERIALIZE_ARCHIVE(person, @"Person", [self filePath]);
    Person *thePerson = nil;
    WZLSERIALIZE_UNARCHIVE(thePerson, @"Person", [self filePath]);
    
    Person *copyPerson = [person copy];
    NSLog(@"copyPerson:%@", [copyPerson description]);
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
