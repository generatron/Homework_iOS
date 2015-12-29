//
//  AssignmentTableViewCell.m
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AssignmentTableViewCell.h"

@implementation AssignmentTableViewCell

- (void)awakeFromNib {
    self.colorLabel.clipsToBounds = YES;
    self.colorLabel.layer.cornerRadius = self.colorLabel.frame.size.width/2.0;
    
    self.checkbox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(self.frame.size.width-40, 20, 20, 20)];
    self.checkbox.delegate = self;
    self.checkbox.boxType = BEMBoxTypeCircle;
    self.checkbox.tintColor = [UIColor clearColor];
    self.checkbox.onCheckColor = [UIColor whiteColor];
    self.checkbox.animationDuration = 0.25;
    self.checkbox.onAnimationType = BEMAnimationTypeFill;
    self.checkbox.offAnimationType = BEMAnimationTypeFill;
    self.checkbox.lineWidth = 3.5;
    [self addSubview:self.checkbox];
}

- (void)loadAssignment: (HWAssignment *) assignment {
    self.checkbox.frame = self.colorLabel.frame;
    self.checkbox.on = assignment.isCompleted.boolValue;
    //self.colorLabel.backgroundColor = ;
    self.checkbox.onFillColor = [UIColor HWMediumColor];
    self.checkbox.onTintColor = self.colorLabel.backgroundColor;
    self.assignment = assignment;
    self.colorLabel.text = [assignment.course.name substringToIndex:1];
    self.nameLabel.text = assignment.name;
    self.courseLabel.text = assignment.course.name;
    NSArray *types = @[@"Homework", @"Project", @"Other"];
    self.typeLabel.text = types[assignment.type.intValue];
    self.dateAssignedLabel.text = [self calculateTimeAgoWithDate:assignment.dateAssigned];
    self.dateAssignedLabel.text = [self calculateTimeAgoWithDate:assignment.dateDue];
}

- (NSString *)calculateTimeAgoWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    if ([date compare:[NSDate date]] == NSOrderedAscending)
        components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date toDate:[NSDate date] options:0];
    else components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[NSDate date] toDate:date options:0];
    NSString *time;
    if(components.month != 0) {
        if(components.month == 1) time = [NSString stringWithFormat:@"%ld month",(long)components.month];
        else time = [NSString stringWithFormat:@"%ld months",(long)components.month];
    }
    else if(components.day != 0) {
        if(components.day == 1) time = [NSString stringWithFormat:@"%ld day",(long)components.day];
        else time = [NSString stringWithFormat:@"%ld days",(long)components.day];
    }
    else if(components.hour != 0) {
        if(components.hour == 1) time = [NSString stringWithFormat:@"%ld hour",(long)components.hour];
        else time = [NSString stringWithFormat:@"%ld hours",(long)components.hour];
    }
    else if(components.minute != 0) {
        if(components.minute == 1) time = [NSString stringWithFormat:@"%ld min",(long)components.minute];
        else time = [NSString stringWithFormat:@"%ld mins",(long)components.minute];
    }
    if ([date compare:[NSDate date]] == NSOrderedAscending) return [NSString stringWithFormat:@"Assigned %@ ago",time];
    return [NSString stringWithFormat:@"Due in %@",time];
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
    [self.delegate assignmentTableViewCellCompletedValueToggledForAssignment:self.assignment];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

@end
