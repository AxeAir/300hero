//
//  PhotoStackViewController.h
//
//  Created by Tom Longo on 16/08/12.
//  - Twitter: @tomlongo
//  - GitHub:  github.com/tomlongo
//

#import <UIKit/UIKit.h>
#import "PhotoStackView.h"

@protocol PhotoStackViewControllerDelegate <NSObject>

-(NSUInteger) photoSelectedIndex:(NSUInteger)index;

@end

@interface PhotoStackViewController : UIViewController <PhotoStackViewDataSource, PhotoStackViewDelegate>{
    NSString *index;
}

@property (nonatomic, strong) PhotoStackView *photoStack;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) id<PhotoStackViewControllerDelegate> delegate;


@end


