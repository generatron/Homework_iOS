//
//  AddDateViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AddDateViewController.h"
#import "BasicDateFormCell.h"
#import "CourseSelectionViewController.h"
#import "CourseValueTransformer.h"

@interface AddDateViewController ()
@end

@implementation AddDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.assignment) self.title = @"Edit Assignment";
    else if (self.assessment) self.title = @"Edit Assessment";
    else if (self.dateType == 1) self.title = @"Add Assignment";
    else self.title = @"Add Assessment";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancelButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneButtonPressed:)];
    self.view.tintColor = [UIColor HWDarkColor];
    [self loadForm];
}

- (void)loadForm {
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    form = [XLFormDescriptor formDescriptor];
    //form.assignFirstResponderOnShow = YES;
    
    // First section (name, class, type)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Information"];
    [form addFormSection:section];
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText];
    row.title = @"Name";
    if (self.dateType == 1) [row.cellConfigAtConfigure setObject:@"Eg. Bookwork pg. 291" forKey:@"textField.placeholder"];
    else [row.cellConfigAtConfigure setObject:@"Eg. Chapter 3 test" forKey:@"textField.placeholder"];
    if (self.assignment) row.value = self.assignment.name;
    else if (self.assessment) row.value = self.assessment.name;
    [section addFormRow:row];
    // Class
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"course" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Course"];
    row.action.viewControllerStoryboardId = @"csvc";
    row.valueTransformer = [CourseValueTransformer class];
    row.value = nil;
    /*
    NSMutableArray *selectorOptions = [[NSMutableArray alloc] init];
    [selectorOptions addObject: [XLFormOptionsObject formOptionsObjectWithValue:nil displayText:@"None"]];
    for (HWCourse *course in self.courseList.courses)
        [selectorOptions addObject:[XLFormOptionsObject formOptionsObjectWithValue:course
                                                                       displayText:[NSString stringWithFormat:@"Period %@: %@",course.period,course.name]]];
    row.selectorOptions = selectorOptions;
     */
    if (self.assignment && self.assignment.course) row.value = self.assignment.course;
    if (self.assessment && self.assessment.course) row.value = self.assessment.course;
    [section addFormRow:row];
    // Type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"type" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Assignment Type"];
    if (self.dateType == 2) row.title = @"Assessment Type";
    if (self.dateType == 1) {
        row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeHomework]
                                                                                                displayText:@"Homework"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeProject]
                                                                                                displayText:@"Project"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeOther]
                                                                                                displayText:@"Other"]];
        row.value = [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeTest] displayText:@"Homework"];
        if (self.assignment) row.value = row.selectorOptions[self.assignment.type.intValue];
    }
    else {
        row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeTest]
                                                                                                displayText:@"Test"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeQuiz]
                                                                                                displayText:@"Quiz"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypePresentation]
                                                                                                displayText:@"Presentation"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeOther]
                                                                                                displayText:@"Other"]];
        row.value = [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeTest] displayText:@"Test"];
        if (self.assessment) row.value = row.selectorOptions[self.assessment.type.intValue];
    }
    [section addFormRow:row];
    
    // Second Section (begin date, due date)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dates"];
    [form addFormSection:section];
    // Today Bool
    XLFormRowDescriptor *todayRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"isAssignedToday" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Assigned Today"];
    todayRow.value = [NSNumber numberWithBool:YES];
    [section addFormRow:todayRow];
    // Begin Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dateAssigned" rowType:XLFormRowDescriptorTypeBasicDate title:@"Date Assigned"];
    row.hidden = [NSString stringWithFormat:@"$%@ == YES",todayRow];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*14] forKey:@"startDate"];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:60*60*24*314] forKey:@"endDate"];
    row.value = [self normalizedDateForDate:[NSDate date]];
    if (self.assignment) row.value = self.assignment.dateAssigned;
    if (self.assessment) row.value = self.assessment.dateAssigned;
    [section addFormRow:row];
    // Next Class Bool
    XLFormRowDescriptor *dueRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"isDueNextClass" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Due Next Class"];
    [section addFormRow:dueRow];
    // Due Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dateDue" rowType:XLFormRowDescriptorTypeBasicDate title:@"Due Date"];
    row.hidden = [NSString stringWithFormat:@"$%@ == YES",dueRow];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"startDate"];
    [row.cellConfigAtConfigure setObject:[NSDate dateWithTimeIntervalSinceNow:60*60*24*315] forKey:@"endDate"];
    row.value = [self normalizedDateForDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]];
    if (self.assignment) row.value = self.assignment.dateDue;
    if (self.assessment) row.value = self.assessment.dateDue;
    [section addFormRow:row];
    // Third Section (reminder)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Reminder"];
    if (self.dateType == 1) section.footerTitle = @"Get a push notification the evening before your assignment is due.";
    else section.footerTitle = @"Get a push notification the evening before your assessment.";
    [form addFormSection:section];
    // Reminder Bool
    XLFormRowDescriptor *reminderRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"shouldRemind" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Remind Me"];
    [section addFormRow:reminderRow];
    
    self.form = form;
}

