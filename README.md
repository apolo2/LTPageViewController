# LTPageViewController

![](https://github.com/apolo2/LTPageViewController/blob/master/ltpagevcl.gif)

## Requirements
iOS 6.0

## Installation

####[CocoaPods](http://cocoapods.org)
Coming soon.

####Manual Installation

Unzip example project and add files in LibClass forder to your project

## Usage

Create your ViewController is subclass of LTPageManagerViewController

* Header file
```
#import "LTPageManagerViewController.h"

@interface ExamplePageViewController : LTPageManagerViewController

- (id) initExampleViewController;

@end
```

* Implement init function with example:
```
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
```

### Author

ThangLN, lethang255@gmail.com

Feel free to copy and modify this source code. Please let me know if you have any question!