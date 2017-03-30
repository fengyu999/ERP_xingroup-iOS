//
//  MainUsercenterViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/25.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "MainUsercenterViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "FirstViewController.h"
#import "MainUserCenterCell.h"
#import "LoginViewController.h"
#import "Test112ViewController.h"
#import "TestNavigationViewController.h"

#define kScreen_width self.view.frame.size.width
#define kScreen_height self.view.frame.size.height

@interface MainUsercenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MainUsercenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20+60+5, kScreen_width - 80, kScreen_height - 20) style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.opaque = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.tableFooterView=[[UIView alloc] init];
    _tableView.tableHeaderView=[[UIView alloc] init];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerClass:[MainUserCenterCell class] forCellReuseIdentifier:@"MainUserCenterCell"];
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId=@"MainUserCenterCell";
    MainUserCenterCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    cell.textLabel.text=cellId;
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.font=[UIFont systemFontOfSize:13.0f];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kAppDelegate.showLeftController = YES;
    if(indexPath.row==0){
        Test112ViewController *testVC=[[Test112ViewController alloc] init];
        [self pushToNextController:testVC];
    }else if(indexPath.row==1){
        TestNavigationViewController *testNav=[TestNavigationViewController new];
        [self pushToNextController:testNav];
    }else{
        LoginViewController *first=[[LoginViewController alloc] init];
        [self pushToNextController:first];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void) pushToNextController:(UIViewController *)nextController{
    
    [self.sideMenuViewController hideMenuViewController];
    
    UITabBarController *navigation = (UITabBarController *)self.sideMenuViewController.contentViewController;
    UINavigationController *rootNavCtr = navigation.viewControllers[0];
    UIViewController *rootVC=rootNavCtr.viewControllers[0];
    nextController.hidesBottomBarWhenPushed=YES;
    [rootVC.navigationController pushViewController:nextController animated:YES];
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
