//
//  ViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "ViewController.h"
#import "HWCourseList.h"
#import "CourseListViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@property HWCourseList *courseList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Homework";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(settingsButtonPressed:)];
    self.courseList = [HWCourseList fetchCurrentCourseList];
}

- (IBAction)settingsButtonPressed:(id)sender {
    CourseListViewController *modalVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cl"];
    //modalVC.delegate = self;
    //modalVC.managedObjectContext = self.managedObjectContext;
    //modalVC.leagueController = self.leagueController;
    //modalVC.selectedLeague = self.currentLeague;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:modalVC];
    self.animator.dragable = YES;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.6;
    self.animator.behindViewScale = 0.95;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    //[self.animator setContentScrollView:modalVC.tableView];
    modalVC.transitioningDelegate = self.animator;
    [self presentViewController:modalVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
