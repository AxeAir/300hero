//
//  EquipDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/9.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "EquipDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "UConstants.h"

@interface EquipDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *equipImageView;
@property (weak, nonatomic) IBOutlet UILabel *equipNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *equipProLabel;
@property (weak, nonatomic) IBOutlet UILabel *equipInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *equipPrice1Label;

@property (weak, nonatomic) IBOutlet UILabel *equipPrice2Label;

@end

@implementation EquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
}

- (void)configData {
    [self.equipImageView sd_setImageWithURL:[NSURL URLWithString:self.equip.img]];
    [self.equipNameLabel setText:self.equip.name];
    
    NSMutableString *proString = [[NSMutableString alloc] init];
    NSArray *pros = [self.equip.pro componentsSeparatedByString:@","];
    for (NSString *pro in pros) {
        [proString appendString:pro];
        if (![pro isEqualToString:[pros lastObject]]) {
            [proString appendString:@"\n"];
        }
    }
    
    [self.equipProLabel setText:proString];
    [self.equipInfoLabel setText:self.equip.info];
    [self.equipPrice1Label setText:self.equip.price1];
    [self.equipPrice2Label setText:self.equip.price2];
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
