//
//  HeroDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/30.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "HeroDetailViewController.h"


@interface HeroDetailViewController ()

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _hero.name;
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
