//
//  DateTableViewCell.h
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourse.h"
#import "BEMCheckBox.h"
#import "Canvas.h"

@class DateTableViewCell;

@protocol DateTableViewCellDelegate <NSObject>
@required
- (void)dateTableViewCellCompletedValueToggledForAssignment:(HWAssignment *)assignment;
- (void)dateTableViewCellNeedsMenuPopup:(DateTableViewCell *)cell atLocation: (CGPoint)location;
@end

@interface DateTableViewCell : UITableViewCell <BEMCheckBoxDelegate>

@property id <DateTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAssignedLabel;
@property (strong, nonatomic) BEMCheckBox *checkbox;

@property HWAssignment *assignment;
@property HWAssessment *assessment;

- (void)loadDate: (id)date;

@end
