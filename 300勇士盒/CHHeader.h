//
//  CHHeader.h
//  ScaleHeader
//
//  Created by ChenHao on 10/9/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CHScaleHeaderDelegate
@optional
-(void) DidStartScaleHeader;
-(void) DidEndScaleHeader;
@end

@interface CHHeader : NSObject<UIScrollViewDelegate>



+ (id)initWithView:(UIScrollView*)scrollView headerView:(UIView*)HeaderView;




- (void)initWithView:(UIScrollView*)scrollView headerView:(UIView*)HeaderView;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@property (assign,nonatomic) id<CHScaleHeaderDelegate> delegate;

@end
