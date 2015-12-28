//
//  AssignmentTableViewCell.h
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourse.h"

@interface AssignmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAssignedLabel;

@property HWAssignment *assignment;

- (void)loadAssignment: (HWAssignment *) assignment;

@end
