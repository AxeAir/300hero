//
//  SighUpMore.m
//  SportMan
//
//  Created by Yeti on 7/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "SighUpMore.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import <sys/sysctl.h>
#import "UConstants.h"
#import "MyPublic.h"

@interface SighUpMore () <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UIPickerView *hwPicker;
@property (strong,nonatomic) UIToolbar *toolBar;
@property (strong,nonatomic) UIBarButtonItem *toolDoneBtn;
@property (strong,nonatomic) UIBarButtonItem *toolCancleBtn;
@property (strong,nonatomic) UIBarButtonItem *toolBarSpaceBtn;
@property (strong,nonatomic) UILabel *dateLabel;
@property (strong,nonatomic) UIButton *datePickerBtn;
@property (strong,nonatomic) UILabel *weightLabel;
@property (strong,nonatomic) UIButton *weightBtn;
@property (strong,nonatomic) UILabel *heightLabel;
@property (strong,nonatomic) UIButton *heightBtn;
@property (strong,nonatomic) NSMutableArray *weightArray;
@property (strong,nonatomic) NSString *weightStr;
@property (strong,nonatomic) NSMutableArray *heightArray;
@property (strong,nonatomic) NSString *heightStr;
@property (strong,nonatomic) NSMutableArray *dateArrray;
@property (assign,nonatomic) CGFloat halfWidth;
@property (strong,nonatomic) UIButton *saveBtn;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) NSDictionary *userDic;
@property (strong,nonatomic) NSUserDefaults *userDefaults;
@property (nonatomic,strong) NSUserDefaults *userdefault;
@property (strong,nonatomic) MyPublic *myPublic;

@end

@implementation SighUpMore

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(ISIPHONE){
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg"]];
        self.view.backgroundColor = background;
    }
    
    _myPublic = [[MyPublic alloc] init];
    
    _halfWidth = self.view.frame.size.width/2;
    _dateArrray = [[NSMutableArray alloc]init];
    _weightArray = [[NSMutableArray alloc]init];
    for (int i=40; i<100; i++) {
        [_weightArray addObject:[NSNumber numberWithInt:i]];
    }
    _heightArray = [[NSMutableArray alloc]init];
    for (int i=140; i<200; i++) {
        [_heightArray addObject:[NSNumber numberWithInt:i]];
    }
    
    //DateBtn
    int width = 200;
    int height = 30;
    int space = 8;
    int y = 130;
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height/2)];
    [_dateLabel setText:@"生日"];
    [_dateLabel setTextColor:[UIColor blackColor]];
    [_dateLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:_dateLabel];
    
    width = 200;
    height = 30;
    y += height/2 + space;
    
#define dateBtnTag 9996
    _datePickerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _datePickerBtn.backgroundColor = [UIColor whiteColor];
    //    _datePickerBtn.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    //    _datePickerBtn.layer.borderWidth = 1;
    _datePickerBtn.layer.cornerRadius = 3;
    [_datePickerBtn setTitle:@"1992-10-17" forState:UIControlStateNormal];
    [_datePickerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_datePickerBtn addTarget:self action:@selector(datePickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_datePickerBtn];
    _datePickerBtn.tag = dateBtnTag;

    y += height + space*3;
    _weightLabel = [[UILabel alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height/2)];
    [_weightLabel setText:@"体重"];
    [_weightLabel setTextColor:[UIColor blackColor]];
    [_weightLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:_weightLabel];
    
    //WeightBtn
    width = 200;
    y += height/2 + space;
#define weightBtnTag 9997
    _weightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _weightBtn.backgroundColor = [UIColor whiteColor];
    _weightBtn.layer.cornerRadius = 3;
    //    _weightBtn.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    //    _weightBtn.layer.borderWidth = 1;
    [_weightBtn setTitle:@"70 kg" forState:UIControlStateNormal];
    [_weightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_weightBtn addTarget:self action:@selector(hwPickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weightBtn];
    _weightBtn.tag = weightBtnTag;
    _hwPicker.tag = 2;
    
    y += height + space*3;
    _heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height/2)];
    [_heightLabel setText:@"身高"];
    [_heightLabel setTextColor:[UIColor blackColor]];
    [_heightLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:_heightLabel];
    
    //HeihgtBtn
    width = 200;
    y += height/2 + space;
