//
//  AddDateViewController.m
//  Homework
//
//  Created by Chappy Asel on 12/27/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "AddDateViewController.h"

@interface AddDateViewController ()

@end

@implementation AddDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dateType == 1) self.title = @"Add Assignment";
    else self.title = @"Add Assessment";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneButtonPressed:)];
    self.view.tintColor = [UIColor HWDarkColor];
}

- (void)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
