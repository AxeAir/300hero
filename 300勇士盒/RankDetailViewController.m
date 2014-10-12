//
//  RankDetailViewController.m
//  300勇士盒
//
//  Created by ChenHao on 10/12/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "RankDetailViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface RankDetailViewController ()

@end

@implementation RankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getDetail];
}


- (void)getDetail
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    NSLog(@"%d",_ID);
    [manager POST:[NSString stringWithFormat:@"http://300report.jumpw.com/api/getrank?type=%d",_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString *result=[responseObject objectForKey:@"Result"];
        if([result isEqualToString:@"OK"])
        {
            NSDictionary *Rank=[responseObject objectForKey:@"Rank"];
            self.title=[Rank objectForKey:@"Title"];
            
        }
        
       // NSArray *List=[Rank objectForKey:@"List"];
        
        
        
        
        //NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        //for (NSDictionary *temp in List) {
            //RankTypeModel *model=[[RankTypeModel alloc] init];
            //model.Index=[[temp objectForKey:@"Index"] integerValue];
            //model.Name=[temp objectForKey:@"Name"];
            ////model.RankChange=[[temp objectForKey:@"RankChange"] integerValue];
//model.Url=[temp objectForKey:@"Url"];
            //model.Value=[temp objectForKey:@"Value"];
            //[tempArray addObject:model];
       // }
        //dataArray=tempArray;
        //[self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
