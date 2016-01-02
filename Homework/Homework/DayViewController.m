//
//  DayViewController.m
//  
//
//  Created by Chappy Asel on 12/24/15.
//
//

#import "DayViewController.h"
#import "AddDateViewController.h"

@interface DayViewController ()
@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@property NSDate *referenceDate;
@property DateTableViewCell *selectedCell;
@end

@implementation DayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int timeInterval = 60*60*24*((int)self.type-self.currentDayOfTheWeek+1); //"+1" gives user a day to finish date
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSCalendarUnit preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [calendar components:preservedComponents fromDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
    self.referenceDate = [calendar dateFromComponents:components];
    NSError *error;
    if (![[self assignmentFetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error Assign %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    if (![[self assessmentFetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error Assess %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSFetchedResultsController *)assignmentFetchedResultsController {
    if (_assignmentFetchedResultsController != nil) return _assignmentFetchedResultsController;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWAssignment" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    if (self.type == DayViewControllerTypeAll) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [NSDate dateWithTimeIntervalSince1970:0]];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [NSDate dateWithTimeIntervalSinceNow:60*60*24*365]];
        [predicates addObject:subPredTo];
        NSPredicate *subPred = [NSPredicate predicateWithFormat:@"isCompleted == NO"];
        [predicates addObject:subPred];
    }
    else if (self.type == DayViewControllerTypeMore) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [self.referenceDate dateByAddingTimeInterval:60*60*24]];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24*365]];
        [predicates addObject:subPredTo];
    }
    else  if (self.type == DayViewControllerTypeWeekend) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", self.referenceDate];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24*2]];
        [predicates addObject:subPredTo];
    }
    else {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", self.referenceDate];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24]];
        [predicates addObject:subPredTo];
    }
    [fetchRequest setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"course.period" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    //[fetchRequest setFetchBatchSize:20];
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc]
                                                               initWithFetchRequest:fetchRequest
                                                               managedObjectContext:self.context
                                                                 sectionNameKeyPath:nil
                                                                          cacheName:nil];
    self.assignmentFetchedResultsController = theFetchedResultsController;
    _assignmentFetchedResultsController.delegate = self;
    return _assignmentFetchedResultsController;
}

- (NSFetchedResultsController *)assessmentFetchedResultsController {
    if (_assessmentFetchedResultsController != nil) return _assessmentFetchedResultsController;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWAssessment" inManagedObjectContext:self.context];
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    [fetchRequest setEntity:entity];
    if (self.type == DayViewControllerTypeAll) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [NSDate dateWithTimeIntervalSince1970:0]];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [NSDate dateWithTimeIntervalSinceNow:60*60*24*365]];
        [predicates addObject:subPredTo];
    }
    else if (self.type == DayViewControllerTypeMore) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [self.referenceDate dateByAddingTimeInterval:60*60*24]];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24*365]];
        [predicates addObject:subPredTo];
    }
    else  if (self.type == DayViewControllerTypeWeekend) {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", self.referenceDate];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24*2]];
        [predicates addObject:subPredTo];
    }
    else {
        NSPredicate *subPredFrom = [NSPredicate predicateWithFormat:@"dateDue >= %@ ", self.referenceDate];
        [predicates addObject:subPredFrom];
        NSPredicate *subPredTo = [NSPredicate predicateWithFormat:@"dateDue < %@", [self.referenceDate dateByAddingTimeInterval:60*60*24]];
        [predicates addObject:subPredTo];
    }
    [fetchRequest setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"course.period" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    //[fetchRequest setFetchBatchSize:20];
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc]
                                                               initWithFetchRequest:fetchRequest
                                                               managedObjectContext:self.context
                                                               sectionNameKeyPath:nil
                                                               cacheName:nil];
    self.assessmentFetchedResultsController = theFetchedResultsController;
    _assessmentFetchedResultsController.delegate = self;
    return _assessmentFetchedResultsController;
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    long section1 = _assignmentFetchedResultsController.fetchedObjects.count;
    long section2 = _assessmentFetchedResultsController.fetchedObjects.count;
    long count = section1+section2;
    if (self.type == DayViewControllerTypeAll) return count+1;
    if (count == 0) {
        UILabel *overlayView = [[UILabel alloc] initWithFrame:self.tableView.frame];
        overlayView.backgroundColor = [UIColor whiteColor];
        overlayView.textAlignment = NSTextAlignmentCenter;
        overlayView.textColor = [UIColor lightGrayColor];
        overlayView.font = [UIFont systemFontOfSize:21 weight:UIFontWeightSemibold];
        overlayView.text = @"No Dates";
        [self.view addSubview:overlayView];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:@"DateTableViewCell" owner:self options:nil].firstObject;
    if (indexPath.row == _assignmentFetchedResultsController.fetchedObjects.count +
                         _assessmentFetchedResultsController.fetchedObjects.count  ) {
        UITableViewCell *altCell = [[UITableViewCell alloc] init];
        UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 15, 200, 50)];
        [more setTitle:@"Show Completed Dates" forState:UIControlStateNormal];
        [more setTitleColor:[UIColor HWDarkColor] forState:UIControlStateNormal];
        [more addTarget:self action:@selector(moreButtonToggle:) forControlEvents:UIControlEventTouchUpInside];
        [altCell addSubview:more];
        return altCell;
    }
    else {
        id date;
        long count = _assessmentFetchedResultsController.fetchedObjects.count;
        if (indexPath.row < _assessmentFetchedResultsController.fetchedObjects.count)
             date = self.assessmentFetchedResultsController.fetchedObjects[indexPath.row];
        else date = self.assignmentFetchedResultsController.fetchedObjects[indexPath.row-count];
        cell.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 80);
        cell.delegate = self;
        [cell loadDate:date];
    }
    return cell;
}

