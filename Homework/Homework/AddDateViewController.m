//
//  AddDateViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AddDateViewController.h"

@interface AddDateViewController ()

@end

@implementation AddDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dateType == 1) self.title = @"Add Assignment";
    else self.title = @"Add Assessment";
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
    
    // First section (name, class, type)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Information"];
    [form addFormSection:section];
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Assignment Name" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    // Class
    NSMutableArray *selectorOptions = [[NSMutableArray alloc] init];
    [selectorOptions addObject: [XLFormOptionsObject formOptionsObjectWithValue:nil displayText:@"None"]];
    for (HWCourse *course in self.courseList.courses)
        [selectorOptions addObject:[XLFormOptionsObject formOptionsObjectWithValue:course
                                                                       displayText:[NSString stringWithFormat:@"Period %@: %@",course.period,course.name]]];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"course" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Course"];
    row.selectorOptions = selectorOptions;
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:nil displayText:@"None"];
    [section addFormRow:row];
    // Type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"type" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Type"];
    if (self.dateType == 1) {
        row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeHomework]
                                                                                                displayText:@"Homework"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeProject]
                                                                                                displayText:@"Project"],
                                [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssignmentTypeOther]
                                                                                                displayText:@"Other"]];
        row.value = [XLFormOptionsObject formOptionsObjectWithValue:[NSNumber numberWithInteger:HWAssessmentTypeTest] displayText:@"Homework"];
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
    }
    [section addFormRow:row];
    
    // Second Section (begin date, due date)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Dates"];
    [form addFormSection:section];
    // Today Bool
    XLFormRowDescriptor *todayRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"isAssignedToday" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Assigned Today"];
    [section addFormRow:todayRow];
    // Begin Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dateAssigned" rowType:XLFormRowDescriptorTypeDateInline title:@"Date Assigned"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:0];
    row.hidden = [NSString stringWithFormat:@"$%@ == YES",todayRow];
    [section addFormRow:row];
    // Next Class Bool
    XLFormRowDescriptor *dueRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"isDueNextClass" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Due Next Class"];
    [section addFormRow:dueRow];
    // Due Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dueDate" rowType:XLFormRowDescriptorTypeDateInline title:@"Due Date"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24*2];
    row.hidden = [NSString stringWithFormat:@"$%@ == YES",dueRow];
    [section addFormRow:row];
    
    // Third Section (reminder)
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Reminder"];
    [form addFormSection:section];
    // Reminder Bool
    XLFormRowDescriptor *reminderRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"shouldRemind" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Remind Me"];
    [section addFormRow:reminderRow];
    
    self.form = form;
}

- (void)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
