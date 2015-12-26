//
//  CourseListViewController.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourseList.h"
#import "ZFModalTransitionAnimator.h"
#import "AddCourseViewController.h"

@interface CourseListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddCourseViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSManagedObjectContext *context;
@property HWCourseList *courseList;

@end