- (void)moreButtonToggle:(UIButton *)sender {
    /*
    if (true) {
        self.fetchedResultsController.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
            [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [NSDate dateWithTimeIntervalSince1970:0]],
            [NSPredicate predicateWithFormat:@"dateDue < %@", [NSDate dateWithTimeIntervalSinceNow:60*60*24*365]]]];
    }
    else {
        self.fetchedResultsController.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
            [NSPredicate predicateWithFormat:@"dateDue >= %@ ", [NSDate dateWithTimeIntervalSince1970:0]],
            [NSPredicate predicateWithFormat:@"dateDue < %@", [NSDate dateWithTimeIntervalSinceNow:60*60*24*365]],
            [NSPredicate predicateWithFormat:@"isCompleted == NO"]]];
    }
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    [self.tableView reloadData];
     */
}

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) NSLog(@"%@",error);
    [self.delegate tabUpdateRequestByDayViewController:self];
    //[self.tableView reloadData];
}

#pragma mark - fetchedResults delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self.tableView cellForRowAtIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - AssignmentTVCell delegate

- (void)dateTableViewCellCompletedValueToggledForAssignment:(HWAssignment *)assignment {
    assignment.isCompleted = [NSNumber numberWithBool:!assignment.isCompleted.boolValue];
    [self save];
}

- (void)dateTableViewCellNeedsMenuPopup:(DateTableViewCell *)cell atLocation:(CGPoint)location {
    self.selectedCell = cell;
    RNGridMenu *gridMenu;
    if (cell.assignment) gridMenu = [[RNGridMenu alloc] initWithTitles:@[@"Edit Assignment",@"Delete Assignment",@"Complete Assignment"]];
    else gridMenu = [[RNGridMenu alloc] initWithTitles:@[@"Edit Assessment",@"Delete Assessment"]];
    gridMenu.delegate = self;
    gridMenu.itemSize = CGSizeMake(210, 40);
    gridMenu.backgroundColor = [UIColor colorWithWhite:238.0/255.0 alpha:1];
    gridMenu.highlightColor = [UIColor colorWithWhite:220.0/255.0 alpha:1];
    gridMenu.itemTextColor = [UIColor blackColor];
    gridMenu.itemFont = [UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium];
    gridMenu.blurLevel = 0.15;
    [gridMenu showInViewController:self center:location];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    if (itemIndex == 0) { //edit
        AddDateViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ad"];
        rootVC.dateType = 2;
        if (self.selectedCell.assignment) {
            rootVC.assignment = self.selectedCell.assignment;
            rootVC.dateType = 1;
        }
        else rootVC.assessment = self.selectedCell.assessment;
        rootVC.courseList = [HWCourseList fetchCurrentCourseList];
        rootVC.context = self.context;
        rootVC.delegate = self;
        UINavigationController *modalVC = [[UINavigationController alloc] initWithRootViewController: rootVC];
        modalVC.navigationBar.barTintColor = [UIColor HWMediumColor];
        [modalVC.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
    if (itemIndex == 1) { //delete
        if (self.selectedCell.assignment) [self.context deleteObject:self.selectedCell.assignment];
        else [self.context deleteObject:self.selectedCell.assessment];
        [self save];
    }
    if (itemIndex == 2) { //complete
        self.selectedCell.assignment.isCompleted = [NSNumber numberWithBool:!self.selectedCell.assignment.isCompleted.boolValue];
        [self.selectedCell.checkbox setOn:self.selectedCell.assignment.isCompleted.boolValue animated:YES];
        [self save];
    }
}

#pragma mark - addDateVC delegate

- (void)addDateViewControllerWillDismissWithResultAssignment:(HWAssignment *)assignment {
    [self.context deleteObject:self.selectedCell.assignment]; //delete as it will be replaced
    [self save];
}

- (void)addDateViewControllerWillDismissWithResultAssessment:(HWAssessment *)assessment {
    [self.context deleteObject:self.selectedCell.assessment]; //delete as it will be replaced
    [self save];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
