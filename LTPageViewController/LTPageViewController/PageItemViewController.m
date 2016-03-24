//
//  PageItemViewController.m
//  LTPageViewController
//
//  Created by Le Thang on 3/15/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "PageItemViewController.h"

@interface PageItemViewController ()
@property (strong, nonatomic) NSString *viewTitle;
@end

@implementation PageItemViewController

- (id) initWithTitle:(NSString*)title {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.viewTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblTitle.text = self.viewTitle;
    
    int random = arc4random() % 150 + 100;
    float colorValue = random / 255.0;
    [self.view setBackgroundColor:[UIColor colorWithRed:colorValue green:colorValue blue:colorValue alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
