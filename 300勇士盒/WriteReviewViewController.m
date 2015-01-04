//
//  WriteReviewViewController.m
//  300勇士盒
//
//  Created by ChenHao on 1/3/15.
//  Copyright (c) 2015 xxTeam. All rights reserved.
//

#import "WriteReviewViewController.h"
#import "UConstants.h"
#import "CacheEntence.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDIndicatorView.h"
#import "JGProgressHUDIndeterminateIndicatorView.h"
#import "JGProgressHUDErrorIndicatorView.h"
@interface WriteReviewViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView                *ReviewText;
@property (nonatomic, strong) UILabel                   *label;

@end

@implementation WriteReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self layout];
}


- (void)initNav
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(review)];
    self.navigationItem.rightBarButtonItem=right;
}


- (void)review
{
    
//    新闻ID                      pageID
//    评论ID                      commentID
//    评论内容                   content
//    用户ID                      userID
    
    NSDictionary *paramters= [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_pageID],@"pageID",_ReviewText.text,@"content",@"0",@"commentID",@"yeti",@"userID", nil];
    [CacheEntence RequestRemoteURL:[NSString stringWithFormat:@"%@addComment/",DEBUG_URL] paramters:paramters Cache:NO success:^(id responseObject) {
        NSString *status= [responseObject objectForKey:@"Status"];
        if ([status isEqualToString:@"OK"]) {
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
            HUD.textLabel.text = @"Loading";
            //HUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
            //HUD.indicatorView = [jgprogresshuds]
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:1.0];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
       
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)layout
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _ReviewText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
   // [_ReviewText set]
    _ReviewText.delegate=self;
    _ReviewText.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_ReviewText];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, Main_Screen_Width, 20)];
    [_label setNumberOfLines:0];
    [_label setText:@"在这里写下你的评论"];
    [_ReviewText addSubview:_label];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""])
    {
        _label.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _label.hidden = NO;
    }
    return YES;
}


@end
