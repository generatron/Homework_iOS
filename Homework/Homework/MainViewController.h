//
//  MainViewController.h
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "ZFModalTransitionAnimator.h"
#import "AddDateViewController.h"
#import "DayViewController.h"

@interface MainViewController : ViewPagerController <ViewPagerDataSource, ViewPagerDelegate, AddDateViewControllerDelegate>


@end