- (void)doneButtonPressed:(id)sender {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (XLFormSectionDescriptor *section in self.form.formSections) {
        for (XLFormRowDescriptor * row in section.formRows) {
            if (row.tag && ![row.tag isEqualToString:@""])
                [result setObject:(row.value ?: [NSNull null]) forKey:row.tag];
        }
    }
    bool isAssignedToday = ![result[@"isAssignedToday"] isKindOfClass:[NSNull class]];
    bool isDueNextClass = ![result[@"isDueNextClass"] isKindOfClass:[NSNull class]];
    NSNumber *type;
    if ([result[@"type"] isKindOfClass:[NSNull class]]) {
        if (self.dateType == 1) type = @2;
        else type = @3;
    }
    else type = ((XLFormOptionsObject *)result[@"type"]).formValue;
    HWCourse *course;
    if ([result[@"course"] isKindOfClass:[NSNull class]]) course = nil;
    else course = result[@"course"];
    if (self.dateType == 1) {
        HWAssignment *assignment = [NSEntityDescription insertNewObjectForEntityForName:@"HWAssignment" inManagedObjectContext:self.context];
        if ([result[@"name"] isKindOfClass:[NSNull class]]) assignment.name = @"Untitled";
        else assignment.name = result[@"name"];
        assignment.course = course;
        assignment.type = type;
        assignment.dateAssigned = isAssignedToday ? [self normalizedDateForDate:[NSDate date]] : result[@"dateAssigned"];
        assignment.dateDue = isDueNextClass ? [self normalizedDateForDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]] : result[@"dateDue"];
        assignment.isCompleted = [NSNumber numberWithBool:NO];
        if (self.assignment) assignment.isCompleted = self.assignment.isCompleted;
        [self.delegate addDateViewControllerWillDismissWithResultAssignment:assignment];
    }
    else {
        HWAssessment *assessment = [NSEntityDescription insertNewObjectForEntityForName:@"HWAssessment" inManagedObjectContext:self.context];
        if ([result[@"name"] isKindOfClass:[NSNull class]]) assessment.name = @"Untitled";
        else assessment.name = result[@"name"];
        assessment.course = course;
        assessment.type = type;
        assessment.dateAssigned = isAssignedToday ? [self normalizedDateForDate:[NSDate date]] : result[@"dateAssigned"];
        assessment.dateDue = isDueNextClass ? [self normalizedDateForDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*2]] : result[@"dateDue"];
        [self.delegate addDateViewControllerWillDismissWithResultAssessment:assessment];
    }
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSDate *)normalizedDateForDate: (NSDate *)date {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSCalendarUnit preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [calendar components:preservedComponents fromDate:date];
    return [calendar dateFromComponents:components];
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
