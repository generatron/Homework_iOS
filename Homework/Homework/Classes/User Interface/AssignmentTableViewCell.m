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
    
    self.checkbox = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(self.frame.size.width-37.5, 27.5, 25, 25)];
    self.checkbox.tag = 1;
    self.checkbox.delegate = self;
    self.checkbox.rippleFromTapLocation = YES;
    self.checkbox.tapCirclePositiveColor = [UIColor HWMediumColor];
    self.checkbox.tapCircleNegativeColor = [UIColor HWLightColor];
    self.checkbox.checkmarkColor = [UIColor HWDarkColor];
    [self addSubview:self.checkbox];
}

- (void)loadAssignment: (HWAssignment *) assignment {
    self.checkbox.frame = CGRectMake(self.frame.size.width-40, 25, 30, 30);
    self.assignment = assignment;
    //self.colorLabel.backgroundColor = ;
    self.colorLabel.text = [assignment.course.name substringToIndex:1];
    self.nameLabel.text = assignment.name;
    self.courseLabel.text = assignment.course.name;
    NSArray *types = @[@"Homework", @"Project", @"Other"];
    self.typeLabel.text = types[assignment.type.intValue];
    self.dateAssignedLabel.text = assignment.dateAssigned.description;
}

- (void)paperCheckboxChangedState:(BFPaperCheckbox *)checkbox {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

@end
