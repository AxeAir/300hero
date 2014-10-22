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
    // Do any additional setup after loading the view.
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

-(void)steup
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, Main_Screen_Width-40, 400)];
    
    label.text=@"本软件的数据均来自于300英雄官方网站，如有建议或发现BUG欢迎点右上角的联系我们";
    label.numberOfLines=0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.view addSubview:label];
}

- (void)sendMailInApp
{
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

- (void)toogleMenu
{
    [self.navigationController.sideMenuController toggleMenu:YES];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"关于300勇士盒"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"info@mrchenhao.com"];
    [mailPicker setToRecipients: toRecipients];
    //添加抄送
    //NSArray *ccRecipients = [NSArray arrayWithObjects:nil];
    //[mailPicker setCcRecipients:ccRecipients];
    //添加密送
   // NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //[mailPicker setBccRecipients:bccRecipients];
    
    // 添加一张图片
    //UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    //NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    //[mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //添加一个pdf附件
    //NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
    //NSData *pdf = [NSData dataWithContentsOfFile:file];
    //[mailPicker addAttachmentData: pdf mimeType: @"" fileName: @"高质量C++编程指南.pdf"];
    
    NSString *emailBody = @"您好！<br/>我是";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
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
