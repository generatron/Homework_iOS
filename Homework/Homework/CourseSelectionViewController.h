//
//  CourseSelectionViewController.h
//  Homework
//
//  Created by Chappy Asel on 12/31/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLForm.h"

extern NSString *const XLFormRowDescriptorTypeCourseSelection;

@interface CourseSelectionViewController : UIViewController <XLFormRowDescriptorViewController, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
