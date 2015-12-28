//
//  AddDateViewController.h
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourseList.h"
#import "XLForm.h"

@protocol AddDateViewControllerDelegate <NSObject>
@required
- (void) addDateViewControllerWillDismissWithResultAssignment: (HWAssignment *) assignment;
- (void) addDateViewControllerWillDismissWithResultAssessment: (HWAssessment *) assessment;
@end

@interface AddDateViewController : XLFormViewController

@property id <AddDateViewControllerDelegate> delegate;

@property int dateType;

@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@end
