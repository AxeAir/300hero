//
//  sigleMenu.m
//  300勇士盒
//
//  Created by ChenHao on 10/7/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "sigleMenu.h"

@implementation sigleMenu


-(id)initWithTitle:(NSString *)title image:(UIImage *)image;
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.image = image;
        self.imageView = [[UIImageView alloc]initWithImage:image];
        self.imageView.frame = CGRectMake(0, 0, 40, 40);
    }
    return self;
}
@end
