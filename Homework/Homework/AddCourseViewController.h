//
//  AddCourseViewController.h
//  Homework
//
//  Created by Chappy Asel on 12/26/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWCourse.h"

@protocol AddCourseViewControllerDelegate <NSObject>
@required
- (void) addCourseViewControllerWillDismissWithResultCourse: (HWCourse *) course;
@end

@interface AddCourseViewController : UIViewController <UITextFieldDelegate>

@property id <AddCourseViewControllerDelegate> delegate;

@property NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITextField *courseNameInput;
@property (weak, nonatomic) IBOutlet UISlider *periodSlider;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end
