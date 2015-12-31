//
//  AssignmentTableViewCell.m
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AssignmentTableViewCell.h"

@implementation AssignmentTableViewCell {
    bool longPressIsValid;
}

- (void)awakeFromNib {
    self.colorLabel.clipsToBounds = YES;
    self.colorLabel.layer.cornerRadius = self.colorLabel.frame.size.width/2.0;
    
    self.checkbox = [[BEMCheckBox alloc] init];
    self.checkbox.delegate = self;
    self.checkbox.boxType = BEMBoxTypeCircle;
    self.checkbox.tintColor = [UIColor clearColor];
    self.checkbox.onCheckColor = [UIColor whiteColor];
    self.checkbox.animationDuration = 0.25;
    self.checkbox.onAnimationType = BEMAnimationTypeFill;
    self.checkbox.offAnimationType = BEMAnimationTypeFill;
    self.checkbox.lineWidth = 4.0;
    [self addSubview:self.checkbox];
}

- (void)loadAssignment: (HWAssignment *) assignment {
    self.checkbox.frame = self.colorLabel.frame;
    self.checkbox.on = assignment.isCompleted.boolValue;
    //self.colorLabel.backgroundColor = ;
    self.checkbox.onFillColor = [UIColor HWMediumColor];
    self.checkbox.onTintColor = [UIColor clearColor];
    self.assignment = assignment;
    self.colorLabel.text = [assignment.course.name substringToIndex:1];
    self.nameLabel.text = assignment.name;
    self.courseLabel.text = assignment.course.name;
    NSArray *types = @[@"Homework", @"Project", @"Other"];
    self.typeLabel.text = types[assignment.type.intValue];
    self.dateAssignedLabel.text = [self calculateTimeAgoWithDate:assignment.dateAssigned type:@"assigned"];
    self.dateAssignedLabel.text = [self calculateTimeAgoWithDate:assignment.dateDue type:@"due"];
}

- (NSString *)calculateTimeAgoWithDate:(NSDate *)date type:(NSString *)type {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    NSDate *normalDate = [self normalizedDateForDate:[NSDate date]];
    if ([date compare:normalDate] == NSOrderedAscending)
        components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date toDate:[NSDate date] options:0];
    else components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:normalDate toDate:date options:0];
    NSString *time;
    if(components.year != 0) {
        if(components.year == 1) time = [NSString stringWithFormat:@"%ld year",(long)components.year];
        else time = [NSString stringWithFormat:@"%ld years",(long)components.year];
    }
    if(components.month != 0) {
        if(components.month == 1) time = [NSString stringWithFormat:@"%ld month",(long)components.month];
        else time = [NSString stringWithFormat:@"%ld months",(long)components.month];
    }
    else if(components.day != 0) {
        if(components.day == 1) time = [NSString stringWithFormat:@"%ld day",(long)components.day];
        else time = [NSString stringWithFormat:@"%ld days",(long)components.day];
    }
    
    if ([type isEqualToString:@"due"]) {
        if (components.day == 0) return @"Due today";
        if ([date compare:normalDate] == NSOrderedAscending) return [NSString stringWithFormat:@"Due %@ ago",time];
        return [NSString stringWithFormat:@"Due in %@",time];
    }
    if (components.day == 0) return @"Assigned today";
    if ([date compare:normalDate] == NSOrderedAscending) return [NSString stringWithFormat:@"Assigned %@ ago",time];
    return [NSString stringWithFormat:@"Assigned in %@",time];
}

- (NSDate *)normalizedDateForDate: (NSDate *)date {
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSCalendarUnit preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [calendar components:preservedComponents fromDate:date];
    return [calendar dateFromComponents:components];
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
    [self.delegate assignmentTableViewCellCompletedValueToggledForAssignment:self.assignment];
}

- (IBAction)longPressedCell:(UILongPressGestureRecognizer *)sender {
    if (longPressIsValid) {
        CGPoint location = [sender locationInView:self.superview];
        [self.delegate assignmentTableViewCellNeedsMenuPopup:self atLocation:location];
        longPressIsValid = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    longPressIsValid = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

@end
