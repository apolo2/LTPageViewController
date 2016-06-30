//
//  HotMusicSegmentView.m
//  LTBlank
//
//  Created by Le Thang on 9/8/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import "LTSegmentedView.h"
#import "LTSegmentedCollectionViewCell.h"
#import "LTSegmentedCollectionViewLayout.h"

@interface LTSegmentedView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic) float lastScrollingValue;
@property (nonatomic) BOOL isScrollingRemote;
@property (nonatomic) BOOL isLastCollectionScroll;
@property (nonatomic) ScrollingItemType currentScrollingType;
@end

@implementation LTSegmentedView

+ (NSString*) nibName {
    NSString *name = NSStringFromClass([self class]);
    return name;
}

+ (id) initViewUsingNib {
    UIViewController *tmpVC = [[UIViewController alloc] initWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
    return tmpVC.view;
}

- (CGFloat) endOfOriginY {
    return self.frame.origin.y + self.frame.size.height;
}

+ (LTSegmentedView*) viewWithListTitle:(NSArray*)listTitle {
    LTSegmentedView *view = [LTSegmentedView initViewUsingNib];
    view.titles = listTitle;
    [view setupViews];
    return view;
}

- (void) setupViews {
    self.lastScrollingValue = 0;
    
    self.selectedIndex = 0;
    
    self.currentScrollingType = ScrollingItemTypeNone;
    
    [self setupCollectionView];
    [self setupTabImageView];
}

- (float) itemWidth {
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float itemWidth = screenWidth / 3;
    if (self.titles.count < 3)
        itemWidth = screenWidth / self.titles.count;
    
    return itemWidth;
}

- (void) setupTabImageView {
    CGRect frame = self.imgSelectedTab.frame;
    frame.size.width = [self itemWidth];
    self.imgSelectedTab.frame = frame;
}

- (void) setupCollectionView {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[LTSegmentedCollectionViewCell nib] forCellWithReuseIdentifier:[LTSegmentedCollectionViewCell nibName]];
    
    self.collectionView.collectionViewLayout = [[LTSegmentedCollectionViewLayout alloc] init];
    float itemWidth = [self itemWidth];
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(itemWidth, self.collectionView.frame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView reloadData];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LTSegmentedCollectionViewCell *cell = (LTSegmentedCollectionViewCell*)[collectionView_ dequeueReusableCellWithReuseIdentifier:[LTSegmentedCollectionViewCell nibName] forIndexPath:indexPath];
    NSString *title = self.titles[indexPath.row];
    [cell configCellWithData:title];
    [cell setCellSelected:indexPath.row == self.selectedIndex];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [cell convertRect:cell.bounds toView:self];
    self.imgSelectedTab.frame = frame;
    
    [self reloadWithSelectedIndex:indexPath.row];
    
    if (self.selectedIndex > 0 && self.selectedIndex < self.titles.count - 1) {
        self.isScrollingRemote = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.imgSelectedTab.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        } completion:^(BOOL finished) {
            self.isScrollingRemote = NO;
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedView:didSelectedIndex:)]) {
        [self.delegate segmentedView:self didSelectedIndex:indexPath.row];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isScrollingRemote)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [cell convertRect:cell.bounds toView:self];
    self.imgSelectedTab.frame = frame;
    
    self.isLastCollectionScroll = YES;
}

- (void) reloadWithSelectedIndex:(NSInteger)itemIndex {
    self.selectedIndex = itemIndex;
    [self.collectionView reloadData];
    self.lastScrollingValue = 0;
    self.isScrollingRemote = NO;
}

- (CGRect) getInViewFrameOfCellAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UICollectionViewLayoutAttributes *pose = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frame = pose.frame;
    frame = [self.collectionView convertRect:frame toView:self];
    return frame;
}

- (void) reloadSubViewFrameToCurrentPosition {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.imgSelectedTab.frame = [self getInViewFrameOfCellAtIndex:self.selectedIndex];
    
    self.isLastCollectionScroll = NO;
    self.currentScrollingType = ScrollingItemTypeNone;
}

- (void) scrollingFromRemoteWithValue:(float)scrollingValue {
    if (self.isLastCollectionScroll) {
        [self reloadSubViewFrameToCurrentPosition];
    }
    
    self.isScrollingRemote = YES;
    
    //Get scroll type
    if (self.currentScrollingType == ScrollingItemTypeNone) {
        self.currentScrollingType = ScrollingItemTypeCollectionView;
        
        if (scrollingValue > 0) {
            if (self.selectedIndex == 0 || self.selectedIndex == self.titles.count - 2)
                self.currentScrollingType = ScrollingItemTypeBackgroundView;
        } else {
            if (self.selectedIndex == self.titles.count - 1 ||
                self.selectedIndex == 1) {
                self.currentScrollingType = ScrollingItemTypeBackgroundView;
            }
        }
    }
    
    //Scrolling
    if (self.currentScrollingType == ScrollingItemTypeBackgroundView) {
        CGRect frame = self.imgSelectedTab.frame;
        frame.origin.x += (scrollingValue - self.lastScrollingValue)*[self itemWidth];
        if (frame.origin.x >= 0 && frame.origin.x < self.frame.size.width - frame.size.width) {
            self.imgSelectedTab.frame = frame;
        }
    } else {
        float xOffset = self.collectionView.contentOffset.x + (scrollingValue - self.lastScrollingValue)*[self itemWidth];
        if (xOffset >= 0 && xOffset <= self.collectionView.contentSize.width - self.frame.size.width) {
            [self.collectionView setContentOffset:CGPointMake(xOffset, self.collectionView.contentOffset.y)];
        }
    }
    
    //Reset value
    self.lastScrollingValue = scrollingValue;
    self.isScrollingRemote = NO;
}

@end
