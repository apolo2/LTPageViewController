//
//  HotMusicViewController.h
//  LTBlank
//
//  Created by Le Thang on 9/8/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSegmentedView.h"

@interface LTPageManagerViewController : UIViewController

@property (nonatomic) BOOL disibleSegmentView;

@property (strong, nonatomic) LTSegmentedView *segmentedView;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *viewControllers;

@property (strong, nonatomic) NSArray *segmentTitles;

//Note: number of viewController == number of title
- (id) initWithListViewController:(NSArray*)viewControllers
                     segmentTitle:(NSArray*)titles;

#pragma mark - Moving
- (void)moveToPageAtIndex:(NSInteger)index;

@end
