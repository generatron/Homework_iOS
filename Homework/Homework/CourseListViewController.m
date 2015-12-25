//
//  CourseListViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "CourseListViewController.h"

@interface CourseListViewController ()

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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != self.courseList.courses.count) {
        
    }
    else {
        UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 40)];
        [add setTitle:@"Add New Course" forState:UIControlStateNormal];
        [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [add addTarget:self action:@selector(addCourseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:add];
    }
    return cell;
}

- (void)deleteClassButonPressed:(UIButton *)sender {
    int index = (int)sender.tag;
    NSLog(@"Delete %d",index);
}

- (void)addCourseButtonPressed:(UIButton *)sender {
    NSLog(@"Add");
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