#define heightBtnTag 9998
    _heightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2, y, width, height)];
    _heightBtn.backgroundColor = [UIColor whiteColor];
    _heightBtn.layer.cornerRadius = 3;
    //    _heightBtn.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    //    _heightBtn.layer.borderWidth = 1;
    [_heightBtn setTitle:@"160 cm" forState:UIControlStateNormal];
    [_heightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_heightBtn addTarget:self action:@selector(hwPickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_heightBtn];
    _heightBtn.tag = heightBtnTag;
    
    //SignUpBtn
    width = 200;
    height = 30;
    y += height + space*1;
    _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2,y, width, height)];
    [_saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    //    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    
    //Back
    width = 150;
    y += 30+ space*0;
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(_halfWidth-width/2,y, width, height)];
    [_backBtn setTitle:@"我已有账号" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [_backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    //DatePicker
#define dateTag 9999
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    _datePicker.backgroundColor = [UIColor colorWithWhite:0.99 alpha:0.9];
    [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];// 设置时区
    [_datePicker setDate:[NSDate date] animated:YES];// 设置当前显示时间
    [_datePicker setMaximumDate:[NSDate date]];// 设置显示最 大时间（此处为当前时间）
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.tag = dateTag;
    
    //heightViewPicker
    //weightViewPicker
#define hwPickerTag 10001
    _hwPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    _hwPicker.backgroundColor = [UIColor colorWithWhite:0.99 alpha:0.9];
    _hwPicker.tag = hwPickerTag;
    _hwPicker.delegate = self;
    _hwPicker.dataSource = self;
    
    //dateDoneToolBar
#define dateDoneBtn 10002
    _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    _toolBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    _toolCancleBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toolBarCancleBtnClick:)];
    _toolDoneBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolBarDoneBtnClick:)];
    _toolBarSpaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _toolBar.items = @[_toolCancleBtn,_toolBarSpaceBtn,_toolDoneBtn];
    _toolDoneBtn.tag = dateDoneBtn;

}
- (void)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden{
    return YES;//隐藏为YES，显示为NO
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_datePickerBtn isExclusiveTouch]) {
        [_datePickerBtn resignFirstResponder];
    }
    if (![_weightBtn isExclusiveTouch]) {
        [_weightBtn resignFirstResponder];
    }
    if (![_heightBtn isExclusiveTouch]) {
        [_heightBtn resignFirstResponder];
    }
}

- (void)toolBarDoneBtnClick:(id)sender{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if(_hwPicker.tag == 3){
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [self.datePickerBtn setTitle:[formatter stringFromDate:self.datePicker.date] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
        }];
        [UIView animateWithDuration:0.1 animations:^{
            self.datePicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216);
        }];
    }
    if (_hwPicker.tag == 1) {
        NSInteger index=[self.hwPicker selectedRowInComponent:0];
        _weightStr = self.weightArray[index];
        [self.weightBtn setTitle:[NSString stringWithFormat:@"%@ kg",self.weightArray[index]] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.hwPicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216);
        }];
        [UIView animateWithDuration:0.1 animations:^{
            self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
        }];
    }
    if(_hwPicker.tag == 2){
        NSInteger index=[self.hwPicker selectedRowInComponent:0];
        _heightStr = self.heightArray[index];
        [self.heightBtn setTitle:[NSString stringWithFormat:@"%@ cm",self.heightArray[index]] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            self.hwPicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216);
        }];
        [UIView animateWithDuration:0.1 animations:^{
            self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
        }];
    }
}

- (void)toolBarCancleBtnClick:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.hwPicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216);
    }];
}

- (void)datePickerBtnClick:(id)sender{
    [self.view addSubview:_datePicker];
    [UIView animateWithDuration:0.3 animations:^{
        self.datePicker.frame = CGRectMake(0, self.view.frame.size.height-216, self.view.frame.size.width, 216);
    }];
    [self.view addSubview:_toolBar];
    [UIView animateWithDuration:0.3 animations:^{
        self.toolBar.frame = CGRectMake(0, self.view.frame.size.height-266, self.view.frame.size.width, 50);
    }];
    _hwPicker.tag = 3;
}

