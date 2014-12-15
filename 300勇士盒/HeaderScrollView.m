//
//  HeaderScrollView.m
//  300勇士盒
//
//  Created by ChenHao on 12/8/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "HeaderScrollView.h"
#import <UIImageView+WebCache.h>
#import "UConstants.h"
#import "NewsModel.h"
@interface HeaderScrollView()<UIScrollViewDelegate>


@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollview;

@end

@implementation HeaderScrollView


-(instancetype)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self createScroll];
    }
    return self;
}

- (void)setHeaderImage:(NSArray *)array
{
    //图片的宽
    CGFloat imageW = self.frame.size.width;
    //CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = self.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    //    图片中数
    NSInteger totalCount;
    if ([array count]>=5) {
        totalCount=5;
    }
    else
    {
        totalCount=[array count];
    }
    
    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //图片X
        CGFloat imageX = i * imageW;
        //设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        //设置图片
        NewsModel *model=array[i];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/meta/%@",DEBUG_URL,model.img]];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        //隐藏指示条
        _scrollview.showsHorizontalScrollIndicator = NO;
        [_scrollview addSubview:imageView];
    }
    
    //    2.设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    //不允许在垂直方向上进行滚动
    _scrollview.contentSize = CGSizeMake(contentW, 0);
}

-(void)createScroll
{
    
    _scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollview];
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 130, self.frame.size.width, self.frame.size.height-130)];
    _pageControl.numberOfPages=5;
    [self addSubview:_pageControl];
    
    //图片的宽
    CGFloat imageW = self.frame.size.width;
    //CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = self.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    //    图片中数
    NSInteger totalCount = 5;
    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //图片X
        CGFloat imageX = i * imageW;
        //设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        //设置图片
        NSString *name = [NSString stringWithFormat:@"img1.jpg"];
        imageView.image = [UIImage imageNamed:name];
        //隐藏指示条
        _scrollview.showsHorizontalScrollIndicator = NO;
        [_scrollview addSubview:imageView];
    }
    
    //    2.设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
        //不允许在垂直方向上进行滚动
    _scrollview.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    _scrollview.pagingEnabled = YES;
        
    //    4.监听scrollview的滚动
    _scrollview.delegate = self;
    
    
    [self addTimer];
}

- (void)nextImage
{
    int page = (int)_pageControl.currentPage;
    if (page == 4) {
        page = 0;
    }else
    {
        page++;
    }
    
     //  滚动scrollview
    CGFloat x = page * self.frame.size.width;
    _scrollview.contentOffset = CGPointMake(x, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动中");
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;

    _pageControl.currentPage = page;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    开启定时器
    [self addTimer];
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
//    [self.timer invalidate];

    [self removeTimer];
}


- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [_timer invalidate];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
