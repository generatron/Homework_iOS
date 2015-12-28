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
#import "AddDateViewController.h"
#import "AppDelegate.h"
#import "KxMenu.h"

@interface MainViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@property NSArray <UILabel *> *titleViews;
@property NSArray *titleArray;
@property int dayOfWeek;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Homework";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Courses"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(settingsButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addButtonPressed:)];
    self.courseList = [HWCourseList fetchCurrentCourseList];
    self.context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.dataSource = self;
    self.delegate = self;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-85, 27, 170, 30)];
    //titleView.backgroundColor = [UIColor redColor];
    titleView.clipsToBounds = YES;
    
    CAGradientLayer *l = [CAGradientLayer layer];
    l.frame = titleView.bounds;
    l.locations = @[@0.0, @0.08, @0.92, @1.0];
    l.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor whiteColor].CGColor,
                 (id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor];
    l.startPoint = CGPointMake(0.0, 0.5);
    l.endPoint = CGPointMake(1.0, 0.5);
    titleView.layer.mask = l;
    
    [self.navigationController.view addSubview:titleView];
    self.titleViews = @[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 30)],
                        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 30)],
                        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 170, 30)]];
    for (UILabel *l in self.titleViews) {
        l.textColor = [UIColor whiteColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
        [titleView addSubview:l];
    }
    
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
    modalVC.navigationBar.barTintColor = [UIColor HWMediumColor];
    [modalVC.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    modalVC.navigationBar.tintColor = [UIColor whiteColor];
    modalVC.navigationBar.translucent = NO;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = YES;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.0;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    [self.animator setContentScrollView:rootVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    CGRect frame = [self frameForBarButtonItem:sender];
    [KxMenu showMenuInView:self.navigationController.view
                  fromRect:frame
                 menuItems:@[[KxMenuItem menuItem:@"Add Assignment" image:nil target:self action:@selector(addAssignment:)],
                             [KxMenuItem menuItem:@"Add Assessment" image:nil target:self action:@selector(addAssesment:)]]];
}

- (void)addAssignment:(UIButton *)sender {
    AddDateViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ad"];
    rootVC.dateType = 1;
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    //rootVC.delegate = self;
    UINavigationController *modalVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
    modalVC.navigationBar.barTintColor = [UIColor HWMediumColor];
    [modalVC.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    modalVC.navigationBar.tintColor = [UIColor whiteColor];
    modalVC.navigationBar.translucent = NO;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = NO;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.0;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    //[self.animator setContentScrollView:rootVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (void)addAssesment:(UIButton *)sender {
    AddDateViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ad"];
    rootVC.dateType = 2;
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    //rootVC.delegate = self;
    UINavigationController *modalVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
    modalVC.navigationBar.barTintColor = [UIColor HWMediumColor];
    [modalVC.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    modalVC.navigationBar.tintColor = [UIColor whiteColor];
    modalVC.navigationBar.translucent = NO;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = NO;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.0;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    //[self.animator setContentScrollView:rootVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (CGRect)frameForBarButtonItem:(UIBarButtonItem *)buttonItem {
    UIView *view = [buttonItem valueForKey:@"view"];
    return  view ? view.frame : CGRectZero;
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
    NSArray *labelText = @[@"All Dates", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"This Weekend", @"Next Week"];
    if (index == 0) self.titleArray = @[@"", labelText[index], labelText[index+1]];
    else if (index == 7) self.titleArray = @[labelText[index-1], labelText[index], @""];
    else self.titleArray = @[labelText[index-1],labelText[index],labelText[index+1]];
}

- (void)viewPager:(ViewPagerController *)viewPager willScrollToXPos: (float)currPos {
    float width = self.view.frame.size.width;
    float titleViewCenter = 170/2;
    float dist = currPos/width;
    for (int i = 0; i < self.titleViews.count; i++) {
        UILabel *label = self.titleViews[i];
        label.text = self.titleArray[i];
        if (i == 0) {
            if (currPos <= width) label.alpha = 1-dist;
            label.frame = CGRectMake(-titleViewCenter+titleViewCenter*(1-dist), 0, 170, 30);
        }
        if (i == 1) {
            if (dist <=1) {
                label.alpha = dist;
                label.frame = CGRectMake(titleViewCenter*(1-dist), 0, 170, 30);
            }
            else {
                label.alpha = 2-dist;
                label.frame = CGRectMake(-titleViewCenter*(dist-1), 0, 170, 30);
            }
        }
        if (i == 2) {
            if (currPos >= width) label.alpha = dist-1;
            label.frame = CGRectMake(titleViewCenter-titleViewCenter*(dist-1), 0, 170, 30);
        }
    }
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
    if (component == ViewPagerIndicator) return [UIColor HWMediumColor];
    else return color;
}

@end