- (void)hwPickerClick:(id)sender{
    if (((UIButton *)sender).tag == weightBtnTag){
        [self.view addSubview:_hwPicker];
        [UIView animateWithDuration:0.3 animations:^{
            self.hwPicker.frame = CGRectMake(0, self.view.frame.size.height-216, self.view.frame.size.width, 216);
        }];
        [self.view addSubview:_toolBar];
        [UIView animateWithDuration:0.3 animations:^{
            self.toolBar.frame = CGRectMake(0, self.view.frame.size.height-266, self.view.frame.size.width, 50);
        }];
        _hwPicker.tag = 1;//weight
    }
    if(((UIButton *)sender).tag == heightBtnTag){
        [self.view addSubview:_hwPicker];
        [UIView animateWithDuration:0.3 animations:^{
            self.hwPicker.frame = CGRectMake(0, self.view.frame.size.height-216, self.view.frame.size.width, 216);
        }];
        [self.view addSubview:_toolBar];
        [UIView animateWithDuration:0.3 animations:^{
            self.toolBar.frame = CGRectMake(0, self.view.frame.size.height-266, self.view.frame.size.width, 50);
        }];
        _hwPicker.tag = 2;//height
    }
    [_hwPicker reloadAllComponents];
}

+ (NSString *)getNums:(NSString *)str{
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    NSInteger number;
    [scanner scanInteger:&number];
    NSLog(@"number:%ld", (long)number);
    return [NSString stringWithFormat:@"%ld",(long)number];
}

- (void)signUpVarification{

    _weightStr = _weightBtn.titleLabel.text;
    _weightStr = [MyPublic getNums:_weightStr];
    _heightStr = _heightBtn.titleLabel.text;
    _heightStr = [MyPublic getNums:_heightStr];

}

- (void)saveBtnClick{
    _userdefault=[NSUserDefaults standardUserDefaults];
    NSString *User=[_userdefault objectForKey:@"userModel"];
    if (User==nil) {
        Login *loginView = [[Login alloc]init];
        [self presentViewController:loginView animated:NO completion:nil];
    }
    else{
        [self signUpVarification];
        //vartificaion right
        NSString *uID = [_userdefault objectForKey:@"uID"];
        NSString *birthdayStr = _datePickerBtn.titleLabel.text;
        NSString *URLUpdate=[NSString stringWithFormat:@"%@user/update/",DEBUG_URL];
        
            NSDictionary *paremters=[[NSDictionary alloc]initWithObjectsAndKeys:
                                     uID,@"uID",
                                     birthdayStr,@"birthday",
                                     _weightStr,@"weight",
                                     _heightStr,@"height",
                                     nil];
            BOOL nRet = false;
            nRet = [_myPublic PostMsg:URLUpdate WithSendDictionary:paremters WithImg:nil WithImgKey:@"" WithSuccess:^(NSDictionary *dicResult){
                if(dicResult == nil){
                    [_myPublic LogError:URLUpdate];
                }
                _userDefaults = [NSUserDefaults standardUserDefaults];
                //能获得uID即为已登录
                [_userDefaults setObject:birthdayStr forKey:@"birthday"];
                [_userDefaults setObject:_weightStr?_weightStr:@"0" forKey:@"weight"];
                [_userDefaults setObject:_heightStr?_heightStr:@"0" forKey:@"height"];
                [_userDefaults synchronize];
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
            if (!nRet) {
                [_myPublic LogError:URLUpdate];
            }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        if (component==0) {
            return [_weightArray count];
        }
        return 1;
        
    }
    else
    {
        if (component==0) {
            return [_heightArray count];
        }
        return 1;
        
        
    }
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        if (component==0) {
            return [NSString stringWithFormat:@"%@",[_weightArray objectAtIndex:row]];
        }
        else{
            return @"Kg";
        }
    }
    else
    {
        if (component==0) {
            return [NSString stringWithFormat:@"%@",[_heightArray objectAtIndex:row]];
        }
        else{
            return @"cm";
        }
    }
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
