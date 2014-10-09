//
//  CHSideMenu.h
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHSideMenu : UIViewController

@property (nonatomic, readonly) UIViewController *contentController;
@property (nonatomic, readonly) UIViewController *menuController;

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) BOOL tapGestureEnabled;
@property (nonatomic, assign) BOOL panGestureEnabled;

- (id)initWithContentController:(UIViewController*)contentController
                 menuController:(UIViewController*)menuController;

- (void)setContentController:(UIViewController*)contentController
                     animted:(BOOL)animated;

// show / hide manually
- (void)showMenuAnimated:(BOOL)animated;
- (void)hideMenuAnimated:(BOOL)animated;
- (BOOL)isMenuVisible;


- (void)toggleMenu:(BOOL)animated;

// background
- (void)setBackgroundImage:(UIImage*)image;

@end
