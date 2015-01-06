//
//  ViewController.h
//  Login
//
//  Created by Yeti on 13/11/14.
//  Copyright (c) 2014 Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "UConstants.h"
#import "MyPublic.h"
#import "PhotoStackViewController.h"

@protocol SighUpDelegate <NSObject>

- (void)signUpComplete;

@end

@interface SighUP : UIViewController <PhotoStackViewDelegate>

@property (weak, nonatomic) id<SighUpDelegate> delegate;


@end


