//
//  DayViewController.m
//  
//
//  Created by Chappy Asel on 12/24/15.
//
//

#import "DayViewController.h"

@interface DayViewController ()

@end

@implementation DayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *labelText = @[@"All Assignments & Assessments", @"Monday's Agenda", @"Tuesday's Agenda", @"Wednesday's Agenda", @"Thursday's Agenda", @"Friday's Agenda", @"This Weekend's Agenda", @"Later Assignments & Assessments"];
    int index = (int)self.tabIndex;
    self.weekdayLabel.text = labelText[index];
    self.view.backgroundColor = [UIColor HWMediumColor];
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
