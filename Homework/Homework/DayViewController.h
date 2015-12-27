//
//  DayViewController.h
//  
//
//  Created by Chappy Asel on 12/24/15.
//
//

#import <UIKit/UIKit.h>

@interface DayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSUInteger *tabIndex;

@end
