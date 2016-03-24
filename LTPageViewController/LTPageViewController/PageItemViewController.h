//
//  PageItemViewController.h
//  LTPageViewController
//
//  Created by Le Thang on 3/15/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

- (id) initWithTitle:(NSString*)title;

@end
