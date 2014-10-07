//
//  UIViewController+CHSlider.m
//  300勇士盒
//
//  Created by ChenHao on 10/7/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import "UIViewController+CHSlider.h"

@implementation UIViewController (CHSlider)

- (CHSlider*)sideMenuController
{
    if ([self.parentViewController isKindOfClass:[CHSlider class]]) {
        return (CHSlider*)self.parentViewController;
    }
    return nil;
    
}
@end
