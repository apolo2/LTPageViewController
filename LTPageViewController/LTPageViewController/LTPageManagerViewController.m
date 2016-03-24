//
//  HotMusicViewController.m
//  LTBlank
//
//  Created by Le Thang on 9/8/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import "LTPageManagerViewController.h"

@interface LTPageManagerViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, LTSegmentedViewDelegate>

@end

@implementation LTPageManagerViewController

//Note: number of viewController == number of title
- (id) initWithListViewController:(NSArray*)viewControllers
                     segmentTitle:(NSArray*)titles {
    self = [super init];
    if (self) {
        if (viewControllers.count > titles.count) {
            viewControllers = [viewControllers subarrayWithRange:NSMakeRange(0, titles.count)];
        } else if (viewControllers.count < titles.count) {
            titles = [titles subarrayWithRange:NSMakeRange(0, viewControllers.count)];
        }
        self.viewControllers = viewControllers;
        self.segmentTitles = titles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupSegmentedView];
    [self setupPageViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setupSegmentedView {
    if (!self.disibleSegmentView) {
        self.segmentedView = [LTSegmentedView viewWithListTitle:self.segmentTitles];
        self.segmentedView.delegate = self;
        self.segmentedView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.segmentedView.frame.size.height);
        [self.view addSubview:self.segmentedView];
    }
}

- (void) segmentedView:(LTSegmentedView *)segmentedView didSelectedIndex:(NSInteger)index {
    
    NSInteger currentIndex = [self.viewControllers indexOfObject:self.pageViewController.viewControllers[0]];
    
    if (index == currentIndex)
        return;
    
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionReverse;
    if (currentIndex < index)
        direction = UIPageViewControllerNavigationDirectionForward;
    
    [self.pageViewController setViewControllers:@[self.viewControllers[index]] direction:direction animated:NO completion:nil];
}

- (void) setupPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.pageViewController.view.frame = CGRectMake(0, [self.segmentedView endOfOriginY], self.view.frame.size.width, self.view.frame.size.height - [self.segmentedView endOfOriginY]);
    [self.pageViewController.view setBackgroundColor:[UIColor clearColor]];
    if (self.viewControllers.count)
        [self.pageViewController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.layer.zPosition = -1000.0f;
    [self.view addSubview:self.pageViewController.view];
    
    for (UIView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
}

#pragma mark - PageViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index > 0)
        return self.viewControllers[index - 1];
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index < self.viewControllers.count - 1)
        return self.viewControllers[index + 1];
    
    return nil;
}

- (void) pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
}

- (void) pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = pageViewController.viewControllers[0];
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    [self.segmentedView reloadWithSelectedIndex:index];
}

#pragma mark - ScrollView (in PageViewController) delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    float scrollingValue = (scrollView.contentOffset.x - scrollView.frame.size.width) / scrollView.frame.size.width;
    if (!isnan(scrollingValue) && scrollingValue != 0)
        [self.segmentedView scrollingFromRemoteWithValue:scrollingValue];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.segmentedView reloadSubViewFrameToCurrentPosition];
}

@end
