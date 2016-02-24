//
//  AbountViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/20/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "AbountViewController.h"
#import "UIViewController+CHSideMenu.h"
#import "UConstants.h"

@interface AbountViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation AbountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"关于";
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor colorWithRed:200/255.0 green:120/255.0  blue:10/255.0  alpha:1] forKey:NSForegroundColorAttributeName];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"联系我们" style:UIBarButtonItemStyleDone target:self action:@selector(sendMailInApp)];
    self.navigationItem.rightBarButtonItem=right;
    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStyleDone target:self action:@selector(toogleMenu)];
    self.navigationItem.leftBarButtonItem=left;
    [self steup];
}

-(void)steup {
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    
    UIView *about=[[UIView alloc] initWithFrame:CGRectMake(10, 10, Main_Screen_Width-20, 140)];
    about.layer.borderWidth=1;
    about.layer.borderColor=[UIColor grayColor].CGColor;
    UIImageView *logo=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1024.png"]];
    [logo setFrame:CGRectMake(5, 5, 130, 130)];
    
    [about addSubview:logo];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(150, 10, 140, 80)];
    
    label.text=@"我们对300英雄和二次元的热爱造就了300英雄榜";
    label.font=[UIFont systemFontOfSize:14];
    label.numberOfLines=0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textColor=[UIColor whiteColor];
    
    [about addSubview:label];
    [self.view addSubview:about];
    
    UIButton *feedback=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [feedback setFrame:CGRectMake(10, MaxY(about)+10, Main_Screen_Width-20, 50)];
    feedback.layer.borderWidth=1;
    feedback.layer.borderColor=[UIColor grayColor].CGColor;
    [feedback setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [feedback setTitle:@"意见反馈" forState:UIControlStateNormal];
    [feedback addTarget:self action:@selector(sendMailInApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedback];
    
}

//- (void)AVfeedback
//{
//    AVUserFeedbackAgent *agent = [AVUserFeedbackAgent sharedInstance];
//    [agent showConversations:self title:@"feedback" contact:@"info@mrchenhao.com"];
//}

- (void)sendMailInApp {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        //[self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        return;
    }
    if (![mailClass canSendMail]) {
        //[self alertWithMessage:@"用户没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}

- (void)toogleMenu {
    [self.navigationController.sideMenuController toggleMenu:YES];
}

//调出邮件发送窗口
- (void)displayMailPicker {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"关于300勇士盒"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"300hero@mrchenhao.com"];
    [mailPicker setToRecipients: toRecipients];
    
    NSString *emailBody = @"您好！<br/>我是";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    //关闭邮件发送窗口
    
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self alertWithMessage:msg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
