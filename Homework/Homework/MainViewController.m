//
//  MainViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "MainViewController.h"
#import "HWCourseList.h"
#import "CourseListViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@property int dayOfWeek;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Homework";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(settingsButtonPressed:)];
    self.courseList = [HWCourseList fetchCurrentCourseList];
    self.context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.dataSource = self;
    self.delegate = self;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    self.dayOfWeek = ((int)[comps weekday])-1;
    if (self.dayOfWeek == 0) self.dayOfWeek = 7;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.dayOfWeek > 5) [self selectTabAtIndex:6]; //weekend
    else [self selectTabAtIndex:self.dayOfWeek+1];
}

- (IBAction)settingsButtonPressed:(id)sender {
    CourseListViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cl"];
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    //rootVC.delegate = self;
    UINavigationController *modalVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
    modalVC.navigationBar.barTintColor = [UIColor colorWithRed:70/255.0 green:235/255.0 blue:120/255.0 alpha:1];
    [modalVC.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    modalVC.navigationBar.tintColor = [UIColor whiteColor];
    modalVC.navigationBar.translucent = NO;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = YES;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.6;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    [self.animator setContentScrollView:rootVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 8;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 55)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 120, 20)];
    NSArray *labelText = @[@"All", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Weekend", @"More"];
    label.text = labelText[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    if (index > 0 && index < 6) {
        int localDayOfWeek = (int)index-1;
        if (localDayOfWeek <= self.dayOfWeek) label.textColor = [UIColor lightGrayColor];
    }
    [view addSubview:label];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 120, 15)];
    detailLabel.text = [NSString stringWithFormat:@"%d/%d completed",0,0];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:detailLabel];
    return view;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    DayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"dvc"];
    vc.tabIndex = index;
    return vc;
}

#pragma mark - ViewPagerDelegate
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {

}

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionTabHeight: return 55.0;
        case ViewPagerOptionTabWidth: return 138.0;
        case ViewPagerOptionTabLocation: return 0.0;
        case ViewPagerOptionCenterCurrentTab: return 1.0;
        default: return value;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    if (component == ViewPagerIndicator) return [UIColor colorWithRed:70/255.0 green:235/255.0 blue:120/255.0 alpha:1];
    else return color;
}

@end
