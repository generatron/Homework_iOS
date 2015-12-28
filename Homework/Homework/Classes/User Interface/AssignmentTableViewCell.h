//
//  AssignmentTableViewCell.h
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourse.h"
#import "BFPaperCheckbox.h"

@interface AssignmentTableViewCell : UITableViewCell <BFPaperCheckboxDelegate>

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAssignedLabel;
@property (strong, nonatomic) BFPaperCheckbox *checkbox;

@property HWAssignment *assignment;

- (void)loadAssignment: (HWAssignment *) assignment;

@end
