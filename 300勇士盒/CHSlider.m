//
//  CHSlider.m
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "CHSlider.h"


// contants

const CGFloat CHSliderDefaultMenuWidth = 200.0;
const CGFloat CHSliderDefaultDamping = 0.5;
const CGFloat CHSlderMinimumRelativePanDistanceToOpen=0.5;

const CGFloat CHSliderMenuDefaultOpenAnimationTime=1.2;
const CGFloat CHSliderMenuDefaultCloseAnimationTime=0.4;

@interface CHSlider ()
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;
@end

@implementation CHSlider


- (id)initWithContentController:(UIViewController *)contentController menuController:(UIViewController *)menuController
{
    self=[super initWithNibName:nil bundle:nil];
    if(self)
    {
        _contentController=contentController;
        _menuController=menuController;
        _menuWidth=CHSliderDefaultMenuWidth;
        _tapGestureEnable=NO;
        _panGestureEnbale=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.menuController];
    [self.menuController didMoveToParentViewController:self];
    
    [self addChildViewController:self.contentController];
    [self.contentController didMoveToParentViewController:self];
    
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _containerView.autoresizingMask=UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:self.contentController.view];
    self.contentController.view.frame=self.containerView.bounds;
    self.contentController.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_containerView];
    
    self.tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    self.panRecognizer=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [self.containerView addGestureRecognizer:self.tapRecognizer];
    [self.containerView addGestureRecognizer:self.panRecognizer];
    
}


#pragma mark Controller replacement
- (void)setContentController:(UIViewController *)contentController animted:(BOOL)animated
{
    if(contentController==nil)
        return;
    UIViewController *previousCOntroller=self.contentController;
    _contentController=contentController;
    
    [self addChildViewController:self.contentController];
    
    self.contentController.view.frame=self.containerView.bounds;
    self.contentController.view.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    __weak typeof(self) blockSelf=self;
    CGFloat offset=CHSliderDefaultMenuWidth+(self.view.frame.size.width-CHSliderDefaultMenuWidth)/2.0;
    [UIView animateWithDuration:1 animations:^{
        blockSelf.containerView.transform=CGAffineTransformMakeTranslation(offset, 0);
        
    } completion:^(BOOL finished) {
        [blockSelf.containerView addSubview:self.contentController.view];
        [blockSelf.contentController didMoveToParentViewController:blockSelf];
        
        [previousCOntroller willMoveToParentViewController:self];
        [previousCOntroller removeFromParentViewController];
        [previousCOntroller.view removeFromSuperview];
        [blockSelf hideMenuAnimated:YES];
    }];
    
}



#pragma mark Recognizer

- (void)tapRecognized:(UIGestureRecognizer*)recoginzer
{
    if(!self.tapGestureEnable)
        return;
    if(![self isMenuVisible]){
        [self showMenuAnimated:YES];
    }else{
        [self hideMenuAnimated:YES];
    }
}

- (void)panRecognized:(UIPanGestureRecognizer*)recognizer
{
    if(!self.panGestureEnbale)
        return ;;
    CGPoint translation=[recognizer translationInView:recognizer.view];
    CGPoint velocity=[recognizer velocityInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self addMenuControllerView];
             [recognizer setTranslation:CGPointMake(recognizer.view.frame.origin.x, 0) inView:recognizer.view];
            break;
        case UIGestureRecognizerStateChanged: {
            [recognizer.view setTransform:CGAffineTransformMakeTranslation(MAX(0,translation.x), 0)];
            //[self statusBarView].transform = recognizer.view.transform;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (velocity.x > 5.0 || (velocity.x >= -1.0 && translation.x > CHSlderMinimumRelativePanDistanceToOpen*self.menuWidth)) {
                CGFloat transformedVelocity = velocity.x/ABS(self.menuWidth - translation.x);
                CGFloat duration = CHSliderMenuDefaultOpenAnimationTime * 0.66;
                [self showMenuAnimated:YES duration:duration initialVelocity:transformedVelocity];
            } else {
                [self hideMenuAnimated:YES];
            }
        }
            
        default:
            break;
    }
}






- (void)showMenuAnimated:(BOOL)animated
{
    [self showMenuAnimated:animated duration:CHSliderMenuDefaultOpenAnimationTime initialVelocity:1.0];
}

- (void)showMenuAnimated:(BOOL)animated duration:(CGFloat)duration initialVelocity:(CGFloat)velocity
{
    [self addMenuControllerView];
    __weak typeof(self) blockSelf=self;
    [UIView animateWithDuration:animated?duration:0.0 delay:0 usingSpringWithDamping:CHSliderDefaultDamping initialSpringVelocity:velocity options:UIViewAnimationOptionAllowUserInteraction animations:^{
        blockSelf.containerView.transform=CGAffineTransformMakeTranslation(self.menuWidth, 0);
    } completion:^(BOOL finished) {
        nil;
    }];
    
}

- (void)hideMenuAnimated:(BOOL)animated
{
    __weak typeof(self) blockSelf = self;
    [UIView animateWithDuration:CHSliderMenuDefaultCloseAnimationTime animations:^{
        blockSelf.containerView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [blockSelf.menuController.view removeFromSuperview];
    }];
}


-(BOOL)isMenuVisible
{
    return !CGAffineTransformEqualToTransform(self.containerView.transform, CGAffineTransformIdentity);
    return YES;
}



#pragma mark private method

- (void)addMenuControllerView
{
    if (self.menuController.view.superview == nil) {
        CGRect menuFrame, restFrame;
        CGRectDivide(self.view.bounds, &menuFrame, &restFrame, self.menuWidth, CGRectMinXEdge);
        self.menuController.view.frame = menuFrame;
        self.menuController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        self.view.backgroundColor = self.menuController.view.backgroundColor;
        if (self.backgroundView) [self.view insertSubview:self.menuController.view aboveSubview:self.backgroundView];
        else [self.view insertSubview:self.menuController.view atIndex:0];
    }
    
}





- (void)setBackgroundImage:(UIImage *)image
{
    if (!self.backgroundView && image) {
        self.backgroundView = [[UIImageView alloc] initWithImage:image];
        self.backgroundView.frame = self.view.bounds;
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:self.backgroundView atIndex:0];
    } else if (image == nil) {
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
    } else {
        self.backgroundView.image = image;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
