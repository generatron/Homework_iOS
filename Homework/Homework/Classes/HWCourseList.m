//
//  HWCourseList.m
//  Homework
//
//  Created by Chappy Asel on 12/20/15.
//  Copyright © 2015 CD. All rights reserved.
//

#import "HWCourseList.h"
#import "AppDelegate.h"

@implementation HWCourseList

+ (HWCourseList *) fetchCurrentCourseList {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWCourseList" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSMutableArray <HWCourseList *> *result = [[NSMutableArray alloc] initWithArray:
                                               [context executeFetchRequest:fetchRequest error:&error]];
    if (error) {
        NSLog(@"Unable to execute fetch request. Step 1");
        NSLog(@"%@, %@", error, error.localizedDescription);
        return nil;
    }
    else if (result.count == 0) {
        NSLog(@"No course lists found, creating new HWCourseList");
        HWCourseList *courseList = [NSEntityDescription insertNewObjectForEntityForName:@"HWCourseList" inManagedObjectContext:context];
        [context save:&error];
        if (error) {
            NSLog(@"Unable to execute fetch request. Step 2");
            NSLog(@"%@, %@", error, error.localizedDescription);
            return nil;
        }
        return courseList;
    }
    if (result.count > 1) NSLog(@"Too many courseLists, needs fix!");
    return result.firstObject;
}

- (void) save {
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"Unable to execute fetch request. Step 1");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
