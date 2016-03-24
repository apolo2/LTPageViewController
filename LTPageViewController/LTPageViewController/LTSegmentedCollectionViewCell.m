//
//  LTSegmentedCollectionViewCell.m
//  LTBlank
//
//  Created by Le Thang on 9/8/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import "LTSegmentedCollectionViewCell.h"

@interface LTSegmentedCollectionViewCell ()

@end

@implementation LTSegmentedCollectionViewCell

+ (UINib*) nib {
    return [UINib nibWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
}

+ (NSString*) nibName {
    return NSStringFromClass([self class]);
}

- (void) configCellWithData:(id)data {
    lblTitle.text = data;
}

- (UIFont*) selectedFont {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
}

- (UIFont*) normalFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:12.0];
}

- (void) setCellSelected:(BOOL)selected {
    if (selected) {
        [lblTitle setTextColor:[UIColor whiteColor]];
        [lblTitle setFont:[self selectedFont]];
    }
    else {
        [lblTitle setTextColor:[UIColor darkGrayColor]];
        [lblTitle setFont:[self normalFont]];
    }
}

@end
