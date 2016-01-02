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
#import "KxMenu.h"

@interface MainViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@property NSMutableArray <UILabel *> *tabSublabels;
@property NSArray <UILabel *> *titleViews;
@property NSArray *titleArray;
@property int dayOfWeek;

@property NSUInteger currentTabIndex;

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
    self.tabSublabels = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 120, 15)];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.font = [UIFont systemFontOfSize:13];
        [self.tabSublabels addObject:detailLabel];
    }
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

- (void)viewDidLayoutSubviews {
    if (self.dayOfWeek > 5) {
        [self selectTabAtIndex:6]; //weekend
        self.currentTabIndex = 6;
    }
    else {
        [self selectTabAtIndex:self.dayOfWeek];
        self.currentTabIndex = self.dayOfWeek;
    }
}
 
- (IBAction)settingsButtonPressed:(id)sender {
    CourseListViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cl"];
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    //rootVC.delegate = self;
    UINavigationController *modalVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
    modalVC.navigationBar.barTintColor = [UIColor HWMediumColor];
    [modalVC.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
                             [KxMenuItem menuItem:@"Add Assessment" image:nil target:self action:@selector(addAssessment:)]]];
}

- (void)addAssignment:(UIButton *)sender {
    AddDateViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ad"];
    rootVC.dateType = 1;
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    rootVC.delegate = self;
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

- (void)addAssessment:(UIButton *)sender {
    AddDateViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ad"];
    rootVC.dateType = 2;
    rootVC.courseList = self.courseList;
    rootVC.context = self.context;
    rootVC.delegate = self;
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
        int localDayOfWeek = (int)index;
        if (localDayOfWeek < self.dayOfWeek) label.textColor = [UIColor lightGrayColor];
    }
    [view addSubview:label];
    [self updateSublabelAtIndex:index];
    [view addSubview:self.tabSublabels[index]];
    return view;
}

- (void)updateSublabels {
    for (int i = 0; i < 8; i++) [self updateSublabelAtIndex:i];
}

- (void)updateSublabelAtIndex:(NSUInteger)index{
    self.tabSublabels[index] = [self labelForTabAtIndex:index];
}

- (UILabel *)labelForTabAtIndex:(NSUInteger)index{
    UILabel *label = self.tabSublabels[index];
    if (index == 0) //all
        label.text = [NSString stringWithFormat:@"%d Incomplete",(int)[self arrayOfAssignmentsBetweenBeginDate:[NSDate dateWithTimeIntervalSince1970:0]
                                                                                                    andEndDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*365]
                                                                                               predicateString:@"isCompleted == NO"].count];
    else {
        int timeInterval = 60*60*24*((int)index-self.dayOfWeek+1); //need to adjust this, too
        if (index == DayViewControllerTypeMore) timeInterval += 60*60*24;
        NSCalendar *calendar = NSCalendar.currentCalendar;
        NSCalendarUnit preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
        NSDateComponents *components = [calendar components:preservedComponents fromDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
        NSDate *normalizedDate = [calendar dateFromComponents:components];
        int interval = 60*60*24;
        if (index == DayViewControllerTypeMore) interval = 60*60*24*365;
        else if (index == DayViewControllerTypeWeekend) interval = 60*60*24*2;
        int total = (int)[self arrayOfAssignmentsBetweenBeginDate:normalizedDate andEndDate:[normalizedDate dateByAddingTimeInterval:60*60*24] predicateString:nil].count;
        int complete = (int)[self arrayOfAssignmentsBetweenBeginDate:normalizedDate andEndDate:[normalizedDate dateByAddingTimeInterval:60*60*24] predicateString:@"isCompleted == YES"].count;
        if (index<self.dayOfWeek) {
            label.text  = [NSString stringWithFormat:@"%d Late",total-complete];
            if (total-complete != 0) label.textColor = [UIColor redColor];
            else label.textColor = [UIColor lightGrayColor];
        }
        else label.text = [NSString stringWithFormat:@"%d/%d Complete",complete,total];
    }
    return label;
}

- (NSArray *)arrayOfAssignmentsBetweenBeginDate:(NSDate *)d1 andEndDate:(NSDate *)d2 predicateString:(NSString *)predicateString {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWAssignment" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", d1];
    [predicates addObject:subPredFrom];
    NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", d2];
    [predicates addObject:subPredTo];
    if (predicateString != nil) [predicates addObject:[NSPredicate predicateWithFormat:predicateString]];
    [fetchRequest setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSError *error;
    return [self.context executeFetchRequest:fetchRequest error:&error];
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    DayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"dvc"];
    vc.delegate = self;
    vc.type = index;
    vc.currentDayOfTheWeek = self.dayOfWeek;
    vc.context = self.context;
    return vc;
}

#pragma mark - ViewPagerDelegate
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    self.currentTabIndex = index;
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

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) NSLog(@"%@",error);
    [self reloadData];
}

#pragma mark - addDateVC delegate

- (void)addDateViewControllerWillDismissWithResultAssignment:(HWAssignment *)assignment {
    [self save];
}

- (void)addDateViewControllerWillDismissWithResultAssessment:(HWAssessment *)assessment {
    [self save];
}

#pragma mark - dayVC delegate

- (void)tabUpdateRequestByDayViewController:(DayViewController *)dayVC {
    [self updateSublabels];
}

@end
