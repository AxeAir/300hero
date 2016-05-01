//
//  HeroDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 16/4/30.
//  Copyright © 2016年 xxTeam. All rights reserved.
//

#import "HeroDetailViewController.h"
#import <UIImageView+WebCache.h>

@interface HeroDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bigAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *heroIntroduceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *skillImageView1;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *skillIntroduceLabel1;

@property (weak, nonatomic) IBOutlet UIImageView *skillImageView2;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *skillIntroduceLabel2;

@property (weak, nonatomic) IBOutlet UIImageView *skillImageView3;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *skillIntroduceLabel3;

@property (weak, nonatomic) IBOutlet UIImageView *skillImageView4;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel4;
@property (weak, nonatomic) IBOutlet UILabel *skillIntroduceLabel4;

@property (weak, nonatomic) IBOutlet UIImageView *skillImageView5;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel5;
@property (weak, nonatomic) IBOutlet UILabel *skillIntroduceLabel5;

@property (weak, nonatomic) IBOutlet UILabel *hpLabel;
@property (weak, nonatomic) IBOutlet UILabel *adLabel;
@property (weak, nonatomic) IBOutlet UILabel *apLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *operateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;

@end

@implementation HeroDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _hero.name;
    [self commonInit];
}

- (void)commonInit {
    [self.bigAvatarImageView sd_setImageWithURL:[NSURL URLWithString:self.hero.bigimg]];
    self.heroIntroduceLabel.text = self.hero.introduce;
    
    NSData *skillsData = [self.hero.skills dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *skills = [NSJSONSerialization JSONObjectWithData:skillsData options:NSJSONReadingAllowFragments error:nil];
    
    
    NSDictionary *skill1 = skills[0];
    [self.skillImageView1 sd_setImageWithURL:[NSURL URLWithString:[skill1 objectForKey:@"img"]]];
    [self.skillNameLabel1 setText:[NSString stringWithFormat:@"%@ (%@)",[skill1 objectForKey:@"name"],[skill1 objectForKey:@"keyboard"]]];
    
    [self.skillIntroduceLabel1 setText:[skill1 objectForKey:@"introduce"]];
    
    NSDictionary *skill2 = skills[1];
    [self.skillImageView2 sd_setImageWithURL:[NSURL URLWithString:[skill2 objectForKey:@"img"]]];
    [self.skillNameLabel2 setText:[NSString stringWithFormat:@"%@ (%@)",[skill2 objectForKey:@"name"],[skill2 objectForKey:@"keyboard"]]];
    [self.skillIntroduceLabel2 setText:[skill2 objectForKey:@"introduce"]];
    
    NSDictionary *skill3 = skills[2];
    [self.skillImageView3 sd_setImageWithURL:[NSURL URLWithString:[skill3 objectForKey:@"img"]]];
    [self.skillNameLabel3 setText:[NSString stringWithFormat:@"%@ (%@)",[skill3 objectForKey:@"name"],[skill3 objectForKey:@"keyboard"]]];
    [self.skillIntroduceLabel3 setText:[skill3 objectForKey:@"introduce"]];
    
    NSDictionary *skill4 = skills[3];
    [self.skillImageView4 sd_setImageWithURL:[NSURL URLWithString:[skill4 objectForKey:@"img"]]];
    [self.skillNameLabel4 setText:[NSString stringWithFormat:@"%@ (%@)",[skill4 objectForKey:@"name"],[skill4 objectForKey:@"keyboard"]]];
    [self.skillIntroduceLabel4 setText:[skill4 objectForKey:@"introduce"]];
    
    NSDictionary *skill5 = skills[4];
    [self.skillImageView5 sd_setImageWithURL:[NSURL URLWithString:[skill5 objectForKey:@"img"]]];
    [self.skillNameLabel5 setText:[NSString stringWithFormat:@"%@ (%@)",[skill5 objectForKey:@"name"],[skill5 objectForKey:@"keyboard"]]];
    [self.skillIntroduceLabel5 setText:[skill5 objectForKey:@"introduce"]];
    
    
    NSData *rateData = [self.hero.rate dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *rate = [NSJSONSerialization JSONObjectWithData:rateData options:NSJSONReadingAllowFragments error:nil];
    
    [self.hpLabel setText:[NSString stringWithFormat:@"生命 %@",[rate objectForKey:@"hp"]]];
    [self.adLabel setText:[NSString stringWithFormat:@"物理 %@",[rate objectForKey:@"ad"]]];
    [self.apLabel setText:[NSString stringWithFormat:@"法术 %@",[rate objectForKey:@"ap"]]];
    [self.teamLabel setText:[NSString stringWithFormat:@"团队 %@",[rate objectForKey:@"team"]]];
    [self.operateLabel setText:[NSString stringWithFormat:@"操作 %@",[rate objectForKey:@"oper"]]];
    
    [self.priceLabel1 setText:[NSString stringWithFormat:@"金币价格 %@",_hero.price1]];
    [self.priceLabel2 setText:[NSString stringWithFormat:@"钻石价格 %@",_hero.price2]];
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
