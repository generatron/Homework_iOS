//
//  AddCourseViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AddCourseViewController.h"

@interface AddCourseViewController ()

@property UIColor *selectedColor;
@property UIButton *selectedButton;

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView.layer.cornerRadius = 8;
    self.view.tintColor = [UIColor HWDarkColor];
    self.courseNameInput.delegate = self;
    
    for (UIView *view in [self.colorContainerView subviews]) {
        view.layer.cornerRadius = 20.0f;
        view.layer.borderWidth = 5.0f;
        view.layer.borderColor = [[UIColor clearColor] CGColor];
        view.clipsToBounds = YES;
        view.layer.masksToBounds = NO;
    }
    self.selectedButton = [self.colorContainerView subviews][4];
    self.selectedColor = [self.colorContainerView subviews][4].backgroundColor;
    [self.colorContainerView subviews][4].layer.borderColor = [[self lighterColorForColor:self.selectedColor] CGColor];
}

- (IBAction)courseNameEditingEnded:(UITextField *)sender {
    
}

- (IBAction)periodSliderValueChanged:(UISlider *)sender {
    self.periodLabel.text = [NSString stringWithFormat:@"Period (%d)",(int)sender.value];
}

- (IBAction)colorButtonPressed:(UIButton *)sender {
    self.selectedColor = sender.backgroundColor;
    self.selectedButton.layer.borderColor = [[UIColor clearColor] CGColor];
    self.selectedButton = sender;
    self.selectedButton.layer.borderColor = [[self lighterColorForColor:self.selectedColor] CGColor];
}

- (UIColor *)lighterColorForColor:(UIColor *)c {
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.3, 1.0)
                               green:MIN(g + 0.3, 1.0)
                                blue:MIN(b + 0.3, 1.0)
                               alpha:a];
    return nil;
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    HWCourse *resultCourse = [NSEntityDescription insertNewObjectForEntityForName:@"HWCourse" inManagedObjectContext:self.context];
    if (self.courseNameInput.text.length > 0) resultCourse.name = self.courseNameInput.text;
    else resultCourse.name = @"Untitled Course";
    resultCourse.period = [NSNumber numberWithInt:(int)self.periodSlider.value];
    resultCourse.color = self.selectedColor;
    [self.delegate addCourseViewControllerWillDismissWithResultCourse:resultCourse];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
