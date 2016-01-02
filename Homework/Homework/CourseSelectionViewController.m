//
//  CourseSelectionViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/31/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CourseSelectionViewController.h"
#import "HWCourseList.h"

NSString *const XLFormRowDescriptorTypeCourseSelection = @"XLFormRowDescriptorTypeCourseSelection";

@interface CourseSelectionViewController ()

@end

@implementation CourseSelectionViewController {
    HWCourseList *courseList;
    int selectedRow;
}

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Course";
    courseList = [HWCourseList fetchCurrentCourseList];
    [self determineSelectedRow];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return courseList.courses.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath.row == 0) {
        if (indexPath.row == selectedRow) cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *courseColor = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        courseColor.text = @"~";
        courseColor.textColor = [UIColor whiteColor];
        courseColor.textAlignment = NSTextAlignmentCenter;
        courseColor.backgroundColor = [UIColor colorWithRed:120/255.0 green:144/255.0 blue:156/255.0 alpha:1];
        courseColor.font = [UIFont systemFontOfSize:35 weight:UIFontWeightLight];
        courseColor.layer.cornerRadius = 20;
        courseColor.clipsToBounds = YES;
        [cell addSubview:courseColor];
        UILabel *courseName = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, self.view.frame.size.width-190, 30)];
        courseName.text = @"None";
        [cell addSubview:courseName];
        UILabel *coursePeriod = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, self.view.frame.size.width-190, 20)];
        coursePeriod.text = @"";
        coursePeriod.textColor = [UIColor lightGrayColor];
        coursePeriod.font = [UIFont systemFontOfSize:13];
        [cell addSubview:coursePeriod];
    } else {
        if (indexPath.row == selectedRow) cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else cell.accessoryType = UITableViewCellAccessoryNone;
        HWCourse *course = courseList.courses[indexPath.row-1];
        UILabel *courseColor = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        courseColor.text = [course.name substringToIndex:1];
        courseColor.textColor = [UIColor whiteColor];
        courseColor.textAlignment = NSTextAlignmentCenter;
        courseColor.backgroundColor = course.color;
        courseColor.font = [UIFont systemFontOfSize:35 weight:UIFontWeightLight];
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
    }
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    selectedRow = (int)indexPath.row;
    if (indexPath.row == 0) self.rowDescriptor.value = nil;
    else self.rowDescriptor.value = courseList.courses[indexPath.row-1];
    [self.tableView reloadData];
}

#pragma mark - helper methods

- (void)determineSelectedRow {
    if (self.rowDescriptor.value != nil) {
        for (int i = 0; i < courseList.courses.count; i++) {
            if ([courseList.courses[i] isEqual:self.rowDescriptor.value]) {
                selectedRow = i+1;
                break;
            }
        }
    }
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
