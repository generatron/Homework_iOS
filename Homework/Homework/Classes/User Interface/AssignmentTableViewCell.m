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
}

- (void)loadAssignment: (HWAssignment *) assignment {
    self.assignment = assignment;
    //self.colorLabel.backgroundColor = ;
    self.colorLabel.text = [assignment.course.name substringToIndex:1];
    self.nameLabel.text = assignment.name;
    self.courseLabel.text = assignment.course.name;
    NSArray *types = @[@"Homework", @"Project", @"Other"];
    self.typeLabel.text = types[assignment.type.intValue];
    self.dateAssignedLabel.text = assignment.dateAssigned.description;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

@end
