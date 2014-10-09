//
//  UIViewController+CHSideMenu.m
//  300勇士盒
//
//  Created by ChenHao on 10/4/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "UIViewController+CHSideMenu.h"

@implementation UIViewController (CHSideMenu)

- (CHSideMenu*)sideMenuController;
{
    if ([self.parentViewController isKindOfClass:[CHSideMenu class]]) {
        return (CHSideMenu*)self.parentViewController;
    }
    
    return nil;
}

@end
