//
//  CHSlider.h
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHSlider : UIViewController

@property (nonatomic,readonly) UIViewController *contentController;
@property (nonatomic,readonly) UIViewController *menuController;

@property (nonatomic,assign) CGFloat menuWidth;
@property (nonatomic,assign) BOOL tapGestureEnable;
@property (nonatomic,assign) BOOL panGestureEnbale;

- (id)initWithContentController:(UIViewController*)contentController
                menuController:(UIViewController*)menuController;


- (void)setContentController:(UIViewController *)contentController
                    animted:(BOOL)animated;

- (void)showMenuAnimated:(BOOL)animated;
- (void)hideMenuAnimated:(BOOL)animated;
- (BOOL)isMenuVisible;

- (void)setBackgroundImage:(UIImage*)image;

@end
