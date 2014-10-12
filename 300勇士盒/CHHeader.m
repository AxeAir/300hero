//
//  CHHeader.m
//  ScaleHeader
//
//  Created by ChenHao on 10/9/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "CHHeader.h"

@implementation CHHeader
{
    __weak UIScrollView *_scrollView; //scrollView或者其子类
    __weak UIView *_headerView; //背景可以伸展的View
    CGFloat _headerHeight;
    BOOL isPull;
}


+ (id)initWithView:(UIScrollView *)scrollView headerView:(UIView *)HeaderView
{
    CHHeader *header=[CHHeader new];
    [header initWithView:scrollView headerView:HeaderView];
    return header;
}



-(void)initWithView:(UIScrollView *)scrollView headerView:(UIView *)HeaderView
{
    _headerHeight=CGRectGetHeight(HeaderView.frame);
    
    _scrollView=scrollView;
    
    _scrollView.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
    
    [_scrollView insertSubview:HeaderView atIndex:0];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, -180)];
    
    _headerView= HeaderView;
    
    //_expandView.contentMode=UIViewContentModeScaleAspectFill;
    //_expandView.clipsToBounds=YES;
    isPull=NO;
    [self resizeView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset" ]) {
        
        //NSLog(@"%f",_scrollView.contentOffset.y);
        [self scrollViewDidScroll:_scrollView];
        if(isPull==NO)
        {
            [_delegate DidStartScaleHeader];
            isPull=YES;
        }
        if(isPull==YES&&_scrollView.contentOffset.y==-_headerHeight)
        {
            [_delegate DidEndScaleHeader];
            isPull=NO;
        }
    }
    else
        return;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < _headerHeight * -1) {
        CGRect currentFrame = _headerView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _headerView.frame = currentFrame;
    }
}

-(void)resizeView
{
    [_headerView setFrame:CGRectMake(0, -1*_headerHeight, CGRectGetWidth(_headerView.frame), _headerHeight)];
}


-(void)dealloc
{
    if(_scrollView)
    {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        _scrollView=nil;
    }
    _headerView=nil;
}
@end
