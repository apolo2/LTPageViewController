//
//  ExamplePageViewController.m
//  LTPageViewController
//
//  Created by Le Thang on 3/15/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "ExamplePageViewController.h"
#import "PageItemViewController.h"

@interface ExamplePageViewController ()

@end

@implementation ExamplePageViewController

- (id) initExampleViewController {
    
    //Create list viewcontrollers
    PageItemViewController *viewController1 = [[PageItemViewController alloc] initWithTitle:@"ViewController 1"];
    PageItemViewController *viewController2 = [[PageItemViewController alloc] initWithTitle:@"ViewController 2"];
    PageItemViewController *viewController3 = [[PageItemViewController alloc] initWithTitle:@"ViewController 3"];
    PageItemViewController *viewController4 = [[PageItemViewController alloc] initWithTitle:@"ViewController 4"];
    PageItemViewController *viewController5 = [[PageItemViewController alloc] initWithTitle:@"ViewController 5"];
    PageItemViewController *viewController6 = [[PageItemViewController alloc] initWithTitle:@"ViewController 6"];
    PageItemViewController *viewController7 = [[PageItemViewController alloc] initWithTitle:@"ViewController 7"];
    
    NSArray *viewControllers = @[viewController1, viewController2, viewController3, viewController4, viewController5, viewController6, viewController7];
    
    //Segment titles
    NSArray *segmentTitles = @[@"Segment 1", @"Segment 2", @"Segment 3", @"Segment 4", @"Segment 5", @"Segment 6", @"Segment 7"];
    
    //Init
    self = [super initWithListViewController:viewControllers segmentTitle:segmentTitles];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Home";
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupNavigationBar {
    if (self.navigationController) {
        UINavigationBar *navBar = [self.navigationController navigationBar];
        [navBar setBarTintColor:[UIColor darkGrayColor]];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    }
}

@end
