//
//  sigleMenu.h
//  300勇士盒
//
//  Created by ChenHao on 10/7/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class sigleMenu;
typedef void (^completion)(BOOL success, sigleMenu *item);
@interface sigleMenu : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) completion block;

-(id)initWithTitle:(NSString *)title image:(UIImage *)image onCompletion:(completion)completionBlock;
@end
