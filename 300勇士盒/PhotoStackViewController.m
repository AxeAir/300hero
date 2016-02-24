//
//  PhotoStackViewController.m
//
//  Created by Tom Longo on 16/08/12.
//  - Twitter: @tomlongo
//  - GitHub:  github.com/tomlongo
//

#import "PhotoStackViewController.h"

@interface PhotoStackViewController ()

@property (nonatomic, strong) NSArray *photos;
-(void)setup;

@end

@implementation PhotoStackViewController

@synthesize photoStack = _photoStack,
            pageControl = _pageControl;



#pragma mark -
#pragma mark Getters

-(NSArray *)photos {
    if(!_photos) {

        _photos = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"a1.jpg"],
                   [UIImage imageNamed:@"a2.jpg"],
                   [UIImage imageNamed:@"a3.jpg"],
                   [UIImage imageNamed:@"a4.jpg"],
                   [UIImage imageNamed:@"a5.jpg"],
                   [UIImage imageNamed:@"a6.jpg"],
                   [UIImage imageNamed:@"a7.jpg"],
                   [UIImage imageNamed:@"a8.jpg"],
                   [UIImage imageNamed:@"a9.jpg"],
                   [UIImage imageNamed:@"a10.jpg"],
                   [UIImage imageNamed:@"a11.jpg"],
                   nil];
        
    }
    return _photos;
}

-(PhotoStackView *)photoStack {
    if(!_photoStack) {        
        _photoStack = [[PhotoStackView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _photoStack.center = CGPointMake(self.view.center.x, 170);
        _photoStack.dataSource = self;
        _photoStack.delegate = self;
    }
    
    return _photoStack;
}



#pragma mark -
#pragma mark Deck DataSource Protocol Methods

-(NSUInteger)numberOfPhotosInPhotoStackView:(PhotoStackView *)photoStack {
    return [self.photos count];
}

-(UIImage *)photoStackView:(PhotoStackView *)photoStack photoForIndex:(NSUInteger)PhotoIndex {
    return [self.photos objectAtIndex:PhotoIndex];
}



#pragma mark -
#pragma mark Deck Delegate Protocol Methods

-(void)photoStackView:(PhotoStackView *)photoStackView willStartMovingPhotoAtIndex:(NSUInteger)index {
    // User started moving a photo
}

-(void)photoStackView:(PhotoStackView *)photoStackView willFlickAwayPhotoAtIndex:(NSUInteger)index {
    // User flicked the photo away, revealing the next one in the stack
}

-(void)photoStackView:(PhotoStackView *)photoStackView didRevealPhotoAtIndex:(NSUInteger) PhotoIndex {
    self.pageControl.currentPage = PhotoIndex;
}

-(void)photoStackView:(PhotoStackView *)photoStackView didSelectPhotoAtIndex:(NSUInteger)PhotoIndex {
    if([self.delegate respondsToSelector:@selector(photoSelectedIndex:)]){
        [self.delegate photoSelectedIndex:PhotoIndex];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark -
#pragma mark Actions

- (IBAction)tappedInsertAnotherPhoto:(id)sender {
//    NSMutableArray *photosMutable = [self.photos mutableCopy];
//    [photosMutable addObject:[UIImage imageNamed:@"photo6.jpg"]];
//    self.photos = photosMutable;
//    [self.photoStack reloadData];
//    self.pageControl.numberOfPages = [self.photos count];
}



#pragma mark -
#pragma mark Setup

-(void)setup {
    [self.view addSubview:self.photoStack];
    self.pageControl.numberOfPages = [self.photos count];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidUnload {
    [self setPageControl:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
