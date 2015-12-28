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

@interface AddDateViewController : XLFormViewController

@property int dateType;

@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@end
