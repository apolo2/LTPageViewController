//
//  LTSegmentedCollectionViewCell.h
//  LTBlank
//
//  Created by Le Thang on 9/8/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTSegmentedCollectionViewCell : UICollectionViewCell {
    __weak IBOutlet UILabel *lblTitle;
}

+ (UINib*) nib;
+ (NSString*) nibName;

- (void) configCellWithData:(id)data;

- (void) setCellSelected:(BOOL)selected;

@end
