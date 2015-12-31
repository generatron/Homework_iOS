//
//  DayViewController.h
//  
//
//  Created by Chappy Asel on 12/24/15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ZFModalTransitionAnimator.h"
#import "HWCourse.h"
#import "AssignmentTableViewCell.h"
#import "RNGridMenu.h"
#import "AddDateViewController.h"

typedef NS_ENUM(NSInteger, DayViewControllerType) {
    DayViewControllerTypeAll = 0,
    DayViewControllerTypeMonday = 1,
    DayViewControllerTypeTuesday = 2,
    DayViewControllerTypeWednesday = 3,
    DayViewControllerTypeThurday = 4,
    DayViewControllerTypeFriday = 5,
    DayViewControllerTypeWeekend = 6,
    DayViewControllerTypeMore = 7,
};

@class DayViewController;

@protocol DayViewControllerDelegate <NSObject>
@required
- (void)tabUpdateRequestByDayViewController:(DayViewController *)dayVC;
@end

@interface DayViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, AssignmentTableViewCellDelegate, RNGridMenuDelegate, AddDateViewControllerDelegate>

@property id<DayViewControllerDelegate> delegate;

@property NSManagedObjectContext *context;
@property int currentDayOfTheWeek;
@property (nonatomic) DayViewControllerType type;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
