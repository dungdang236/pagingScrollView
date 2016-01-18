//
//  ViewController.m
//  pagingScrollView
//
//  Created by student on 18/01/2016.
//  Copyright © 2016 dungdang. All rights reserved.
//

#import "ViewController.h"
#define PHOTO_WIDTH 320
#define PHOTO_HEIGHT 480
#define NUM_PHOTO 6
@interface ViewController () <UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGSize size = self.view.bounds.size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((size.width - PHOTO_WIDTH)*0.5, 0, PHOTO_WIDTH, PHOTO_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(PHOTO_WIDTH*NUM_PHOTO, PHOTO_HEIGHT);
    self.scrollView.pagingEnabled= YES;
    
    for (int i=1; i<=NUM_PHOTO; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i];
        UIImage *image = [UIImage imageNamed:fileName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake((i-1)*PHOTO_WIDTH, 0, PHOTO_WIDTH, PHOTO_HEIGHT);
        [self.scrollView addSubview:imageView];
    
    }
    [self.view addSubview:self.scrollView];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, size.height- 64-40, size.width, 40)];
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = NUM_PHOTO;
    [self.pageControl addTarget:self
                         action:@selector(onPageChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}
- (void)viewDidAppear:(BOOL)animated {
    //self.scrollView.delegate= nil;
}
- (void)onPageChange: (id)sender {
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage*PHOTO_WIDTH, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x/ PHOTO_WIDTH;
}

@end
