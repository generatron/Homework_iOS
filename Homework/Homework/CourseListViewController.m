//
//  CourseListViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CourseListViewController.h"

@interface CourseListViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

@end

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Courses";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneButtonPressed:)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.tintColor = [UIColor HWDarkColor];
}

- (void)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseList.courses.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != self.courseList.courses.count) {
        HWCourse *course = self.courseList.courses[indexPath.row];
        UILabel *courseColor = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        courseColor.text = [course.name substringToIndex:1];
        courseColor.textColor = [UIColor whiteColor];
        courseColor.textAlignment = NSTextAlignmentCenter;
        courseColor.backgroundColor = course.color;
        courseColor.font = [UIFont systemFontOfSize:40 weight:UIFontWeightLight];
        courseColor.layer.cornerRadius = 20;
        courseColor.clipsToBounds = YES;
        [cell addSubview:courseColor];
        UILabel *courseName = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, self.view.frame.size.width-190, 30)];
        courseName.text = course.name;
        [cell addSubview:courseName];
        UILabel *coursePeriod = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, self.view.frame.size.width-190, 20)];
        coursePeriod.text = [NSString stringWithFormat:@"Period %d",course.period.intValue];
        coursePeriod.textColor = [UIColor lightGrayColor];
        coursePeriod.font = [UIFont systemFontOfSize:13];
        [cell addSubview:coursePeriod];
        UIButton *del = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 10, 100, 40)];
        del.tag = indexPath.row;
        [del setTitle:@"Delete" forState:UIControlStateNormal];
        [del setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [del addTarget:self action:@selector(deleteCourseButonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:del];
    }
    else {
        UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 40)];
        [add setTitle:@"Add New Course" forState:UIControlStateNormal];
        [add setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [add addTarget:self action:@selector(addCourseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:add];
    }
    return cell;
}

- (void)deleteCourseButonPressed:(UIButton *)sender {
    int index = (int)sender.tag;
    [self.courseList removeObjectFromCoursesAtIndex:index];
    [self save];
}

- (void)addCourseButtonPressed:(UIButton *)sender {
    AddCourseViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ac"];
    rootVC.delegate = self;
    rootVC.context = self.context;
    rootVC.modalPresentationStyle = UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:rootVC];
    self.animator.dragable = NO;
    self.animator.bounces = YES;
    self.animator.behindViewAlpha = 0.5;
    self.animator.behindViewScale = 1.0;
    self.animator.transitionDuration = 0.5;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    rootVC.transitioningDelegate = self.animator;
    [self presentViewController:rootVC animated:YES completion:nil];
}

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) NSLog(@"%@",error);
    [self.tableView reloadData];
}

#pragma mark addCourseVC delegate

- (void)addCourseViewControllerWillDismissWithResultCourse:(HWCourse *)course {
    [self.courseList addCoursesObject:course];
    [self save];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
