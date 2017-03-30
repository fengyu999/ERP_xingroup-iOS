//
//  FirstViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/25.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"添加";
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(back)];
    
}

- (void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
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
