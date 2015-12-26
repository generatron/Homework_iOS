//
//  AddCourseViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AddCourseViewController.h"

@interface AddCourseViewController ()

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)courseNameEditingEnded:(UITextField *)sender {
    
}

- (IBAction)periodSliderValueChanged:(UISlider *)sender {
    self.periodLabel.text = [NSString stringWithFormat:@"Period (%d)",(int)sender.value];
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    HWCourse *resultCourse = [NSEntityDescription insertNewObjectForEntityForName:@"HWCourse" inManagedObjectContext:self.context];
    if (self.courseNameInput.text.length > 0) resultCourse.name = self.courseNameInput.text;
    else resultCourse.name = @"Untitled Course";
    resultCourse.period = [NSNumber numberWithInt:(int)self.periodSlider.value];
    [self.delegate addCourseViewControllerWillDismissWithResultCourse:resultCourse];
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
